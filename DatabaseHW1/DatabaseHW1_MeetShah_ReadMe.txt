CSCI 585 Database Systems 
By Prof. Say Raghavachary

Homework 1 Readme

Name: Meet Viral Shah
USC ID: 5581-2770-75


Based on the ER diagram, here is a description of each entity and its attributes:

EMPLOYEE:
- EMPLOYEE_ID (PK): Unique identifier for each employee  
- EMPLOYEE_NAME: Name of the employee
- SMARTPHONE_NUMBER: Mobile number of employee
- EMAIL_ADDRESS: Email address of employee which is optional
- FLOOR_NUMBER (FK): Foreign key referencing Floor table

EMPLOYEE_ID is the primary key since it uniquely identifies each employee. FLOOR_NUMBER indicates which floor the employee works on.

FLOOR:
- FLOOR_NUMBER (PK): Unique identifier for each floor
- NUMBER_OF_ROOMS: Total number of rooms on the floor

FLOOR_NUMBER is the primary key since it uniquely identifies each floor.

ROOM:
- ROOM_NUMBER (PK): Unique identifier for each room
- FLOOR_NUMBER (FK): Foreign key referencing Floor table

ROOM_NUMBER is the primary key since it uniquely identifies each room. FLOOR_NUMBER indicates which floor the room is on.

MEETING: 
- MEETING_ID (PK): Unique identifier for each meeting
- LIST_OF_EMPLOYEE_IDS (FK1): Foreign key referencing Employee table
- MEETING_ROOM_NUMBER (FK2): Foreign key referencing Room table
- MEETING_DATE: Date when meeting was held
- MEETING_START_TIME: Meeting start time 
- MEETING_END_TIME: Meeting end time

MEETING_ID is the primary key since it uniquely identifies each meeting record. LIST_OF_EMPLOYEE_IDS and MEETING_ROOM_NUMBER are foreign keys to link the meeting to the employees who attended and the room where it was held.

SYMPTOM:
- SYMPTOM_ID (PK): Unique identifier for each symptom
- EMPLOYEE_ID (FK): Foreign key referencing Employee table
- SYMPTOM_NAME: Name of the symptom (e.g. fever, cough, etc.)

SYMPTOM_ID is the primary key since it uniquely identifies each symptom record. EMPLOYEE_ID links the symptom to the employee who reported it.

TEMPERATURE SCAN:
- SCAN_ID (PK): Unique identifier for each temperature scan  
- TEMPERATURE: Recorded temperature during scan
- SCAN_TIMESTAMP: Date/time when scan was taken
- FEVER_DETECTED: Whether fever was detected during scan
- EMPLOYEE_ID (FK): Foreign key referencing Employee table

SCAN_ID is the primary key since it uniquely identifies each temperature scan record. EMPLOYEE_ID links the scan to the employee.

COVID 19 TEST:
- TEST_ID (PK): Unique identifier for each test 
- EMPLOYEE_ID (FK1): Foreign key referencing Employee table  
- TEST_TYPE: Type of COVID test (e.g. PCR, antigen)
- TEST_RESULT: Result of the test (positive/negative) 
- TEST_LOCATION: Where the test was administered (onsite/offsite)
- IS_SELF_REPORT: Whether test result was self-reported (yes/no)
- TEST_DATE: Date the test was taken
- SCAN_ID (FK2): Foreign key referencing Temperature Scan table
- LIST_OF_SYMPTOM_IDS (FK3): Foreign key referencing Symptom table 

TEST_ID is the primary key since it uniquely identifies each test record. EMPLOYEE_ID, SCAN_ID, and LIST_OF_SYMPTOM_IDS are foreign keys to link the test to the employee who took the test, their temperature scan, and any reported symptoms.

CONTACT TRACING:
- TRACING_ID (PK): Unique identifier for each contact tracing record  
- EMPLOYEE_ID (FK1): Foreign key referencing Employee table
- START_DATE: Date when tracing started
- END_DATE: Date when tracing ended
- MEETING_ID (FK2): Foreign key referencing Meeting table

TRACING_ID is the primary key since it uniquely identifies each contact tracing record. EMPLOYEE_ID and MEETING_ID are foreign keys to link the tracing to the employee and any meetings they may have attended.


NOTIFICATIONS:
- NOTIFICATION_ID (PK): Unique identifier for each notification 
- NOTIFICATION_TYPE: Type of notification (e.g. phone call/emails/message)  
- TRACING_ID (FK): Foreign key referencing Contact Tracing table

NOTIFICATION_ID is the primary key since it uniquely identifies each notification record. TRACING_ID links the notification to the related contact tracing that triggered the notification.


HEALTH STATUS:
- STATUS_ID (PK): Unique identifier for each status record
- STATUS: Health status of employee (e.g. sick, hospitalized, well, deceased)
- LAST_MODIFIED: Date health status was last updated
- EMPLOYEE_ID (FK): Foreign key referencing Employee table  

STATUS_ID is the primary key since it uniquely identifies each health status record. EMPLOYEE_ID links the status to the employee.


Explanation of the relationships between entities and why the cardinality was chosen:
•    Employee HAS Health Status: One-to-One - Each employee can only have one health status record.
•    Employee WORKS ON Floor: Many-to-One - Multiple employees can work on the same floor.
•    Employee ATTENDS Meeting: Many-to-Many - Multiple employees can attend the same meeting, and an employee can attend multiple meetings.
•    Meeting IS HELD IN Room: Many-to-One - A meeting takes place in only one room, but many meetings can be in the same room.
•    Employee REPORTS Symptom: One-to-many - An employee can report multiple symptoms, but a symptom is reported by only one employee.
•    Employee DOES Temperature Scan: One-to-many - An employee can have multiple temperature scans, but a scan is for only one employee.
•    Employee RANDOMLY TAKES Covid19 Test: One-to-many - An employee can be asked randomly take multiple tests, but a test is taken by only one employee.
•    Temperature Scan RESULTS INTO Covid19 Test: One-to-One - A temperature scan if detects fever can result into only one test.
•    Symptoms RESULTS INTO Covid19 Test: Many-to-One - Many reported symptoms can lead to one test.
•    Covid19 Test TRIGGERS Contact Tracing: One-to-One - A single test can trigger a single contract trigger.
•    Contact Tracing SENDS Notifications: One-to-many - A single contact trigger leads to multiple notifications, but each notification is triggered due to a single contact tracing only.


Assumptions that were taken while designing the ER diagram:
•    All employees have signed up and registered on the application.
•    Employees only work on one floor - The schema does not allow for employees working on multiple floors.
•    Test results perfectly determine health status - The schema assumes no errors in using test results to definitively set an employee's status.
•    Contact tracing is done at meeting level or floor level - More granular, individual-to-individual tracing is not modeled.
•    Meetings are only between employees - The schema allows meetings between employees and external people/entities which may not be needed for contact tracing purposes.
•    Temperature scans perfectly detect fevers - The schema assumes scans accurately detect fevers with no errors.
•    Employees report/update their health status on the application honestly.

