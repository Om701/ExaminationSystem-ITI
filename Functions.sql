CREATE FUNCTION FN_GetStudentResults
(
    @studentID INT,
    @courseID INT
)
RETURNS TABLE
AS
RETURN
(
    -- Select the results for the specified student and course
    SELECT
        [e].[ID] AS ExamID,
        [e].[StartTime],
        [e].[EndTime],
        [e].[IsCorrective],
        [q].[Content] AS QuestionContent,
        [sa].[StdAnswer] AS StudentAnswer,
        CASE
            WHEN [q].[ID] = [mcq].[QuestionID] THEN [mcq].[FullDegree]
            WHEN [q].[ID] = [tfq].[QuestionID] THEN [tfq].[FullDegree]
            WHEN [q].[ID] = [txtq].[QuestionID] THEN [txtq].[FullDegree]
            ELSE NULL
        END AS MaxDegree
    FROM
        [dbo].[Exam] AS [e]
    JOIN
        [dbo].[StdAnswers] AS [sa] ON [e].[ID] = [sa].[ExamID]
    JOIN
        [dbo].[Question] AS [q] ON [sa].[QstID] = [q].[ID]
    LEFT JOIN
        [dbo].[MCQuestion] AS [mcq] ON [q].[ID] = [mcq].[QuestionID]
    LEFT JOIN
        [dbo].[TFQuestion] AS [tfq] ON [q].[ID] = [tfq].[QuestionID]
    LEFT JOIN
        [dbo].[TxtQuestion] AS [txtq] ON [q].[ID] = [txtq].[QuestionID]
    WHERE
        [sa].[StdID] = @studentID
        AND [e].[CourseID] = @courseID
)
Go
-- Example usage of FN_GetStudentResults function
DECLARE @StudentID INT = 1; -- Replace with the desired student ID
DECLARE @CourseID INT = 1;  -- Replace with the desired course ID

-- Select results for the specified student and course using the function
SELECT 
    ExamID,
    StartTime,
    EndTime,
    IsCorrective,
    QuestionContent,
    StudentAnswer,
    MaxDegree
FROM 
    dbo.FN_GetStudentResults(@StudentID, @CourseID);

Go


CREATE FUNCTION FN_GetInstructorCourses
(
    @instructorID INT
)
RETURNS TABLE
AS
RETURN
(
    -- Select the courses taught by the specified instructor
    SELECT
        [c].[ID] AS CourseID,
        [c].[Title],
        [c].[Description],
        [c].[MaxDegree],
        [c].[MinDegree]
    FROM
        [dbo].[Class] AS [cl]
    JOIN
        [dbo].[Course] AS [c] ON [cl].[CourseID] = [c].[ID]
    WHERE
        [cl].[InstructorID] = @instructorID
);
GO

-- Example usage of FN_GetInstructorCourses function
DECLARE @InstructorID INT = 1; -- Replace with the desired instructor ID

-- Select courses taught by the specified instructor using the function
SELECT 
    CourseID,
    Title,
    Description,
    MaxDegree,
    MinDegree
FROM 
    dbo.FN_GetInstructorCourses(@InstructorID);
Go



CREATE FUNCTION FN_CalcExamResult (@StdID INT, @ExamID INT)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @Result VARCHAR(50);

    -- Calculate the final result based on the student's answers in the exam
    SELECT @Result = 
        CASE 
            WHEN COUNT(*) = SUM(CASE WHEN DATALENGTH(StdAnswer) > 0 THEN 1 ELSE 0 END) THEN 'Pass'
            ELSE 'Fail'
        END
    FROM [dbo].[StdAnswers]
    WHERE StdID = @StdID AND ExamID = @ExamID;

    RETURN @Result;
END;
GO


-- Example usage of FN_CalcExamResult function
DECLARE @StudentID INT = 1; -- Replace with the actual student ID
DECLARE @ExamID INT = 1;    -- Replace with the actual exam ID

-- Call the function and store the result in a variable
DECLARE @ExamResult VARCHAR(50);
SET @ExamResult = dbo.FN_CalcExamResult(@StudentID, @ExamID);

-- Display the result
SELECT @ExamResult AS ExamResult;
Go

