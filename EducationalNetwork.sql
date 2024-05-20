
USE MASTER;
GO
DROP DATABASE IF EXISTS EducationalNetwork;
GO
CREATE DATABASE EducationalNetwork;
GO
USE EducationalNetwork;
GO

--1
-- Создание таблицы узлов "Одноклассники"
CREATE TABLE Classmates (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT
) AS NODE;
GO

-- Создание таблицы узлов "Сокурсники"
CREATE TABLE CourseMates (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    major VARCHAR(100)
) AS NODE;
GO

-- Создание таблицы узлов "Учебные дисциплины"
CREATE TABLE Subjects (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    credits INT
) AS NODE;
GO

--2
-- Создание таблицы рёбер "Дружит"
CREATE TABLE FriendsWith AS EDGE;
GO

-- Создание таблицы рёбер "Проживает"
CREATE TABLE LivesIn (city VARCHAR(100)) AS EDGE;
GO

-- Создание таблицы рёбер "Рекомендует учебную дисциплину"
CREATE TABLE RecommendsSubject (
    recommendation_date DATE
) AS EDGE;
GO

--3
-- Заполнение таблицы Одноклассники
INSERT INTO Classmates (id, name, age) VALUES
(1, 'Иван Иванов', 17),
(2, 'Петр Петров', 17),
(3, 'Мария Сидорова', 16),
(4, 'Анна Кузнецова', 17),
(5, 'Алексей Смирнов', 16),
(6, 'Ольга Павлова', 17),
(7, 'Дмитрий Козлов', 17),
(8, 'Елена Соколова', 16),
(9, 'Сергей Васильев', 16),
(10, 'Юлия Морозова', 17);
GO

-- Заполнение таблицы Сокурсники
INSERT INTO CourseMates (id, name, major) VALUES
(1, 'Андрей Иванов', 'Компьютерные науки'),
(2, 'Василий Петров', 'Математика'),
(3, 'Наталья Сидорова', 'Физика'),
(4, 'Ирина Кузнецова', 'Химия'),
(5, 'Максим Смирнов', 'Биология'),
(6, 'Светлана Павлова', 'История'),
(7, 'Николай Козлов', 'Литература'),
(8, 'Татьяна Соколова', 'Искусство'),
(9, 'Александр Васильев', 'Философия'),
(10, 'Екатерина Морозова', 'Экономика');
(11, 'Иван Сидоров', 'Социология');
GO

-- Заполнение таблицы Учебные дисциплины
INSERT INTO Subjects (id, name, credits) VALUES
(1, 'Алгебра', 5),
(2, 'Геометрия', 5),
(3, 'Физика', 4),
(4, 'Химия', 4),
(5, 'Биология', 4),
(6, 'История', 3),
(7, 'Литература', 3),
(8, 'Искусство', 2),
(9, 'Философия', 3),
(10, 'Экономика', 4);
GO

--4
-- Заполнение таблицы рёбер "Дружит"
INSERT INTO FriendsWith ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Classmates WHERE id = 1),
        (SELECT $node_id FROM Classmates WHERE id = 2)),
       ((SELECT $node_id FROM Classmates WHERE id = 3),
        (SELECT $node_id FROM Classmates WHERE id = 4)),
       ((SELECT $node_id FROM Classmates WHERE id = 5),
        (SELECT $node_id FROM Classmates WHERE id = 6)),
       ((SELECT $node_id FROM Classmates WHERE id = 7),
        (SELECT $node_id FROM Classmates WHERE id = 8)),
       ((SELECT $node_id FROM Classmates WHERE id = 9),
        (SELECT $node_id FROM Classmates WHERE id = 10)),
       ((SELECT $node_id FROM Classmates WHERE id = 2),
        (SELECT $node_id FROM Classmates WHERE id = 3)),
       ((SELECT $node_id FROM Classmates WHERE id = 4),
        (SELECT $node_id FROM Classmates WHERE id = 5)),
       ((SELECT $node_id FROM Classmates WHERE id = 6),
        (SELECT $node_id FROM Classmates WHERE id = 7)),
       ((SELECT $node_id FROM Classmates WHERE id = 8),
        (SELECT $node_id FROM Classmates WHERE id = 9)),
       ((SELECT $node_id FROM Classmates WHERE id = 10),
        (SELECT $node_id FROM Classmates WHERE id = 1));
GO

-- Заполнение таблицы рёбер "Проживает"
INSERT INTO LivesIn ($from_id, $to_id, city)
VALUES ((SELECT $node_id FROM CourseMates WHERE id = 1),
        (SELECT $node_id FROM CourseMates WHERE id = 1), 'Москва'),
       ((SELECT $node_id FROM CourseMates WHERE id = 2),
        (SELECT $node_id FROM CourseMates WHERE id = 2), 'Санкт-Петербург'),
       ((SELECT $node_id FROM CourseMates WHERE id = 3),
        (SELECT $node_id FROM CourseMates WHERE id = 3), 'Новосибирск'),
       ((SELECT $node_id FROM CourseMates WHERE id = 4),
        (SELECT $node_id FROM CourseMates WHERE id = 4), 'Екатеринбург'),
       ((SELECT $node_id FROM CourseMates WHERE id = 5),
        (SELECT $node_id FROM CourseMates WHERE id = 5), 'Казань'),
       ((SELECT $node_id FROM CourseMates WHERE id = 6),
        (SELECT $node_id FROM CourseMates WHERE id = 6), 'Нижний Новгород'),
       ((SELECT $node_id FROM CourseMates WHERE id = 7),
        (SELECT $node_id FROM CourseMates WHERE id = 7), 'Челябинск'),
       ((SELECT $node_id FROM CourseMates WHERE id = 8),
        (SELECT $node_id FROM CourseMates WHERE id = 8), 'Самара'),
       ((SELECT $node_id FROM CourseMates WHERE id = 9),
        (SELECT $node_id FROM CourseMates WHERE id = 9), 'Омск'),
       ((SELECT $node_id FROM CourseMates WHERE id = 10),
        (SELECT $node_id FROM CourseMates WHERE id = 10), 'Ростов-на-Дону');
GO

-- Заполнение таблицы рёбер "Рекомендует учебную дисциплину"
INSERT INTO RecommendsSubject ($from_id, $to_id, recommendation_date)
VALUES ((SELECT $node_id FROM CourseMates WHERE id = 1),
        (SELECT $node_id FROM Subjects WHERE id = 1), '2023-01-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 2),
        (SELECT $node_id FROM Subjects WHERE id = 2), '2023-02-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 3),
        (SELECT $node_id FROM Subjects WHERE id = 3), '2023-03-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 4),
        (SELECT $node_id FROM Subjects WHERE id = 4), '2023-04-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 5),
        (SELECT $node_id FROM Subjects WHERE id = 5), '2023-05-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 6),
        (SELECT $node_id FROM Subjects WHERE id = 6), '2023-06-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 7),
        (SELECT $node_id FROM Subjects WHERE id = 7), '2023-07-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 8),
        (SELECT $node_id FROM Subjects WHERE id = 8), '2023-08-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 9),
        (SELECT $node_id FROM Subjects WHERE id = 9), '2023-09-01'),
       ((SELECT $node_id FROM CourseMates WHERE id = 10),
        (SELECT $node_id FROM Subjects WHERE id = 10), '2023-10-01');
GO



--5
-- Запрос 1: Найти всех одноклассников, которые дружат с Иваном Ивановым
SELECT c2.name
FROM Classmates c1, FriendsWith f, Classmates c2
WHERE MATCH(c1-(f)->c2)
AND c1.name = 'Иван Иванов';

-- Запрос 2: Найти всех студентов, рекомендующих предмет "Алгебра"
SELECT cm.name
FROM CourseMates cm, RecommendsSubject rs, Subjects s
WHERE MATCH(cm-(rs)->s)
AND s.name = 'Алгебра';

-- Запрос 3: Найти всех студентов, проживающих в Москве
SELECT cm.name
FROM CourseMates cm
JOIN LivesIn l ON cm.$node_id = l.$from_id
WHERE l.city = 'Москва';
GO

-- Запрос 4: Найти всех студентов, которые рекомендуют учебные дисциплины
SELECT cm.name, s.name AS subject
FROM CourseMates cm, RecommendsSubject rs, Subjects s
WHERE MATCH(cm-(rs)->s);
GO

-- Запрос 5: Найти все города, в которых проживают студенты
SELECT DISTINCT l.city
FROM CourseMates cm
JOIN LivesIn l ON cm.$node_id = l.$from_id;
GO

--6
-- Запрос 1: Найти кратчайший путь от студента до его города проживания
SELECT Person1.name AS StudentName,
       STRING_AGG(City.city, '->') WITHIN GROUP (GRAPH PATH) AS ShortestPath
FROM CourseMates AS Person1,
     LivesIn FOR PATH AS City
WHERE MATCH(SHORTEST_PATH(Person1(-(City)->())+))
  AND Person1.name = 'Андрей Иванов';
GO

-- Запрос 2: Найти кратчайший путь от студента до рекомендованного предмета через "рекомендует учебную дисциплину"
SELECT Person1.name AS StudentName,
       STRING_AGG(Subject.name, '->') WITHIN GROUP (GRAPH PATH) AS RecommendedPath
FROM CourseMates AS Person1,
     RecommendsSubject FOR PATH AS rs,
     Subjects FOR PATH AS Subject
WHERE MATCH(SHORTEST_PATH(Person1(-(rs)->Subject)+))
  AND Person1.name = 'Андрей Иванов';
GO


--ВИЗУАЛИЗАЦИЯ ГРАФА В POWER BI С ПОМОЩЬЮ FORCE-DIRECTED GRAPH
SELECT @@SERVERNAME
-- Сервер:DESKTOP-LVK19RB
-- База данных: EducationalNetwork

--Запрос для получения связей между одноклассниками
SELECT C1.ID IdFirst
 , C1.name AS First
 , CONCAT(N'classmate',C1.id) AS [First image name]
 , C2.ID AS IdSecond
 , C2.name AS Second
 , CONCAT(N'classmate',C2.id) AS [Second image name]
FROM dbo.Classmates AS C1
 , dbo.FriendsWith AS F
 , dbo.Classmates AS C2
WHERE MATCH (C1-(F)->C2)

--Запрос для получения связей между сокурсниками и учебными дисциплинами, которые им рекомендуют:
SELECT CM.id AS CourseMateId,
       CM.name AS CourseMateName,
       CONCAT(N'coursemate', CM.id) AS [CourseMate image name],
       S.id AS SubjectId,
       S.name AS SubjectName,
       CONCAT(N'subject', S.id) AS [Subject image name]
FROM CourseMates AS CM, RecommendsSubject AS RS, Subjects AS S
WHERE MATCH (CM-(RS)->S);

-- Запрос для получения связей между сокурсниками и городами, в которых они живут
SELECT CM.id AS CourseMateId,
       CM.name AS CourseMateName,
       CONCAT(N'coursemate', CM.id) AS [CourseMate image name],
       LI.city AS City
FROM CourseMates AS CM
JOIN LivesIn AS LI ON CM.$node_id = LI.$from_id;
