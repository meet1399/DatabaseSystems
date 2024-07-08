/* 
Name: Meet Viral Shah (USC ID: 5581-277-75)
Database used: MySQL - Workbench
*/

USE COVIDTRACKER;

SET @start_date = '2023-01-05';
SET @end_date = '2023-01-20';

SELECT 'number of scans' AS stats_type,  
       (SELECT COUNT(*) 
        FROM Scan
        WHERE scan_date BETWEEN @start_date AND @end_date) AS stats_value
UNION
SELECT 'number of tests' AS stats_type,
      (SELECT COUNT(*)  
       FROM Test
       WHERE test_date BETWEEN @start_date AND @end_date) AS stats_value
UNION  
SELECT 'number of employees who self reported symptoms' AS stats_type,
      (SELECT COUNT(DISTINCT employee_id)
       FROM Symptom
       WHERE date_reported BETWEEN @start_date AND @end_date) AS stats_value
UNION
SELECT 'number of positive cases' AS stats_type,
      (SELECT COUNT(*)
       FROM PositiveCase
       WHERE case_date BETWEEN @start_date AND @end_date) AS stats_value