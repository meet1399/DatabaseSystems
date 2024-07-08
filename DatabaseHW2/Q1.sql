/* 
Name: Meet Viral Shah (USC ID: 5581-277-75)
Database used: MySQL - Workbench
*/

DROP DATABASE IF EXISTS COVIDTRACKER;

CREATE DATABASE COVIDTRACKER;

USE COVIDTRACKER;

CREATE TABLE Employee (
  id INT PRIMARY KEY,
  employee_name VARCHAR(100) NOT NULL,
  office_number INT,
  floor_number INT NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  email_address VARCHAR(100),
  CHECK (floor_number BETWEEN 1 AND 10)
);

CREATE TABLE Meeting (
  meeting_id INT NOT NULL,
  employee_id INT NOT NULL,
  room_number INT NOT NULL,
  floor_number INT NOT NULL, 
  start_time INT NOT NULL,
  CHECK (start_time BETWEEN 8 AND 18),
  CHECK (floor_number BETWEEN 1 AND 10),
  FOREIGN KEY (employee_id) REFERENCES Employee(id),
  PRIMARY KEY (meeting_id, employee_id)
);

CREATE TABLE Notification (
  notification_id INT NOT NULL,
  employee_id INT NOT NULL,
  notification_date DATE NOT NULL,
  notification_type ENUM('mandatory','optional') NOT NULL,
  FOREIGN KEY (employee_id) REFERENCES Employee(id),
  PRIMARY KEY (notification_id, employee_id)
);

CREATE TABLE Symptom (
  row_id INT AUTO_INCREMENT PRIMARY KEY, 
  employee_id INT NOT NULL,
  date_reported DATE NOT NULL,
  symptom_id INT NOT NULL,
  CHECK (symptom_id BETWEEN 1 AND 5),
  FOREIGN KEY (employee_id) REFERENCES Employee(id)
);


CREATE TABLE Scan (
  scan_id INT PRIMARY KEY,
  scan_date DATE NOT NULL,
  scan_time INT NOT NULL, 
  employee_id INT NOT NULL,
  temperature DECIMAL(5,2) NOT NULL,
  CHECK (scan_time BETWEEN 0 AND 23),
  FOREIGN KEY (employee_id) REFERENCES Employee(id)
);


CREATE TABLE Test (
  test_id INT PRIMARY KEY,
  location VARCHAR(100) NOT NULL,
  test_date DATE NOT NULL,
  test_time INT NOT NULL,
  employee_id INT NOT NULL,
  test_result ENUM('positive','negative') NOT NULL,
  CHECK (test_time BETWEEN 0 AND 23),
  FOREIGN KEY (employee_id) REFERENCES Employee(id)  
);

CREATE TABLE PositiveCase (
  case_id INT PRIMARY KEY,
  employee_id INT NOT NULL,
  case_date DATE NOT NULL,
  resolution ENUM('back to work', 'left the company', 'deceased', 'quarantined') NOT NULL,
  FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

CREATE TABLE HealthStatus (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    status_date DATE NOT NULL,
    status ENUM('sick', 'hospitalized', 'well') NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee (id)
);


INSERT INTO Employee (id, employee_name, office_number, floor_number, phone_number, email_address)
VALUES
(1, 'Sachin Tendulkar', 101, 5, '9856321470', 'sachin@company.com'),  
(2, 'Cristiano Ronaldo', 102, 2, '8877665544', 'ronaldo@company.com'),
(3, 'Serena Williams', 103, 8, '9988776655', 'serena@company.com'),
(4, 'Rafael Nadal', 104, 4, '7788996655', 'rafael@company.com'),
(5, 'Maria Sharapova', 105, 9, '6655443322', 'maria@company.com'),
(6, 'Roger Federer', 106, 7, '4433221100', 'roger@company.com'),
(7, 'Naomi Osaka', 107, 1, '1122334455', 'naomi@company.com'),
(8, 'Novak Djokovic', 108, 10, '8811223344', 'novak@company.com'),  
(9, 'Simone Biles', 201, 6, '9911223344', null),
(10, 'Usain Bolt', 202, 3, '8844223344', 'usain@company.com'),
(11, 'Michael Phelps', 203, 5, '7788112299', 'michael@company.com'), 
(12, 'Michael Jordan', 204, 2, '6677889900', 'michaelj@company.com'),
(13, 'Tom Brady', 205, 4, '6677880099', 'tom@company.com'),
(14, 'Wayne Gretzky', 206, 9, '4477880099', 'wayne@company.com'),
(15, 'Magic Johnson', 207, 7, '3338880099', 'magic@company.com'),
(16, 'Shaquille O’Neal', 208, 1, '2223338800', 'shaq@company.com'),
(17, 'Manny Pacquiao', 301, 10, '1113338800', 'manny@company.com'),
(18, 'Lionel Messi', 302, 8, '9998880077', 'lionel@company.com'),  
(19, 'LeBron James', 303, 3, '8887770077', 'lebron@company.com'),
(20, 'Valentino Rossi', 304, 6, '7776660077', 'valentino@company.com'),
(21, 'Saina Nehwal', 305, 10, '6667770088', 'saina@company.com'),
(22, 'Steve Smith', 306, 9, '5556660088', 'steve@company.com'),
(23, 'Lewis Hamilton', 307, 2, '5551110088', 'lewis@company.com'),
(24, 'Pele', 308, 4, '4441110088', 'pele@company.com'),
(25, 'Mike Tyson', 401, 7, '3331120088', 'mike@company.com'),  
(26, 'Sergey Bubka', 402, 5, '2221110099', null), 
(27, 'Virat Kohli', 403, 8, '2223331122', 'virat@company.com'),
(28, 'Andre Agassi', 404, 1, '1113321122', null),
(29, 'Muhammad Ali', 405, 3, '9983321122', 'muhammad@company.com'),
(30, 'Viswanathan Anand', 406, 6, '8873321122', 'viswanathan@company.com');


INSERT INTO Meeting (meeting_id, employee_id, room_number, floor_number, start_time)
VALUES
(1, 1, 101, 5, 10),
(1, 2, 101, 5, 10), 
(2, 1, 102, 4, 11),
(2, 5, 102, 4, 11),  
(3, 2, 103, 6, 14),
(3, 4, 103, 6, 14),
(3, 5, 103, 6, 14), 
(4, 4, 104, 2, 16),
(4, 5, 104, 2, 16),
(5, 5, 105, 8, 10),
(5, 6, 105, 8, 10),
(6, 6, 106, 3, 13),
(6, 7, 106, 3, 13),
(7, 7, 107, 9, 15),
(7, 8, 107, 9, 15),  
(7, 9, 107, 9, 15), 
(8, 9, 108, 1, 9),
(8, 10, 108, 1, 9),
(9, 10, 201, 7, 12),  
(9, 11, 201, 7, 12),
(9, 12, 201, 7, 12),
(10, 12, 202, 5, 17),  
(10, 13, 202, 5, 17),
(11, 14, 203, 10, 8),
(11, 16, 203, 10, 8),
(11, 17, 203, 10, 8),
(11, 18, 203, 10, 8),
(11, 19, 203, 10, 8),
(12, 20, 204, 9, 10),
(12, 21, 204, 9, 10),  
(13, 22, 205, 3, 14), 
(13, 23, 205, 3, 14),
(13, 24, 205, 3, 14), 
(14, 25, 206, 6, 15),
(14, 26, 206, 6, 15), 
(15, 27, 207, 2, 11),
(15, 28, 207, 2, 11),
(15, 29, 207, 2, 11),
(15, 30, 207, 2, 11);


INSERT INTO Notification (notification_id, employee_id, notification_date, notification_type)
VALUES 
(1, 23, '2023-01-05', 'mandatory'),
(1, 24, '2023-01-05', 'mandatory'),
(1, 5, '2023-01-05', 'optional'),
(1, 14, '2023-01-05', 'optional'),
(2, 7, '2023-01-04', 'mandatory'),
(2, 9, '2023-01-04', 'mandatory'),
(2, 17, '2023-01-04', 'optional'),
(2, 21, '2023-01-04', 'optional'),
(3, 20, '2023-01-07', 'mandatory'),
(3, 17, '2023-01-07', 'optional'),
(4, 29, '2023-01-10', 'mandatory'), 
(4, 30, '2023-01-10', 'mandatory'),
(4, 3, '2023-01-10', 'optional'),
(4, 18, '2023-01-10', 'optional'),
(5, 14, '2023-01-16', 'mandatory'),
(5, 19, '2023-01-16', 'mandatory'),
(5, 3, '2023-01-16', 'optional'),
(5, 27, '2023-01-16', 'optional'),
(6, 18, '2023-01-02', 'optional'),  
(6, 27, '2023-01-02', 'optional'),
(7, 1, '2023-01-16', 'optional'),
(7, 11, '2023-01-16', 'optional'),
(8, 19, '2023-01-16', 'optional'),
(8, 29, '2023-01-16', 'optional'),
(9, 6, '2023-01-04', 'optional'),
(9, 25, '2023-01-04', 'optional');


INSERT INTO Symptom (employee_id, date_reported, symptom_id)
VALUES
(3, '2023-01-01', 2), 
(7, '2023-01-02', 4),
(13, '2023-01-03', 1),
(22, '2023-01-04', 3),  
(28, '2023-01-05', 5),
(1, '2023-01-01', 2), 
(4, '2023-01-05', 2),
(14, '2023-01-08', 4),
(15, '2023-01-04', 5),  
(30, '2023-01-15', 1);

INSERT INTO Scan (scan_id, scan_date, scan_time, employee_id, temperature)
VALUES
(1, '2023-01-01', 8, 2, 98.6),
(2, '2023-01-02', 12, 5, 99.5),
(3, '2023-01-03', 10, 8, 101.2),
(4, '2023-01-04', 14, 11, 98.9),
(5, '2023-01-05', 16, 17, 100.8),
(6, '2023-01-06', 9, 19, 99.0),
(7, '2023-01-07', 15, 21, 101.5),  
(8, '2023-01-08', 10, 23, 97.2),
(9, '2023-01-09', 18, 25, 100.2),
(10, '2023-01-10', 8, 27, 102.1), 
(11, '2023-01-11', 21, 29, 101.4),
(12, '2023-01-12', 19, 30, 99.9);

INSERT INTO Test (test_id, location, test_date, test_time, employee_id, test_result)
VALUES
(1, 'clinic', '2023-01-02', 8, 7, 'negative'),
(2, 'hospital', '2023-01-02', 12, 3, 'positive'), 
(3, 'company', '2023-01-05', 14, 13, 'negative'),
(4, 'clinic', '2023-01-05', 18, 22, 'positive'),
(5, 'hospital', '2023-01-06', 10, 28, 'negative'),
(6, 'clinic', '2023-01-04', 9, 8, 'positive'),  
(7, 'company', '2023-01-07', 11, 17, 'negative'),
(8, 'company', '2023-01-07', 20, 21, 'positive'), 
(9, 'clinic', '2023-01-10', 16, 27, 'positive'),
(10, 'hospital', '2023-01-12', 7, 29, 'negative'),
(11, 'clinic', '2023-01-14', 8, 3, 'negative'),
(12, 'hospital', '2023-01-15', 10, 18, 'positive'),
(13, 'company', '2023-01-16', 12, 26, 'positive'),
(14, 'hospital', '2023-01-16', 10, 10, 'positive'),
(15, 'clinic', '2023-01-02', 8, 1, 'negative'),
(16, 'hospital', '2023-01-06', 12, 4, 'negative'), 
(17, 'company', '2023-01-08', 14, 14, 'negative'),
(18, 'clinic', '2023-01-04', 18, 15, 'positive'),
(19, 'hospital', '2023-01-16', 10, 30, 'negative');

INSERT INTO PositiveCase (case_id, employee_id, case_date, resolution)
VALUES
(1, 3, '2023-01-03', 'quarantined'),
(2, 22, '2023-01-05', 'quarantined'),  
(3, 8, '2023-01-04', 'quarantined'),
(4, 21, '2023-01-10', 'left the company'), 
(5, 27, '2023-01-15', 'quarantined'),
(6, 18, '2023-01-16', 'quarantined'),
(7, 26, '2023-01-25', 'deceased'),
(8, 10, '2023-01-26', 'back to work'),
(9, 15, '2023-01-10', 'back to work');


INSERT INTO HealthStatus (employee_id, status_date, status)
VALUES
(3, '2023-01-03', 'sick'),
(22, '2023-01-05', 'sick'),
(8, '2023-01-04', 'sick'),  
(21, '2023-01-08', 'sick'), 
(27, '2023-01-12', 'sick'),
(27, '2023-01-15', 'hospitalized'),
(18, '2023-01-16', 'sick'),
(26, '2023-01-19', 'sick'),
(26, '2023-01-24', 'hospitalized'),
(10, '2023-01-16', 'sick'),
(10, '2023-01-25', 'well'),
(15, '2023-01-04', 'sick'),
(15, '2023-01-06', 'hospitalized'),
(15, '2023-01-10', 'well');
