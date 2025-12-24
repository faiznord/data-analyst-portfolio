LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HR_1.csv' 
INTO TABLE hr1 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/HR_2.csv' 
INTO TABLE hr2
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/*
Average Attrition rate for all Departments

Average Hourly rate of Male Research Scientist

Attrition rate Vs Monthly income stats

Average working years for each Department

Job Role Vs Work life balance

Attrition rate Vs Year since last promotion relation


*/
select * from hr2 limit 10;

-- Average Attrition rate for all Departments
SELECT Department,
  concat(round((COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) / 
   COUNT(*)) * 100,2),"%") AS attrition_rate
FROM hr1
group by Department;

-- Average Hourly rate based on JOb Role
select JobRole, round(avg(HourlyRate),2)
from hr1
group by JobRole;





-- Attrition rate Vs Monthly income stats
with cte as
 (SELECT  Department,round(avg(hr2.MonthlyRate),2) as AvgMonthlyRate,
  concat(round((COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) / 
   COUNT(*)) * 100,2),"%") AS attrition_rate
FROM hr1 join hr2 on hr1.EmployeeNumber= hr2.Employee_ID
group by Department)
select Department, attrition_rate, AvgMonthlyRate  from cte;



-- Average working years for each Department
select Department, round(avg(TotalWorkingYears),2)
FROM hr1 join hr2 on hr1.EmployeeNumber= hr2.Employee_ID
group by Department;




-- Job Role Vs Work life balance
select JobRole, round(avg(WorkLifeBalance),2)
FROM hr1 join hr2 on hr1.EmployeeNumber= hr2.Employee_ID
group by JobRole;






-- Attrition rate Vs Year since last promotion relation
with cte as
 (SELECT  Department,round(avg(hr2.YearsSinceLastPromotion),2) as YearsSinceLastPromotion,
  concat(round((COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) / 
   COUNT(*)) * 100,2),"%") AS attrition_rate
FROM hr1 join hr2 on hr1.EmployeeNumber= hr2.Employee_ID
group by Department)
select Department, attrition_rate, YearsSinceLastPromotion from cte;
