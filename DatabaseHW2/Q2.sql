/* 
Name: Meet Viral Shah (USC ID: 5581-277-75)
Database used: MySQL - Workbench
*/

USE COVIDTRACKER;

SELECT s.symptom_id, COUNT(*) AS reported_count
FROM Symptom s
GROUP BY s.symptom_id
ORDER BY reported_count DESC
LIMIT 1;