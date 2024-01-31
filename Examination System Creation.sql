USE ExaminationSys
GO

-- Creating a table for 'UserRole'
CREATE TABLE UserRoles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(255)
)
-- Insert User Roles
INSERT INTO UserRoles (RoleID, RoleName) VALUES (1, 'Training Manager')
INSERT INTO UserRoles (RoleID, RoleName) VALUES (2, 'Instructor')
INSERT INTO UserRoles (RoleID, RoleName) VALUES (3, 'Student')

-- Creating a table for 'Instructor'
CREATE TABLE Instructor (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Username VARCHAR(255),
    Password VARCHAR(255),
    Training_manager INT,
	RoleID INT
)

-- Creating a table for 'Student'
CREATE TABLE Student (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Username VARCHAR(255),
    Password VARCHAR(255),
    Email VARCHAR(255),
	BranchID INT,
	TrackID INT,
	IntakeID INT,
	ClassID INT,
	RoleID INT

)

-- Creating a table for 'Course'
CREATE TABLE Course (
    ID INT PRIMARY KEY,
    Title VARCHAR(255),
    Description TEXT,
    MaxDegree FLOAT,
    MinDegree FLOAT
)
--Class 
CREATE TABLE Class (
    ID INT PRIMARY KEY,
    CourseID INT,
    InstructorID INT,
	[Year] date
)

-- Creating a table for 'Exam'
CREATE TABLE Exam (
    ID INT PRIMARY KEY,
    CourseID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    IsCorrective BIT
)

-- StdAnswers 
CREATE TABLE StdAnswers (
    StdID INT,
    QstID INT,
    ExamID INT,
    [Time] DATETIME,
    StdAnswer TEXT,
    PRIMARY KEY (StdID, QstID, ExamID)
)
--Table for studExam
CREATE TABLE StudentExam (
    StudentID INT,
    ExamID INT,
	FinalResult Text,
    PRIMARY KEY (StudentID, ExamID)
)

-- Department
CREATE TABLE Department (
    ID INT PRIMARY KEY,
    Name VARCHAR(255)
)

-- Intake
CREATE TABLE Intake (
    ID INT PRIMARY KEY,
    Number INT,
	DepID INT
)

-- Track
CREATE TABLE Track (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
	DepID INT
)

-- Branch
CREATE TABLE Branch (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
	TrackID INT
)
-- Question (Base table for questions)
CREATE TABLE Question (
    ID INT PRIMARY KEY,
    Content TEXT
)

-- TFQuestion (True/False Question)
CREATE TABLE TFQuestion (
    QuestionID INT PRIMARY KEY,
	FullDegree FLOAT,
    CorrectAns BIT
)

-- TxtQuestion (Textual Question)
CREATE TABLE TxtQuestion (
    QuestionID INT PRIMARY KEY,
    FullDegree FLOAT,
    BestAnswer TEXT
)

-- MCQuestion (Multiple Choice Question)
CREATE TABLE MCQuestion (
    QuestionID INT PRIMARY KEY,
    FullDegree FLOAT,
    CorrectChoice INT,
    Choice1 TEXT,
    Choice2 TEXT,
    Choice3 TEXT,
    Choice4 TEXT
)