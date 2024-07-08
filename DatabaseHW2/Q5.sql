/* 
Name: Meet Viral Shah (USC ID: 5581-277-75)
Database used: MySQL - Workbench
*/

USE COVIDTRACKER;

SELECT DISTINCT E.id AS employee_id, 
E.employee_name, 
PM2.employee_id AS positive_contact_id, 
PM2.employee_name AS positive_contact_name, 
PM2.meeting_id
FROM Employee E
JOIN (
    SELECT DISTINCT M.employee_id, M.meeting_id
    FROM Meeting M
    JOIN (
        SELECT M1.meeting_id, M1.employee_id 
        FROM Meeting M1
        JOIN PositiveCase PC 
        ON M1.employee_id = PC.employee_id
    ) PM 
    ON M.meeting_id = PM.meeting_id 
    AND M.employee_id <> PM.employee_id
    WHERE NOT EXISTS (
        SELECT N.employee_id
        FROM Notification N
        WHERE N.employee_id = M.employee_id
        AND N.notification_type = 'mandatory'
    )
) PM1 ON E.id = PM1.employee_id
JOIN (
    SELECT DISTINCT M2.meeting_id, M2.employee_id, E1.employee_name
    FROM Meeting M2
    JOIN PositiveCase PC1 
    ON M2.employee_id = PC1.employee_id
    JOIN Employee E1 
    ON E1.id = M2.employee_id
) PM2 ON PM2.meeting_id = PM1.meeting_id;

