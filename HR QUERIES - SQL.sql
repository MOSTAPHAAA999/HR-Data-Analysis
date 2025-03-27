
SELECT 
    AVG(CAST(Age AS INT)) AS AvgAge, 
    MAX(CAST(Age AS INT)) AS HighestAge, 
    MIN(CAST(Age AS INT)) AS LowestAge
FROM Employee;
--1. Average Age, Highest, and Lowest Age


SELECT top 1
    Department, 
    JobRole, 
    MAX(CAST(Salary AS DECIMAL(10, 2))) AS HighestSalary
FROM Employee
GROUP BY Department, JobRole
ORDER BY HighestSalary DESC
--2 Highest Department Salary and Job Role

SELECT 
    Ethnicity, 
    AVG(CAST(Salary AS DECIMAL(10, 2))) AS AvgSalary
FROM 
    Employee
GROUP BY 
    Ethnicity;
--3.	هل كل العرقيات بتاخد الافريدج زي بعض ولا لا ؟


SELECT 
    State, 
    COUNT(EmployeeID) AS EmployeeCount, 
    AVG(CAST(Salary AS DECIMAL(10, 2))) AS AvgSalary
FROM Employee
GROUP BY State;
--4 State by Salary and Count of Employees

SELECT 
    E.EducationLevel, 
    AVG(CAST(Empl.Salary AS DECIMAL(10, 2))) AS AvgSalary
FROM EducationLevel E
JOIN Employee Empl ON E.EducationLevelID = Empl.Education
GROUP BY E.EducationLevel;
--5 Correlation Between Education Levels and Salary

SELECT top 1 
    Department, 
    JobRole, 
    MAX(CAST(Salary AS DECIMAL(10, 2))) AS HighestSalary
FROM Employee
GROUP BY Department, JobRole
ORDER BY HighestSalary DESC
--6 Most Paid Role and Department

SELECT 
    MaritalStatus, 
    COUNT(EmployeeID) AS Count, 
    AVG(CAST(Salary AS DECIMAL(10, 2))) AS AvgSalary
FROM Employee
GROUP BY MaritalStatus;
--7. Correlation Between Status and Salaries



SELECT 
    SUM(CAST(Salary AS DECIMAL(10, 2))) AS TotalSalaries
FROM Employee;
--9. Total Salaries + Correlation Between Distance from Home and Overtime


SELECT 
    YEAR(HireDate) AS HireYear, 
    COUNT(EmployeeID) AS EmployeeCount
FROM Employee
GROUP BY YEAR(HireDate)
ORDER BY HireYear;
--10. Hire Date by Count of Employees (Line Chart)


SELECT 
    COUNT(EmployeeID) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TerminatedEmployees
FROM Employee;
--11. Count of Employees, Count of Terminated Employees

SELECT top 1
    YEAR(HireDate) AS TurnoverYear, 
    COUNT(EmployeeID) AS TurnoverCount
FROM Employee
WHERE Attrition = 'Yes'
GROUP BY YEAR(HireDate)
ORDER BY TurnoverCount DESC
--12. Most Turnover Year

SELECT 
    Gender, 
    AVG(CAST(Salary AS DECIMAL(10, 2))) AS AvgSalary
FROM Employee
GROUP BY Gender;
--13. Salaries by Male and Female

SELECT 
    AVG(CAST(YearsAtCompany AS INT)) AS AvgYearsAtCompany
FROM Employee;
--14. Average Years at the Company

SELECT 
    MaritalStatus, 
    AVG(CAST(YearsAtCompany AS INT)) AS AvgYearsAtCompany
FROM Employee
GROUP BY MaritalStatus;

--15. Correlation Between Years at the Company and martital status



SELECT 
    Department, 
    AVG(CAST(YearsSinceLastPromotion AS DECIMAL(10, 2))) AS AvgYearsSinceLastPromotion
FROM 
    Employee
GROUP BY 
    Department
ORDER BY 
    AvgYearsSinceLastPromotion ASC;
--17.	القسم اللي الناس في بتترقى اسرع


SELECT 
    State, 
    AVG(CAST(Age AS DECIMAL(10, 2))) AS AvgAge
FROM 
    Employee
GROUP BY 
    State;
--18.	State with age


SELECT 
    E.MaritalStatus, 
    AVG(CAST(PR.WorkLifeBalance AS DECIMAL(10, 2))) AS AvgWorkLifeBalance
FROM PerformanceRating PR
JOIN Employee E ON PR.EmployeeID = E.EmployeeID
GROUP BY E.MaritalStatus;
--19. Correlation Between Work-Life Balance and Marital Status


SELECT 
    E.JobRole, PR.ManagerRating
    ,AVG(CAST(E.YearsSinceLastPromotion AS INT)) AS AvgYearsSincePromotion
FROM PerformanceRating PR
JOIN Employee E ON PR.EmployeeID = E.EmployeeID
GROUP BY  E.JobRole, PR.ManagerRating;
--20. Correlation Between Manager Rating and Promotion


SELECT 
    EmployeeID, 
    AVG(SelfRating) SelfRating , AVG(ManagerRating) AS ManagerRating
FROM PerformanceRating
group by EmployeeID;
--21. Difference Between Self-Rating and Manager Rating


SELECT 
    PR.TrainingOpportunitiesTaken, 
    AVG(CAST(E.Salary AS DECIMAL(10, 2))) AS AvgSalary
FROM PerformanceRating PR
JOIN Employee E ON PR.EmployeeID = E.EmployeeID
GROUP BY PR.TrainingOpportunitiesTaken;
--22. Training Opportunities Taken and Salaries or Promotion




/*Departments & Job_Role with Highest Salary*/
select (Department) , 
sum(salary) as Highest_salary
from Employee 
Group by Department 
order by sum(salary) desc

select (jobrole) ,
AVG (salary) as Highest_salary
from Employee 
Group by jobrole  
order by AVG (salary) desc


/* Top 5 Employee Salaries */
select top 5 FirstName , LastName,  department , Jobrole, salary
from Employee	
group by  FirstName , LastName,  department , Jobrole, salary
order by Salary desc


/*Ethnicity and Salary*/

SELECT Ethnicity,EducationField,EducationLevel, 
AVG(Salary) AS Highest_Salary
FROM Employee
JOIN EducationLevel ON Employee.Education = EducationLevel.EducationLevelID
GROUP BY Ethnicity, EducationField, EducationLevel
order by AVG(Salary) desc



/*state by salary and count of empolyees*/

SELECT State, 
COUNT(EmployeeID) AS Employees, 
SUM(CAST(Salary AS DECIMAL)) AS Total_Salary 
FROM Employee
GROUP BY State
order by SUM(CAST(Salary AS DECIMAL)) desc


WITH TotalEmployees AS (SELECT State, 
COUNT(EmployeeID) AS TotalEmployees
FROM Employee
GROUP BY State)
SELECT E.State, 
COUNT(E.EmployeeID) AS Employees, 
TotalEmployees,
CAST(ROUND((COUNT(E.EmployeeID) * 100.0 / TotalEmployees), 3) AS DECIMAL(5,3)) AS Percentage,
E.Ethnicity,
SUM(CAST(E.Salary AS DECIMAL)) AS Total_Salary
FROM Employee E
JOIN TotalEmployees T ON E.State = T.State
GROUP BY E.State, E.Ethnicity, TotalEmployees
ORDER BY COUNT(E.EmployeeID)


/*Correlation Between Education Levels and Salary*/
SELECT 
FirstName, 
LastName, 
EducationField, 
JobRole,
EducationLevel, 
SUM(CAST(E.Salary AS DECIMAL)) AS Salary
FROM 
Employee E
JOIN 
EducationLevel ED ON E.Education = ED.EducationLevelID
GROUP BY 
FirstName, 
LastName, 
EducationField,
JobRole,
EducationLevel
ORDER BY Salary

/*Most Paid Role by Department*/
select*
from employee

SELECT Department, JobRole, MAX(Salary) AS Highest_Salary
FROM Employee 
GROUP BY Department, JobRole
ORDER BY MAX(Salary) DESC

/*Pie Chart of Marital Status*/
SELECT MaritalStatus, COUNT(EmployeeID) AS Employees
FROM Employee
GROUP BY MaritalStatus

/*Correlation Between Marital Status and Salaries*/
SELECT MaritalStatus,AVG(CAST(Salary AS DECIMAL(10, 2))) AS AverageSalary
FROM Employee
GROUP BY MaritalStatus

/*Correlation Between MaritalStatus, Over Time and Distance from Home*/
SELECT [DistanceFromHome (KM)], Overtime 
FROM Employee
GROUP BY [DistanceFromHome (KM)], Overtime



/*Hire Date by Count of Employees*/

SELECT 
YEAR(HireDate) AS HireYear,COUNT(EmployeeID) AS EmployeeCount
FROM Employee
GROUP BY YEAR(HireDate)
ORDER BY HireYear


/* Count of Employees and Terminated Employees (Gender)*/
SELECT 
SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS ActiveEmployees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TerminatedEmployees,
COUNT(EmployeeID) AS TotalEmployees
FROM 
Employee 

SELECT Gender,
SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS ActiveEmployees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS TerminatedEmployees,
COUNT(EmployeeID) AS TotalEmployees
FROM Employee 
GROUP BY Gender


SELECT 
    e.Gender,
    COUNT(e.EmployeeID) AS TotalEmployees,
    SUM(CASE WHEN e.Attrition = 'Yes' THEN 1 ELSE 0 END) AS TerminatedEmployees,
    SUM(CASE WHEN e.Attrition = 'No' THEN 1 ELSE 0 END) AS ActiveEmployees,
    CAST(SUM(CASE WHEN e.Attrition = 'Yes' THEN 1 ELSE 0 END) AS DECIMAL(10,2)) * 100.0 / COUNT(e.EmployeeID) AS TerminatedPercentage,
    CAST(SUM(CASE WHEN e.Attrition = 'No' THEN 1 ELSE 0 END) AS DECIMAL(10,2)) * 100.0 / COUNT(e.EmployeeID) AS ActivePercentage
FROM 
    Employee e
GROUP BY 
    e.Gender;

	 







