CSCI 585 Database Systems 
By Prof. Say Raghavachary

Homework 2 Readme

Name: Meet Viral Shah
USC ID: 5581-2770-75


Database Used: MySQL Workbench (latest version)


Q1) Assumptions and conclusions while creating tables:
---------------------------------------------------

1. Employee table:

- It stores employee information, including their ID, name, office number, floor number, phone number, and email address.
- The id column is the primary key, ensuring each employee has a unique identifier.
- employee_name must have a non-empty value.
- office_number represents the employee's office location.
- floor_number indicates the floor where the employee works, with a valid range between 1 and 10.
- phone_number stores the employee's contact number.
- email_address can store the employee's email, but it is optional.
- The table enforces the constraint that floor_number must be between 1 and 10.

2. Meeting table:

- Meeting table tracks meetings attended by employees, including details such as room number, floor number, start time, and constraints to ensure data integrity.
- meeting_id: An integer that identifies each meeting.
- employee_id: An integer representing the employee attending the meeting.
- room_number: An integer specifying the room number where the meeting took place.
- floor_number: An integer indicating the floor number where the meeting room is located (restricted to floors 1 through 10).
- start_time: An integer representing the start time of the meeting, constrained to be between 8 AM and 6 PM (8 to 18 in military time).
- Foreign Key: The employee_id field is linked to the id field in the Employee table, ensuring that only valid employee IDs can be associated with meetings.
- Primary Key: The combination of meeting_id and employee_id forms a composite primary key, ensuring that each meeting-employee pair is unique.

3. Notification table:

- It contains information about notifications sent to employees.
- Each notification is identified by a unique "notification_id."
- Each notification is associated with a specific employee using "employee_id."
- It records the date when the notification was sent as "notification_date."
- The "notification_type" field specifies whether the notification is 'mandatory' or 'optional.'
- It enforces a foreign key constraint with the "Employee" table using "employee_id."
- The primary key consists of a combination of "notification_id" and "employee_id," ensuring uniqueness as same notification can be sent to multiple employees at once.

4. Symptom table:

- row_id: A unique identifier for each symptom report (auto-incremented).
- employee_id: Identifies the employee who reported the symptom (cannot be null).
- date_reported: The date on which the symptom was reported (cannot be null).
- symptom_id: Identifies the specific symptom reported (must be between 1 and 5).
- Constraint: The symptom_id is limited to values between 1 and 5.
- Constraint: The employee_id references the Employee table, ensuring valid employee references.

5. Scan table:

- scan_id: Primary key for uniquely identifying each temperature scan record.
- scan_date: Date when the temperature scan was performed, ensuring it's not empty.
- scan_time: Time of the day when the temperature scan was taken, restricted to be between 0 and 23 (representing hours from midnight to 11 PM).
- employee_id: Identifies the employee for whom the temperature scan was taken, referenced  to the Employee table.
- temperature: Records the temperature reading with precision up to two decimal places, indicating the employee's body temperature.
- Foreign key constraint: Ensures that the employee_id in the Scan table references a valid employee ID in the Employee table, maintaining data integrity.

6. Test table:

- test_id is the primary key, uniquely identifying each test record.
- location is a mandatory field specifying where the test was conducted (e.g., clinic, hospital).
- test_date is a mandatory field indicating the date when the test was performed.
- test_time is a mandatory field representing the time of day (in hours) when the test was taken (ranging from 0 to 23, representing 12 AM to 11 PM).
- employee_id is a mandatory foreign key referencing the ID of the employee who took the test.
- test_result is an enumeration ('positive' or 'negative') indicating the outcome of the COVID-19 test.
- The test_time is constrained to be within the valid range of hours (0 to 23).

7. PositiveCase table:

- The PositiveCase table stores information about employees who have tested positive for COVID-19, including their case details and resolutions. 
- Each case is linked to one employee id, update in case status will be made in the same entry.
- case_id: A unique identifier for each positive case.
- employee_id: The ID of the employee who tested positive, linking to the Employee table.
- case_date: The date when the positive case was recorded.
- resolution: Describes the resolution for the case, which can be one of four options: 'back to work,' 'left the company,' 'deceased,' or 'quarantined.' This represents the outcome or status of the employee following the positive test result.
- quarantined as a resolution status was added extra to keep track of the status of employee who are still sick.
- FOREIGN KEY (employee_id) REFERENCES Employee(id): Ensures that the employee_id in the PositiveCase table references a valid employee ID in the Employee table, maintaining data integrity.

8. HealthStatus table:

- row_id: A unique identifier for each health status entry, automatically incremented.
- employee_id: Identifies the employee to whom the health status belongs.
- status_date: Records the date when the health status was reported.
- status: Indicates the employee's health status, which can be one of 'sick,' 'hospitalized,' or 'well.'
- Foreign Key Constraint: Ensures that employee_id references the id column in the Employee table, maintaining data integrity by linking each health status entry to a valid employee.




Logic used in rest of the questions:
------------------------------------

Q2) 


Code: 
SELECT s.symptom_id, COUNT(*) AS reported_count
FROM Symptom s
GROUP BY s.symptom_id
ORDER BY reported_count DESC
LIMIT 1;


-> SELECT s.symptom_id, COUNT(*) AS reported_count: This part of the query selects two columns from the Symptom table. The first column is symptom_id, representing the ID of the reported symptom, and the second column calculates the count of occurrences of each symptom and aliases it as reported_count.

-> FROM Symptom s: This specifies that the data is being retrieved from the Symptom table and assigns it the alias s for brevity.

-> GROUP BY s.symptom_id: The query groups the rows in the Symptom table based on the symptom_id. This means it will group together all the rows that report the same symptom.

-> ORDER BY reported_count DESC: After grouping, the results are ordered in descending order based on the count of reported symptoms. This means the symptom with the highest count will appear at the top.

-> LIMIT 1: Finally, the query limits the output to just one row, which will be the symptom with the highest count because of the descending order. In other words, it finds the most commonly reported COVID-19 symptom.

-> So, the result of this query will be a single row indicating the ID of the most commonly reported symptom (in symptom_id) and the count of how many times it has been reported (in reported_count).


------------------------------------


Q3)


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


-> The query starts by selecting the floor_number and counting the number of employees who meet certain criteria.

-> It uses the Employee table (e) and joins it with the HealthStatus table (hs) on the employee's ID (e.id matches hs.employee_id). This step links employees to their respective health statuses.

-> Inside a subquery, it calculates the latest status update date (latest_date) for each employee by grouping health statuses by employee ID and selecting the maximum status date. This subquery helps identify the most recent health status update for each employee.

-> The main query then joins this subquery (l) with the HealthStatus table again to filter out only the latest health status updates for each employee (l.employee_id = hs.employee_id AND l.latest_date = hs.status_date).

-> It also joins the PositiveCase table (pc) to identify employees who have been quarantined (pc.resolution = 'quarantined') due to a positive COVID-19 case.

-> The WHERE clause filters the results further, selecting only employees with a health status of 'sick' or 'hospitalized'.

-> The results are grouped by floor_number to count the number of sick or hospitalized employees on each floor.

-> The ORDER BY clause sorts the results in descending order based on the count of sick or hospitalized employees (sick_count).

-> Finally, the LIMIT 1 clause ensures that only the top result (the floor with the highest count) is returned.


------------------------------------


Q4)

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


-> SET @start_date = '2023-01-05' and SET @end_date = '2023-01-20': These two lines set the values of two variables, @start_date and @end_date, which represent the start and end dates of the desired date range.

-> SELECT 'number of scans' AS stats_type, ...: This part of the query selects the count of scans within the specified date range and labels it as 'number of scans.'

-> The subquery (SELECT COUNT(*) FROM Scan WHERE scan_date BETWEEN @start_date AND @end_date) counts the rows in the Scan table where the scan_date falls within the given date range.

-> UNION: The UNION operator combines the results of multiple SELECT statements into a single result set.

-> SELECT 'number of tests' AS stats_type, ...: This part of the query selects the count of COVID-19 tests conducted within the specified date range and labels it as 'number of tests.'

-> The subquery (SELECT COUNT(*) FROM Test WHERE test_date BETWEEN @start_date AND @end_date) counts the rows in the Test table where the test_date is within the specified date range.

-> SELECT 'number of employees who self-reported symptoms' AS stats_type, ...: This part of the query selects the count of employees who self-reported COVID-19 symptoms within the specified date range and labels it as 'number of employees who self-reported symptoms.'

-> The subquery (SELECT COUNT(DISTINCT employee_id) FROM Symptom WHERE date_reported BETWEEN @start_date AND @end_date) counts the distinct employee IDs in the Symptom table for reports made within the specified date range.

-> SELECT 'number of positive cases' AS stats_type, ...: This part of the query selects the count of positive COVID-19 cases within the specified date range and labels it as 'number of positive cases.'

-> The subquery (SELECT COUNT(*) FROM PositiveCase WHERE case_date BETWEEN @start_date AND @end_date) counts the rows in the PositiveCase table where the case_date falls within the given date range.


------------------------------------


Q5) 

Question : Find the list of employee id and name who were part of meetings with employees who tested covid positive but did not receive a mandatory notification. Also display the id and name of covid positive person with whom they were in meeting with as well as its meeting id.



Query : 


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



-> SELECT DISTINCT E.id AS employee_id, E.employee_name, ...: This part of the query selects the distinct employee ID, employee name, positive contact ID, positive contact name, and meeting ID.

-> FROM Employee E: The main query starts by selecting data from the Employee table and assigns it the alias E.

-> The first subquery (PM1): 
	This subquery finds employees who were part of meetings with other employees who tested positive for COVID-19 but did not receive a mandatory notification. 
	SELECT DISTINCT M.employee_id, M.meeting_id retrieves the employee IDs and meeting IDs of employees who were in meetings.
	The subquery includes a join with another subquery (PM), which finds employees who tested positive for COVID-19 by joining the Meeting and PositiveCase tables.
	The WHERE NOT EXISTS clause checks if there is no mandatory notification for these employees to ensure they did not receive a mandatory notification.
	The results of this subquery are assigned the alias PM1.

-> JOIN ... ON E.id = PM1.employee_id: The main query joins the Employee table (E) with the results of the first subquery (PM1) using the employee_id.

-> The second subquery (PM2):
	This subquery finds information about the COVID-19 positive person (employee) and their meetings.
	SELECT DISTINCT M2.meeting_id, M2.employee_id, E1.employee_name retrieves the meeting IDs, employee IDs, and employee names of those who tested positive for COVID-19.
	It also includes joins with the Meeting and PositiveCase tables to get the required information.
	The results of this subquery are assigned the alias PM2.

-> JOIN ... ON PM2.meeting_id = PM1.meeting_id: Finally, the main query joins the results of the second subquery (PM2) with the results of the first subquery (PM1) using the meeting_id. This connects employees with the positive contacts they were in meetings with.

-> The query combines these subqueries and joins to provide a list of employees who met with COVID-19 positive individuals but did not receive a mandatory notification. It also includes information about the positive contact's name, ID, and the meeting ID where the contact occurred.


The last query is useful for effective analysis in the context of COVID-19 contact tracing within a workplace. Here's how it provides valuable insights and facilitates analysis:

i) Identification of At-Risk Employees: The query identifies employees who were in close proximity to coworkers who tested positive for COVID-19. This information is crucial for identifying individuals who may be at higher risk of exposure to the virus.

ii) Notification Effectiveness Assessment: By checking if these employees received mandatory notifications, the query helps assess the effectiveness of the notification system. If employees who were in contact with COVID-19 positive coworkers did not receive mandatory notifications, it could indicate potential gaps in the communication process that need improvement.

iii) Isolation and Testing Prioritization: Knowing which employees were in contact with positive cases allows for prioritizing them for testing or isolation measures. It helps in managing and containing the spread of the virus within the workplace more effectively.

iv) Contact Tracing: The query supports contact tracing efforts by providing a list of employees who had contact with COVID-19 positive individuals. This is vital for tracking the potential transmission of the virus happened through which employee and part of which meeting room. 




