-- Attrition Rate
SELECT Attrition
	 , COUNT(*) AS cnt
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS pct # Over: defines a window(user-specified set of rows) within a query result set
  FROM employee
 GROUP
    BY Attrition;
    
-- Description of Age
SELECT AVG(AGE) # 36.9238
     , MIN(AGE) # 18
     , MAX(AGE) # 60
  FROM employee;
    
-- Attrition Rate by Age group
-- : Attrition Rate is the highest in 30s (35.86%), lowest in over 50s(7.59%)
SELECT
  CASE
	   WHEN Age < 25 THEN 'Under 25'
       WHEN Age BETWEEN 25 AND 30 THEN 'Late 20s'
       WHEN Age BETWEEN 30 AND 40 THEN '30s'
       WHEN Age BETWEEN 40 AND 50 THEN '40s'
       ELSE 'Over 50'
   END AS Age_group
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS att_rate
  FROM employee
 WHERE Attrition = 'Yes'
 GROUP
    BY Age_group
 ORDER
    BY att_rate DESC;

-- Description of Gender
-- : Male > Female
SELECT Gender
     , COUNT(Gender) AS cnt
  FROM employee
 GROUP
    BY gender;
    
-- Attrition Rate by Gender
-- : Attrition Rate of Male is almost 1.7 times higher than Female
SELECT Gender
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS att_rate
  FROM employee
 WHERE Attrition = 'Yes'
 GROUP
    BY Gender
 ORDER
    BY att_rate DESC;
  
-- Attrition Rate by Gender and MaritalStatus
-- : Single Male has the highest Attrition Rate
-- : Single > Married > Divorced
SELECT Gender
     , MaritalStatus
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS att_rate
  FROM employee
 WHERE Attrition = 'YES'
 GROUP
    BY Gender, MaritalStatus;

-- Description of DailyRate    
SELECT AVG(DailyRate)
     , MIN(DailyRate)
     , MAX(DailyRate)
  FROM employee;

-- Attrition Rate by DailyRate
-- : Attrition Ratet is the highest in '300 to 600', lowest in 'Under 300'
SELECT
  CASE
	   WHEN DailyRate < 300 THEN 'Under 300'
       WHEN DailyRate BETWEEN 300 AND 600 THEN '300 TO 600'
       WHEN DailyRate BETWEEN 600 AND 900 THEN '600 TO 900'
       WHEN DailyRate BETWEEN 900 AND 1200 THEN '900 TO 1200'
       ELSE 'Over 1200'
   END AS DailyRate_group
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS att_rate
  FROM employee
 WHERE Attrition = 'Yes'
 GROUP
    BY DailyRate_group
 ORDER
    BY att_rate DESC;

-- Average DailyRate by Education 
-- DailyRate is the highest in 'Below College' level, lowest in 'Bachelor' level   
SELECT Education
     , AVG(DailyRate) AS avg_DR
  FROM employee
 GROUP
    BY Education
 ORDER
    BY avg_DR DESC;

-- Daily Working Hours 
SELECT AVG(DailyWorkingHours)
     , MIN(DailyWorkingHours)
     , MAX(DailyWorkingHours)
  FROM (SELECT DailyRate / HourlyRate AS DailyWorkingHours
          FROM employee) AS A;  
          
-- Attrition Rate by Daily working hours
SELECT
  CASE
	   WHEN DailyWorkingHours < 4 THEN 'Under 4'
       WHEN DailyWorkingHours BETWEEN 4 AND 8 THEN '4 TO 8'
       WHEN DailyWorkingHours BETWEEN 8 AND 12 THEN '8 TO 12'
       WHEN DailyWorkingHours BETWEEN 12 AND 16 THEN '12 TO 16'
       WHEN DailyWorkingHours BETWEEN 16 AND 20 THEN '16 TO 20'
       ELSE 'Over 20'
   END AS DailyWorkingHours_group
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS att_rate
  FROM (SELECT DailyRate / HourlyRate AS DailyWorkingHours
		     , Attrition
          FROM employee) AS A
 WHERE Attrition = 'Yes'
 GROUP
    BY DailyWorkingHours_group
 ORDER
    BY att_rate DESC;
    
-- JobSatisfaction and Attrition Rate by JobRole
-- Employees with Human Resources job have the lowest Job Satisfaction but the lowest attrition rate
-- Employees with Sales Execuctive job have third highest Job Satisfaction but the highest attrition rate
-- Research Scientists have the second highest Job Satisfaction and the second highest attrition rate
SELECT JobRole
	 , AVG(JobSatisfaction)
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS att_rate
  FROM employee
 GROUP
    BY JobRole
 ORDER
    BY AVG(JobSatisfaction);
