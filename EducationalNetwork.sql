USE MASTER;
GO

DROP DATABASE IF EXISTS EducationalNetwork;
GO

CREATE DATABASE EducationalNetwork;
GO

USE EducationalNetwork;
GO

CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    grade INT NOT NULL
) AS NODE;

CREATE TABLE Teachers (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    subject VARCHAR(50) NOT NULL
) AS NODE;

CREATE TABLE Subjects (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
) AS NODE;

CREATE TABLE Courses (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    subject_id INT REFERENCES Subjects(id)
) AS NODE;

-- Создание таблиц ребер
CREATE TABLE Enrolled AS EDGE;
CREATE TABLE Teaches AS EDGE;
CREATE TABLE ReceivedGrade (
    grade DECIMAL(4,2),
    date DATE
) AS EDGE;

-- Добавление учеников
INSERT INTO Students (id, name, grade) VALUES
(1, 'Alice', 10),
(2, 'Bob', 11),
(3, 'Charlie', 9),
(4, 'David', 10),
(5, 'Eve', 11),
(6, 'Frank', 10),
(7, 'Grace', 11),
(8, 'Henry', 9),
(9, 'Ivy', 10),
(10, 'Jack', 11);

-- Добавление учителей
INSERT INTO Teachers (id, name, subject) VALUES
(1, 'Mr. Smith', 'Math'),
(2, 'Ms. Johnson', 'Science'),
(3, 'Dr. Brown', 'History'),
(4, 'Mrs. White', 'Literature'),
(5, 'Prof. Green', 'Physics'),
(6, 'Dr. Lee', 'Chemistry'),
(7, 'Ms. Black', 'Art'),
(8, 'Mr. Gray', 'Music'),
(9, 'Mrs. Brown', 'Geography'),
(10, 'Prof. Blue', 'Economics');

-- Добавление предметов
INSERT INTO Subjects (id, name, description) VALUES
(1, 'Mathematics', 'Study of numbers, quantity, and space'),
(2, 'Science', 'Study of the natural world'),
(3, 'History', 'Study of past events and civilizations'),
(4, 'Literature', 'Study of written works'),
(5, 'Physics', 'Study of matter and energy'),
(6, 'Chemistry', 'Study of substances and their properties'),
(7, 'Art', 'Study of visual arts and creative expression'),
(8, 'Music', 'Study of sound and musical composition'),
(9, 'Geography', 'Study of Earth''s landscapes, environments, and the relationships between people and their environments'),
(10, 'Economics', 'Study of production, distribution, and consumption of goods and services');

-- Добавление курсов
INSERT INTO Courses (id, name, description, subject_id) VALUES
(1, 'Algebra I', 'Introduction to algebraic concepts', 1),
(2, 'Biology', 'Study of living organisms', 2),
(3, 'World History', 'Overview of world civilizations', 3),
(4, 'American Literature', 'Study of American literary works', 4),
(5, 'Mechanics', 'Study of motion and forces', 5),
(6, 'Chemical Reactions', 'Study of chemical processes', 6),
(7, 'Art History', 'Study of art movements and styles', 7),
(8, 'Music Theory', 'Study of musical structure and notation', 8),
(9, 'Physical Geography', 'Study of Earth''s natural environment', 9),
(10, 'Microeconomics', 'Study of individual economic behavior', 10);



-- Добавление отношений "ученик записан на курс"
INSERT INTO Enrolled VALUES 
((SELECT $node_id FROM Students WHERE id = 1), (SELECT $node_id FROM Courses WHERE id = 1)),
((SELECT $node_id FROM Students WHERE id = 2), (SELECT $node_id FROM Courses WHERE id = 2)),
((SELECT $node_id FROM Students WHERE id = 3), (SELECT $node_id FROM Courses WHERE id = 3)),
((SELECT $node_id FROM Students WHERE id = 4), (SELECT $node_id FROM Courses WHERE id = 4)),
((SELECT $node_id FROM Students WHERE id = 5), (SELECT $node_id FROM Courses WHERE id = 1)),
((SELECT $node_id FROM Students WHERE id = 5), (SELECT $node_id FROM Courses WHERE id = 3)),
((SELECT $node_id FROM Students WHERE id = 6), (SELECT $node_id FROM Courses WHERE id = 4)),
((SELECT $node_id FROM Students WHERE id = 7), (SELECT $node_id FROM Courses WHERE id = 5)),
((SELECT $node_id FROM Students WHERE id = 8), (SELECT $node_id FROM Courses WHERE id = 6)),
((SELECT $node_id FROM Students WHERE id = 9), (SELECT $node_id FROM Courses WHERE id = 7)),
((SELECT $node_id FROM Students WHERE id = 10), (SELECT $node_id FROM Courses WHERE id = 8));

-- Добавление отношений "ученик получил оценку за курс"
INSERT INTO ReceivedGrade VALUES 
((SELECT $node_id FROM Students WHERE id = 1), (SELECT $node_id FROM Courses WHERE id = 1), 4.5, '2024-05-10'),
((SELECT $node_id FROM Students WHERE id = 2), (SELECT $node_id FROM Courses WHERE id = 2), 3.8, '2024-05-12'),
((SELECT $node_id FROM Students WHERE id = 3), (SELECT $node_id FROM Courses WHERE id = 3), 4.2, '2024-05-15'),
((SELECT $node_id FROM Students WHERE id = 4), (SELECT $node_id FROM Courses WHERE id = 4), 4.0, '2024-05-18'),
((SELECT $node_id FROM Students WHERE id = 5), (SELECT $node_id FROM Courses WHERE id = 1), 4.7, '2024-05-20'),
((SELECT $node_id FROM Students WHERE id = 5), (SELECT $node_id FROM Courses WHERE id = 3), 4.4, '2024-05-22'),
((SELECT $node_id FROM Students WHERE id = 6), (SELECT $node_id FROM Courses WHERE id = 4), 4.6, '2024-05-25'),
((SELECT $node_id FROM Students WHERE id = 7), (SELECT $node_id FROM Courses WHERE id = 5), 4.8, '2024-05-28'),
((SELECT $node_id FROM Students WHERE id = 8), (SELECT $node_id FROM Courses WHERE id = 6), 4.3, '2024-05-30'),
((SELECT $node_id FROM Students WHERE id = 9), (SELECT $node_id FROM Courses WHERE id = 7), 3.9, '2024-06-01'),
((SELECT $node_id FROM Students WHERE id = 10), (SELECT $node_id FROM Courses WHERE id = 8), 4.1, '2024-06-03');

-- Добавление отношений "учитель преподает предмет"
INSERT INTO Teaches VALUES
((SELECT $node_id FROM Teachers WHERE id = 1), (SELECT $node_id FROM Subjects WHERE id = 1)),
((SELECT $node_id FROM Teachers WHERE id = 2), (SELECT $node_id FROM Subjects WHERE id = 2)),
((SELECT $node_id FROM Teachers WHERE id = 3), (SELECT $node_id FROM Subjects WHERE id = 3)),
((SELECT $node_id FROM Teachers WHERE id = 4), (SELECT $node_id FROM Subjects WHERE id = 4)),
((SELECT $node_id FROM Teachers WHERE id = 5), (SELECT $node_id FROM Subjects WHERE id = 5)),
((SELECT $node_id FROM Teachers WHERE id = 6), (SELECT $node_id FROM Subjects WHERE id = 6)),
((SELECT $node_id FROM Teachers WHERE id = 7), (SELECT $node_id FROM Subjects WHERE id = 7)),
((SELECT $node_id FROM Teachers WHERE id = 8), (SELECT $node_id FROM Subjects WHERE id = 8)),
((SELECT $node_id FROM Teachers WHERE id = 9), (SELECT $node_id FROM Subjects WHERE id = 9)),
((SELECT $node_id FROM Teachers WHERE id = 10), (SELECT $node_id FROM Subjects WHERE id = 10));



-- Поиск всех студентов, записанных на курс "Алгебра I"
SELECT s.name AS StudentName, c.name AS CourseName
FROM Students s, Enrolled e, Courses c
WHERE MATCH(s-(e)->c)
  AND c.name = 'Algebra I';

  -- Поиск всех учителей, которые преподают предмет "Математика"
SELECT t.name AS TeacherName, sub.name AS SubjectName
FROM Teachers t, Teaches te, Subjects sub
WHERE MATCH(t-(te)->sub)
  AND sub.name = 'Mathematics';

  -- Поиск всех студентов, получивших оценку выше 4.0 по любому курсу
SELECT s.name AS StudentName, c.name AS CourseName, g.grade
FROM Students s, ReceivedGrade g, Courses c
WHERE MATCH(s-(g)->c)
  AND g.grade > 4.0;

  -- Поиск кратчайшего пути между студентом "Alice" и курсом "Алгебра I"
SELECT s.name AS StudentName, c.name AS CourseName
FROM Students s, Enrolled e, Courses c
WHERE MATCH(s-(e)->c)
  AND s.name = 'Alice'
  AND c.name = 'Algebra I';





SELECT P1.ID IdFirst
       , P1.name AS First
       , CONCAT (N'groups',P1.id) AS [First image name]
       , P2.ID AS IdSecond
       , P2.name AS Second
       , CONCAT(N'subject', P2.id) AS [Second image name]
FROM dbo.Teachers AS P1
    , dbo.Teaches AS F
    , dbo.Subjects AS P2
WHERE MATCH (P1-(F)->P2)
