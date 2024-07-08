/* 
Name: Meet Viral Shah (USC ID: 5581-277-75)
Database used: MySQL - Workbench
*/

USE COVIDTRACKER;

SELECT e.floor_number, COUNT(*) AS sick_count
FROM Employee e  
JOIN HealthStatus hs ON e.id = hs.employee_id
JOIN 
(
  SELECT employee_id, MAX(status_date) AS latest_date
  FROM HealthStatus
  GROUP BY employee_id
) l on l.employee_id = hs.employee_id AND l.latest_date = hs.status_date
JOIN PositiveCase pc ON e.id = pc.employee_id AND pc.resolution = 'quarantined'
WHERE hs.status in ('sick','hospitalized')
GROUP BY e.floor_number
ORDER BY sick_count DESC
LIMIT 1;