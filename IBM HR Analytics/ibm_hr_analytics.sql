-- Attrition Rate
SELECT Attrition
	 , COUNT(*) AS cnt
     , ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS pct # Over: defines a window(user-specified set of rows) within a query result set
  FROM employee
 GROUP
    BY Attrition;
    
-- Description of Age
SELECT AVG(AGE)
     , MIN(AGE)
     , MAX(AGE)
  FROM employee;
    
-- Attrition Rate by Age group
-- : Attrition Rate is the highest in 30s, lowest in over 50s
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
    