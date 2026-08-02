CREATE DATABASE udemy_dw;
USE udemy_dw;

CREATE TABLE DIM_COURSE (
    CourseID INT PRIMARY KEY,
    CourseTitle VARCHAR(255),
    Subject VARCHAR(100),
    URL VARCHAR(500)
);

CREATE TABLE DIM_LEVEL (
    LevelID INT PRIMARY KEY,
    LevelName VARCHAR(100)
);

CREATE TABLE DIM_DATE (
    DateID INT PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT
);
CREATE TABLE FACT_COURSE_PERFORMANCE (
    FactID INT PRIMARY KEY,
    CourseID INT,
    LevelID INT,
    DateID INT,
    Price DECIMAL(10,2),
    Subscribers INT,
    Reviews INT,
    Lectures INT,
    Rating DECIMAL(3,2),
    ContentDuration DECIMAL(10,2),

    FOREIGN KEY (CourseID)
    REFERENCES DIM_COURSE(CourseID),

    FOREIGN KEY (LevelID)
    REFERENCES DIM_LEVEL(LevelID),

    FOREIGN KEY (DateID)
    REFERENCES DIM_DATE(DateID)
);

INSERT INTO DIM_COURSE
(CourseID, CourseTitle, Subject, URL)
VALUES
(101,'Python for Beginners','Web Development','https://www.udemy.com'),
(102,'Data Science Fundamentals','Data Science','https://www.udemy.com');

INSERT INTO DIM_LEVEL
(LevelID, LevelName)
VALUES
(1,'Beginner'),
(2,'Intermediate'),
(3,'Expert'),
(4,'All Levels');

INSERT INTO DIM_DATE
(DateID, Year, Month, Day)
VALUES
(1,2024,1,10),
(2,2024,2,15),
(3,2024,3,20);

 insert INTO FACT_COURSE_PERFORMANCE
(FactID, CourseID, LevelID, DateID, Price, Subscribers, Reviews, Lectures, Rating, ContentDuration)
VALUES
(1,101,1,1,49.99,12000,850,120,4.60,15.50),
(2,102,2,2,79.99,18000,1500,180,4.80,22.00);


SELECT
    c.CourseTitle,
    l.LevelName,
    d.Year,
    f.Price,
    f.Subscribers,
    f.Rating
FROM FACT_COURSE_PERFORMANCE f
JOIN DIM_COURSE c
ON f.CourseID = c.CourseID
JOIN DIM_LEVEL l
ON f.LevelID = l.LevelID
JOIN DIM_DATE d
ON f.DateID = d.DateID;





SELECT l.LevelName,
SUM(f.Subscribers) AS TotalSubscribers
FROM FACT_COURSE_PERFORMANCE f
JOIN DIM_LEVEL l
ON f.LevelID = l.LevelID
GROUP BY l.LevelName
ORDER BY TotalSubscribers DESC;


SELECT c.CourseTitle,
f.Reviews
FROM FACT_COURSE_PERFORMANCE f
JOIN DIM_COURSE c
ON f.CourseID = c.CourseID
ORDER BY f.Reviews DESC;


SELECT c.CourseTitle,
f.Rating
FROM FACT_COURSE_PERFORMANCE f
JOIN DIM_COURSE c
ON f.CourseID = c.CourseID
ORDER BY f.Rating DESC;

SELECT l.LevelName,
AVG(f.Price) AS AveragePrice
FROM FACT_COURSE_PERFORMANCE f
JOIN DIM_LEVEL l
ON f.LevelID = l.LevelID
GROUP BY l.LevelName
ORDER BY AveragePrice DESC;