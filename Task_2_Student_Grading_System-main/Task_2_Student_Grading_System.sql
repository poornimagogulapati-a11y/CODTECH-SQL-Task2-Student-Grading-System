CREATE DATABASE student_grading_system;

USE student_grading_system;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    department VARCHAR(50),
    year INT
);

CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(100) NOT NULL,
    max_marks INT DEFAULT 100
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

INSERT INTO Students (student_name, email, department, year)
VALUES
('Rahul', 'rahul@gmail.com', 'CSE', 3),
('Priya', 'priya@gmail.com', 'CSE', 3),
('Kiran', 'kiran@gmail.com', 'ECE', 3),
('Sneha', 'sneha@gmail.com', 'CSE', 3),
('Arjun', 'arjun@gmail.com', 'ECE', 3);

INSERT INTO Subjects (subject_name, max_marks)
VALUES
('Python', 100),
('DBMS', 100),
('Java', 100),
('Data Structures', 100),
('Computer Networks', 100);

INSERT INTO Marks (student_id, subject_id, marks)
VALUES
(1, 1, 85),
(1, 2, 78),
(1, 3, 92),
(1, 4, 88),
(1, 5, 81),

(2, 1, 72),
(2, 2, 68),
(2, 3, 75),
(2, 4, 80),
(2, 5, 70),

(3, 1, 65),
(3, 2, 74),
(3, 3, 69),
(3, 4, 71),
(3, 5, 67),

(4, 1, 90),
(4, 2, 95),
(4, 3, 88),
(4, 4, 92),
(4, 5, 94),

(5, 1, 55),
(5, 2, 62),
(5, 3, 58),
(5, 4, 65),
(5, 5, 60);

SELECT * FROM Students;

SELECT * FROM Subjects;

SELECT * FROM Marks;

SELECT
    s.student_id,
    s.student_name,
    SUM(m.marks) AS total_marks,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY s.student_id;

SELECT
    s.student_id,
    s.student_name,
    SUM(m.marks) AS total_marks,
    ROUND(AVG(m.marks), 2) AS average_marks,
    CASE
        WHEN AVG(m.marks) >= 90 THEN 'A+'
        WHEN AVG(m.marks) >= 80 THEN 'A'
        WHEN AVG(m.marks) >= 70 THEN 'B'
        WHEN AVG(m.marks) >= 60 THEN 'C'
        WHEN AVG(m.marks) >= 50 THEN 'D'
        ELSE 'F'
    END AS grade,
    CASE
        WHEN AVG(m.marks) >= 50 THEN 'PASS'
        ELSE 'FAIL'
    END AS result
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC;

SELECT
    s.student_id,
    s.student_name,
    SUM(m.marks) AS total_marks,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC
LIMIT 1;

SELECT
    sub.subject_name,
    ROUND(AVG(m.marks), 2) AS average_marks,
    MAX(m.marks) AS highest_marks,
    MIN(m.marks) AS lowest_marks
FROM Subjects sub
JOIN Marks m
    ON sub.subject_id = m.subject_id
GROUP BY sub.subject_id, sub.subject_name
ORDER BY sub.subject_id;

SHOW TABLES;

SELECT COUNT(*) AS total_students
FROM Students;