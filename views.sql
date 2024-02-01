--TXQExamContentVE: View displaying text questions for a specific exam.
create view TXQExamContentVE as
SELECT 
    E.ID AS ExamID,
    TQ.QuestionID,
    TQ.FullDegree,
    TQ.BestAnswer
FROM 
    Exam E
INNER JOIN 
    Course C ON E.CourseID = C.ID
INNER JOIN 
    TxtQuestion TQ ON E.ID = TQ.QuestionID
----------------------------------------------------------------------------------------
--StdInfoVE: View called by SearchOnStdSP used for student searching.
go
CREATE VIEW StdInfoVE AS
SELECT
    S.Name AS StudentName,
    S.ID AS StudentID,
    B.Name AS BranchName,
    T.Name AS TrackName,
    D.Name AS DepartmentName
FROM 
    Student S
INNER JOIN 
    Branch B ON S.BranchID = B.ID
INNER JOIN 
    Track T ON S.TrackID = T.ID
INNER JOIN 
    Department D ON T.DepID = D.ID;
-------------------------------------------------------------------------------------------
--- Views:
---ExamQstInfoVE: View called by SearchOnStdSP used for searching exam questions.
create view SearchOnStdSP 
as
select MCQuestion.* , TFQuestion.* , TxtQuestion.*  
from MCQuestion inner join Question on MCQuestion.QuestionID = Question.ID inner join TFQuestion on
TFQuestion.QuestionID = Question.ID inner join TxtQuestion on Question.ID = TxtQuestion.QuestionID
------------------------------------------------------------------------------------------
--TXQExamContentVE: View displaying text questions for a specific exam.
create view TXQExamContentVE as
SELECT 
    E.ID AS ExamID,
    TQ.QuestionID,
    TQ.FullDegree,
    TQ.BestAnswer
FROM 
    Exam E
INNER JOIN 
    Course C ON E.CourseID = C.ID
INNER JOIN 
    TxtQuestion TQ ON E.ID = TQ.QuestionID
WHERE 
    C.Title = @courseTitle;




----------------------------------------------------------------------------------------
--StdInfoVE: View called by SearchOnStdSP used for student searching.
go
CREATE VIEW StdInfoVE AS
SELECT
    S.Name AS StudentName,
    S.ID AS StudentID,
    S.StdDegree,
    B.Name AS BranchName,
    T.Name AS TrackName,
    D.Name AS DepartmentName
FROM 
    Student S
INNER JOIN 
    Branch B ON S.BranchID = B.ID
INNER JOIN 
    Track T ON S.TrackID = T.ID
INNER JOIN 
    Department D ON S.DepartmentID = D.ID;
