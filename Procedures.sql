CREATE PROCEDURE addBranchSP
    @BranchName VARCHAR(255),
    @InstructorID INT -- ID of the instructor attempting to add the branch
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID AND RoleID = 1) -- Assuming RoleID 1 represents Training Manager
    BEGIN
        INSERT INTO Branch (Name)
        VALUES (@BranchName)
    END
    ELSE
    BEGIN
        RAISERROR ('Only a Training Manager can add a branch.', 16, 1);
    END
END

-------------------------------------------------------

CREATE PROCEDURE updateBranchNameSP
    @BranchID INT,
    @NewBranchName VARCHAR(255),
    @InstructorID INT -- ID of the instructor attempting to update the branch name
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID AND RoleID = 1) -- Assuming RoleID 1 represents Training Manager
    BEGIN
        UPDATE Branch
        SET Name = @NewBranchName
        WHERE ID = @BranchID;
    END
    ELSE
    BEGIN
        RAISERROR ('Only a Training Manager can update a branch name.', 16, 1);
    END
END
----------------------------------------------------------

CREATE PROCEDURE addTrackSP
    @TrackName VARCHAR(255),
    @DepartmentID INT, -- Assuming a track is associated with a department
    @InstructorID INT -- ID of the instructor attempting to add the track
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID AND RoleID = 1) -- Assuming RoleID 1 represents Training Manager
    BEGIN
        INSERT INTO Track (Name, DepID)
        VALUES (@TrackName, @DepartmentID);
    END
    ELSE
    BEGIN
        RAISERROR ('Only a Training Manager can add a track.', 16, 1);
    END
END

CREATE PROCEDURE updateTrackNameSP
    @TrackID INT,
    @NewTrackName VARCHAR(255),
    @InstructorID INT -- ID of the instructor attempting to update the track name
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID AND RoleID = 1) -- Assuming RoleID 1 represents Training Manager
    BEGIN
        UPDATE Track
        SET Name = @NewTrackName
        WHERE ID = @TrackID;
    END
    ELSE
    BEGIN
        RAISERROR ('Only a Training Manager can update a track name.', 16, 1);
    END
END

----------------------------------------------------------

CREATE PROCEDURE updateDepartmentTrackSP
    @TrackID INT,
    @DepID INT,
    @InstructorID INT -- ID of the instructor attempting to update the track name
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID AND RoleID = 1) -- Assuming RoleID 1 represents Training Manager
    BEGIN
        UPDATE Track
        SET DepID = @DepID
        WHERE ID = @TrackID; -- Assuming the primary key of the track is ID
        PRINT 'The department ID updated successfully!';
    END
    ELSE
    BEGIN
        RAISERROR ('Only a Training Manager can update a track.', 16, 1);
    END
END
---------------------------------------------------------

CREATE PROCEDURE addIntakeSP
    @IntakeNumber INT,
    @InstructorID INT -- ID of the instructor attempting to add the intake
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID AND RoleID = 1) -- Assuming RoleID 1 represents Training Manager
    BEGIN
        INSERT INTO Intake (Number)
        VALUES (@IntakeNumber)
    END
    ELSE
    BEGIN
        RAISERROR ('Only a Training Manager can add an intake.', 16, 1);
    END
END

-------------------------------------------------------------------


CREATE PROCEDURE [dbo].[updateInsNameSP]
    @InstructorID INT,
    @NewName VARCHAR(255),
    @TrainingManagerID INT
AS
BEGIN
    DECLARE @IsTrainingManager BIT;

    -- Check if the provided Training Manager ID exists and has the role of Training Manager
    SELECT @IsTrainingManager = 1
    FROM Instructor AS i
    INNER JOIN UserRoles AS ur ON i.RoleID = ur.RoleID
    WHERE i.ID = @TrainingManagerID AND ur.RoleName =1;

    IF @IsTrainingManager = 1
    BEGIN
        -- Check if the provided Instructor ID exists
        IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID)
        BEGIN
            -- Update the name of the existing instructor
            UPDATE Instructor SET Name = @NewName WHERE ID = @InstructorID;
            PRINT 'Instructor name updated successfully.';
        END
        ELSE
        BEGIN
            RAISERROR('Instructor does not exist.', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR('Only Training Managers are allowed to update instructor names.', 16, 1);
    END
END
-----------------------------------------------------------------------

CREATE PROCEDURE [dbo].[updateInsUserNameSP]
    @InstructorID INT,
    @NewUserName VARCHAR(255),
    @TrainingManagerID INT
AS
BEGIN
    DECLARE @IsTrainingManager BIT;

    -- Check if the provided Training Manager ID exists and has the role of Training Manager
    SELECT @IsTrainingManager = 1
    FROM Instructor AS i
    INNER JOIN UserRoles AS ur ON i.RoleID = ur.RoleID
    WHERE i.ID = @TrainingManagerID AND ur.RoleName = 1;

    IF @IsTrainingManager = 1
    BEGIN
        -- Check if the provided Instructor ID exists
        IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID)
        BEGIN
            -- Update the username of the existing instructor
            UPDATE Instructor SET Username = @NewUserName WHERE ID = @InstructorID;
            PRINT 'Instructor username updated successfully.';
        END
        ELSE
        BEGIN
            RAISERROR('Instructor does not exist.', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR('Only Training Managers are allowed to update instructor usernames.', 16, 1);
    END
END
------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[updateInsPasswordSP]
    @InstructorID INT,
    @NewPassword VARCHAR(255),
    @TrainingManagerID INT
AS
BEGIN
    DECLARE @IsTrainingManager BIT;

    -- Check if the provided Training Manager ID exists and has the role of Training Manager
    SELECT @IsTrainingManager = 1
    FROM Instructor AS i
    INNER JOIN UserRoles AS ur ON i.RoleID = ur.RoleID
    WHERE i.ID = @TrainingManagerID AND ur.RoleName = 1;

    IF @IsTrainingManager = 1
    BEGIN
        -- Check if the provided Instructor ID exists
        IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID)
        BEGIN
            -- Update the password of the existing instructor
            UPDATE Instructor SET Password = @NewPassword WHERE ID = @InstructorID;
            PRINT 'Instructor password updated successfully.';
        END
        ELSE
        BEGIN
            RAISERROR('Instructor does not exist.', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR('Only Training Managers are allowed to update instructor passwords.', 16, 1);
    END
END

-------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[deleteInstructorSP]
    @InstructorID INT,
    @TrainingManagerID INT
AS
BEGIN
    DECLARE @IsTrainingManager BIT;

    -- Check if the provided Training Manager ID exists and has the role of Training Manager
    SELECT @IsTrainingManager = 1
    FROM Instructor AS i
    INNER JOIN UserRoles AS ur ON i.RoleID = ur.RoleID
    WHERE i.ID = @TrainingManagerID AND ur.RoleName = 'Training Manager';

    IF @IsTrainingManager = 1
    BEGIN
        -- Check if the provided Instructor ID exists
        IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID)
        BEGIN
            -- Delete the instructor from the database
            DELETE FROM Instructor WHERE ID = @InstructorID;
            PRINT 'Instructor deleted successfully.';
        END
        ELSE
        BEGIN
            RAISERROR('Instructor does not exist.', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR('Only Training Managers are allowed to delete instructors.', 16, 1);
    END
END
----------------------------------------------------------------------------

--deleteCourseSP: Deletes a course from the database.
alter procedure delet_course (@title varchar(20),@userid int)
as
BEGIN
	if @userid=1
	begin
	  delete from ExaminationSys.dbo.Course
	  where Title=@title

	  PRINT 'Branch added successfully.';
	end
	else
	begin
		print ('you are not allowed to delete courses')
	end

End
exec delet_course @title='python'
--------------------------------------------------------------
--updateCrsInsIdSP: Updates the instructor ID associated with a course.
go
create PROC UpdateCrInsId (@Title VARCHAR(20), @UserName VARCHAR(20))
AS

BEGIN
    DECLARE @InsID INT;

    SET @InsID = (SELECT ID FROM ExaminationSys.dbo.Instructor WHERE UserName = @UserName);

    -- Update the InstructorID in the Class table
    UPDATE cl
    SET cl.InstructorID = @InsID
    FROM Class cl
    INNER JOIN Course c ON cl.CourseID = c.ID
    WHERE c.Title = @Title;
End
exec UpdateCrInsId @Title='python',@UserName='ahmed98';
---------------------------------------------------------------------
--SearchOnExamSP: Procedure for searching for exams with different options.
go
create PROCEDURE SearchOnExamSP(@coursetitle VARCHAR(255))
AS
BEGIN
  SELECT
    c.Title,
    c.MaxDegree,
    c.MinDegree,
    e.ID,
    e.IsCorrective,
    e.StartTime,
    e.EndTime,
    COUNT(se.StudentID) AS StudentCount
	

  FROM
    Course c
  INNER JOIN
    Exam e ON c.ID = e.CourseID
  INNER JOIN
    StudentExam se ON e.ID = se.ExamID
  WHERE
    c.Title = @coursetitle
  GROUP BY
    c.Title,
    c.MaxDegree,
    c.MinDegree,
    e.ID,
    e.IsCorrective,
    e.StartTime,
    e.EndTime;
END;

----------------------------------------------------------------------------
--ShowExamSP: Procedure for displaying exams for students.
go
create PROCEDURE ShowExamSP
    @courseTitle VARCHAR(50)
AS
BEGIN
    DECLARE @examid INT;

    -- Use SELECT TOP 1 to handle the case where there might be multiple exams for the same course
    SET @examid = (SELECT TOP 1 Exam.ID 
                   FROM Exam 
                   INNER JOIN Course ON Course.ID = Exam.CourseID 
                   WHERE Course.Title = @courseTitle);

    IF @examid IS NOT NULL AND @examid IN (SELECT ExamID 
                                           FROM StudentExam SE 
                                           INNER JOIN Exam E ON SE.ExamID = E.ID 
                                           INNER JOIN Course C ON E.CourseID = C.ID 
                                           WHERE C.Title = @courseTitle)
    BEGIN
        SELECT E.ID AS ExamID, E.StartTime, E.EndTime, E.IsCorrective
        FROM Exam E
        INNER JOIN Course C ON C.ID = E.CourseID
        INNER JOIN StudentExam SE ON E.ID = SE.ExamID
        WHERE C.Title = @courseTitle;
    END
    ELSE
    BEGIN
        raiserror('This course is not assigned to you or no exams are available.', 16, 1);
    END
END;


--------------------------------------------------------------------------------
--SearchOnStdSP: Procedure for searching for students with different options.
go
create PROCEDURE SearchOnSt
    @stdname VARCHAR(50)
AS
BEGIN
    SELECT 
        s.ID,
        s.Name,
		b.Name,
		t.Name,
        c.Title,
        se.ExamID,
        e.IsCorrective,
        e.StartTime,
        e.EndTime,
        se.FinalResult
    FROM 
        Student s
    JOIN 
        StudentExam se ON s.ID = se.StudentID
    JOIN 
        Exam e ON se.ExamID = e.ID
    JOIN 
        Course c ON e.CourseID = c.ID
	JOIN
		Branch b ON s.BranchID=b.ID
	JOIN
		Track t ON s.TrackID=t.ID

    WHERE 
        s.Name = @stdname;
END;

--proc_addMCQ: Adds a multiple-choice question to the database.
--proc_UpdateMCQ:Updates a multiple-choice question in the database.
--proc_DeleteMCQ: Deletes a multiple-choice question from the database.
create PROCEDURE EditMQC (@ID1 int,@Content1 varchar(200),@CorrectChoice1 char(1),@FullDegree1 int,@Choice11 nvarchar(10),@Choice21 nvarchar(10),@Choice31 nvarchar(10),@StatementType1 NVARCHAR(20) = '')  
AS  
  BEGIN  
      IF @StatementType1 = 'Insert'  
        BEGIN  
			INSERT INTO Question
						 (ID,Content)
			VALUES      (@ID1,@Content1)
			INSERT INTO  MCQuestion
                        (QuestionID ,CorrectChoice,FullDegree,Choice1,Choice2,Choice3)  
            VALUES     (@ID1,@CorrectChoice1,@FullDegree1,@Choice11,@Choice21,@Choice31)

        END  
      IF @StatementType1 = 'Update'  
        BEGIN  
            UPDATE   MCQuestion
            SET    CorrectChoice=@CorrectChoice1,
				   FullDegree=@FullDegree1,
				   Choice1=@Choice11,
				   Choice2=@Choice21,
				   Choice3=@Choice31
            WHERE  QuestionID = @Id1
			UPDATE Question
			SET    Content=@Content1
			WHERE  ID = @Id1

			
        END  
      ELSE IF @StatementType1 = 'Delete'  
        BEGIN  
		    DELETE FROM  MCQuestion
            WHERE  QuestionID = @Id1
            DELETE FROM  Question
            WHERE  ID = @Id1  
        END  
  END   
--------------------------------------------------------------------------
--proc_addTFQ: Adds a true/false question to the database.
--proc_UpdateTFQ: Updates a true/false question in the database.
--proc_DeleteTFQ: Deletes a true/false question from the database.
go
Create PROCEDURE EditTrueFalse (@Id1 int,@Content1 varchar(200),@CorrectAnswer1 nvarchar(5),@FullDegree1 int,@StatementType1 NVARCHAR(20) = '')  
AS  
  BEGIN  
      IF @StatementType1 = 'Insert'  
        BEGIN  
		    INSERT INTO Question
                        (ID,Content)  
            VALUES     (@Id1,@Content1) 
            INSERT INTO TFQuestion
                        (QuestionID,CorrectAns,FullDegree)  
            VALUES     (@Id1,@CorrectAnswer1,@FullDegree1) 
        END  
      IF @StatementType1 = 'Update'  
        BEGIN  
            UPDATE  TFQuestion
            SET    CorrectAns=@CorrectAnswer1,
				   FullDegree=@FullDegree1
            WHERE  QuestionID = @Id1
			UPDATE  Question
            SET    Content=@Content1
            WHERE  ID = @Id1
			
        END  
      ELSE IF @StatementType1 = 'Delete'  
        BEGIN  
            DELETE FROM  TFQuestion
            WHERE  QuestionID = @Id1
			DELETE FROM  Question
            WHERE  ID = @Id1
        END  
  END   
---------------------------------------------------------------------------
--proc_addTxtQuestion: Adds a text question to the database.
--proc_UpdateTxtQuestion: Updates a text question in the database.
--proc_DeleteTxtQuestion: Deletes a text question from the database.
go
Create PROCEDURE EditText (@Id1 int,@Content1 varchar(200),@BestAnswer1 varchar(200),@FullDegree1 int,@StatementType1 NVARCHAR(20) = '')  
AS  
  BEGIN  
      IF @StatementType1 = 'Insert'  
        BEGIN  
            INSERT INTO Question
						(ID,Content)
			VALUES
					   (@Id1,@Content1)
			INSERT INTO  TxtQuestion
                        (QuestionID,BestAnswer,FullDegree)  
            VALUES     (@Id1,@BestAnswer1,@FullDegree1)  
        END  
      IF @StatementType1 = 'Update'  
        BEGIN  
            UPDATE  TxtQuestion
            SET    BestAnswer=@BestAnswer1,
				   FullDegree=@FullDegree1
            WHERE  QuestionID = @Id1
			UPDATE  Question
            SET    Content=@Content1
            WHERE  ID = @Id1

			
        END  
      ELSE IF @StatementType1 = 'Delete'  
        BEGIN  
            DELETE FROM TxtQuestion
            WHERE  QuestionID = @Id1
			DELETE FROM Question
            WHERE  ID = @Id1
        END  
  END  
-------------------------------------------------------------

CREATE PROCEDURE updateIntakeNumSP
    @IntakeID INT,
    @NewNumber INT
AS
BEGIN
    UPDATE [dbo].[Intake]
    SET [Number] = @NewNumber
    WHERE [ID] = @IntakeID;
END;

-- Example of using the updateIntakeNumSP stored procedure
DECLARE @IntakeID INT = 1;
DECLARE @NewNumber INT = 2024;

-- Execute the stored procedure
EXEC updateIntakeNumSP @IntakeID, @NewNumber;
Go


CREATE PROCEDURE addCourseSP
    @Title NVARCHAR(255),
    @Description NVARCHAR(MAX),
    @MaxDegree FLOAT,
    @MinDegree FLOAT
AS
BEGIN
    INSERT INTO [dbo].[Course] ([Title], [Description], [MaxDegree], [MinDegree])
    VALUES (@Title, @Description, @MaxDegree, @MinDegree);
END;
GO

-- Example of using the addCourseSP stored procedure
DECLARE @Title NVARCHAR(255) = 'Example Course'; 
DECLARE @Description NVARCHAR(MAX) = 'This is an example course.'; 
DECLARE @MaxDegree FLOAT = 100.0; 
DECLARE @MinDegree FLOAT = 0.0; 

-- Execute the stored procedure
EXEC addCourseSP @Title, @Description, @MaxDegree, @MinDegree;
Go


CREATE PROCEDURE updateCrsTitleSP
    @CourseID INT,
    @NewTitle NVARCHAR(255)
AS
BEGIN
    UPDATE [dbo].[Course]
    SET [Title] = @NewTitle
    WHERE [ID] = @CourseID;
END;
GO


-- Example of using the updateCrsTitleSP stored procedure
DECLARE @CourseID INT = 1; 
DECLARE @NewTitle NVARCHAR(255) = 'New Course Title'; 

-- Execute the stored procedure
EXEC updateCrsTitleSP @CourseID, @NewTitle;
Go



CREATE PROCEDURE updateCrsDescSP
    @CourseID INT,
    @NewDescription NVARCHAR(MAX)
AS
BEGIN
    UPDATE [dbo].[Course]
    SET [Description] = @NewDescription
    WHERE [ID] = @CourseID;
END;
GO


-- Example of using the updateCrsDescSP stored procedure
DECLARE @CourseID INT = 1;
DECLARE @NewDescription NVARCHAR(MAX) = 'New Course Description'; 
-- Execute the stored procedure
EXEC updateCrsDescSP @CourseID, @NewDescription;
Go

CREATE PROCEDURE updateCrsMinMaxDegreeSP
    @CourseID INT,
    @NewMinDegree FLOAT,
    @NewMaxDegree FLOAT
AS
BEGIN
    UPDATE [dbo].[Course]
    SET [MinDegree] = @NewMinDegree,
        [MaxDegree] = @NewMaxDegree
    WHERE [ID] = @CourseID;
END;
GO

-- Example of using the updateCrsMinMaxDegreeSP stored procedure
DECLARE @CourseID INT = 1; 
DECLARE @NewMinDegree FLOAT = 70.0;
DECLARE @NewMaxDegree FLOAT = 90.0; 

-- Execute the stored procedure
EXEC updateCrsMinMaxDegreeSP @CourseID, @NewMinDegree, @NewMaxDegree;
Go
-------------------------------------------------
USE [ExaminationSys]

--- Stored Procedures: 

--- 1-updateQstDegreeSP: Enables an instructor to update a specific question degree and then update the 
---exam result.
alter procedure updateQstDegreeSP (@QuestionDegree int , 
                                   @FinalResult varchar(10)) 
as
begin
      Declare @InstructorID int
      -- Set @InstructorID to the ID of the instructor who is allowed to update
      SET @InstructorID = (SELECT @InstructorID FROM Instructor WHERE ID = @InstructorID);
	  -- Check if the instructor exists
	  IF EXISTS (Select 1 from Instructor where ID = @InstructorID)
	     begin
		    -- Update the degree of specific question types
            Update TFQuestion set FullDegree = @QuestionDegree
		    Update MCQuestion set FullDegree = @QuestionDegree
		    Update TxtQuestion set FullDegree = @QuestionDegree
			-- Update the final result for the student's exam
	        Update StudentExam set FinalResult = @FinalResult
		 end
	  Else
	     begin
		    RaisError ('Instructor Does not have permission to update a specific question degree and 
			then update the exam result' , 16 , 1);
		 end
end
execute updateQstDegreeSP @QuestionDegree = 90 , @FinalResult = 100
---------------------------------------------------------------------------------------------------------
--- 2-AnswerThisQstSP: Allows a student to submit one answer for an exam question.
CREATE PROCEDURE AnswerThisQstSP 
    @StudentID INT,
    @ExamID INT,
    @QuestionID INT,
    @SelectedAnswerID INT
AS
BEGIN
    DECLARE @CorrectAnswerID INT;

    -- Check if the question exists in the specified exam
    IF EXISTS (
        SELECT 1 
        FROM Question q
        INNER JOIN Exam e ON q.ID = e.CourseID  -- Assuming CourseID is the foreign key in Exam referencing Course
        WHERE q.ID = @QuestionID AND e.ID = @ExamID
    )
    BEGIN
        -- Get the correct answer for the question
        SELECT @CorrectAnswerID = ID
        FROM Question
        WHERE ID = @QuestionID;

        -- Insert the student's answer 
        INSERT INTO StdAnswers (StdID, ExamID, QstID, StdAnswer)
        VALUES (@StudentID, @ExamID, @QuestionID, @SelectedAnswerID);
    END
    ELSE
    BEGIN
        RAISERROR('The specified question does not exist in the given exam.', 16, 1);
    END
END;
execute AnswerThisQstSP @StudentID = 1 , @ExamID = 1 , @QuestionID = 1 , @SelectedAnswerID = 1 
---------------------------------------------------------------------------------------------------------
--- 3-SubmitExamSP: Updates the exam result for a student.
create procedure SubmmmitExamSP (@StudentID INT,
                                @ExamID INT,
                                @NewResult INT)
as
begin
       -- Check if the student and exam exist
        IF EXISTS (
        SELECT 1
        FROM StudentExam
        WHERE StudentID = @StudentID AND ExamID = @ExamID
        )
	   begin
	   -- Update the exam result for the student
       UPDATE StudentExam
       SET FinalResult = @NewResult
       WHERE StudentID = @StudentID AND ExamID = @ExamID;
	   end
	   Else
	     begin
		    RaisError ('Student or exam does not exist' , 16 , 1);
		 end
end
execute SubmmmitExamSP @StudentID = 2, @ExamID = 2, @NewResult = 90
----------------------------------------------------------------------------------------------------------
--- 4-showTxtAnswerSP: Displays text answers for instructors to review.
CREATE PROCEDURE ShowTxtAnswerSP 
    @ExamID INT,
    @QuestionType NVARCHAR(50) = 'Text' -- Assuming the question type is stored as 'Text' in the Questions table
AS
BEGIN
    -- Check if the specified exam exists
    IF NOT EXISTS (
        SELECT 1
        FROM Exam
        WHERE ID = @ExamID
    )
    BEGIN
        RAISERROR('Exam does not exist', 16, 1);
        RETURN;
    END
    -- Retrieve text answers for the specified exam
    SELECT Question.* from Question 
    INNER JOIN TxtQuestion ON Question.ID = Question.ID
    WHERE 
        Question.ID = @ExamID
END;
execute ShowTxtAnswerSP @ExamID = 2 , @QuestionType = 'Text'
--------------------------------------------------------------------------------------------------------
--- 5-addInstructorSP: Adds a new instructor to the database.
create procedure AddInstructorsp (@ID int ,
                                 @Name nvarchar(10) , 
								 @Username nvarchar(max) , 
								 @Password nvarchar(15) ,
                                 @RoleID int)
as
begin
	  Declare @InstructorID int
        -- Check if the instructor with the same ID already exists
        IF EXISTS (SELECT 1 FROM Instructor WHERE ID = @InstructorID)
        begin
		-- Insert the new instructor
        insert into Instructor (ID, Name , Username , Password , RoleID)
	    values (@ID ,@Name , @Username , @Password , @RoleID)
	    print ('Added')
		end
		else
		BEGIN
            RAISERROR('Cannot Add Instructor', 16, 1);
        END
END;
execute AddInstructorsp @ID = 1, @Name = 'Amer' , @Username = 'Khaled' , @Password = 'Ama100$%' , @RoleID = 1
---------------------------------------------------------------------------------------------------------
USE [ExaminationSys]

-- Stored Procedure
-- 1-addExamSP: Creates a new exam by an instructor.
ALTER PROCEDURE CreateNewExam (
    @CourseID INT, 
    @StartTime DATE, 
    @EndTime DATE
)
AS
BEGIN
    DECLARE @InstructorID INT;

    -- Get the InstructorID for the given CourseID
    SELECT @InstructorID = InstructorID 
    FROM Class 
    WHERE CourseID = @CourseID;

    IF @InstructorID IS NOT NULL
    BEGIN
        -- An instructor is assigned to teach the course, so insert the exam details
        INSERT INTO Exam (CourseID, StartTime, EndTime)
        VALUES (@CourseID, @StartTime, @EndTime);
    END
    ELSE
    BEGIN
        RAISERROR ('Instructor does not have permission to create exam.', 16, 1);
    END
END

execute CreateNewExam @CourseID = 1 , @StartTime = '2024-02-01' , @EndTime = '2024-03-01'
-------------------------------------------------------------------------------------------------------------
-- 2-addQstRandomlySP: Builds an exam by randomly selecting questions.
ALTER PROCEDURE addQstRandomlySP 
    @exam_id INT, 
    @num_questions INT
AS
BEGIN
    DECLARE @total_questions INT,
            @question_count INT;

    -- Check if the exam exists
    IF EXISTS (SELECT 1 FROM Exam WHERE ID = @exam_id)
    BEGIN
        -- Get the total number of questions available
        SELECT @total_questions = COUNT(*) FROM Question;

        -- Check if there are enough questions available
        IF @total_questions >= @num_questions
        BEGIN
            SET @question_count = 0;

            -- Loop to randomly select and insert questions into the exam
            WHILE @question_count < @num_questions
            BEGIN
                DECLARE @random_question_id INT;

                -- Generate a random question_id
                SET @random_question_id = CAST(RAND() * @total_questions AS INT);

                -- Check if the question is not already added to the exam
                IF NOT EXISTS (
                    SELECT 1 FROM Exam 
                    WHERE ID = @exam_id AND QuestionID = @random_question_id
                )
                BEGIN
                    -- Insert the random question into the exam
                    INSERT INTO Exam (ID, QuestionID)
                    VALUES (@exam_id, @random_question_id);
                    
                    -- Increment the question_count
                    SET @question_count = @question_count + 1;
                END
            END
        END
        ELSE
        BEGIN
            RAISERROR('Not enough questions available', 16, 1);
        END
    END
    ELSE
    BEGIN
        RAISERROR('Exam does not exist', 16, 1);
    END
END
execute addQstRandomlySP @exam_id = 1 , @num_questions = 20 
-------------------------------------------------------------------------------------------------------------------
-- 3-addQstManuallySP: Builds an exam by manually selecting questions.
alter procedure AdddQstManuallySP ( @exam_id INT ,
                                    @question_ids_list VARCHAR(255))
AS
BEGIN
      DECLARE @question_id INT;
	  -- Check if the exam exists
	  IF EXISTS (Select 1 from Exam where ID = @exam_id)
	  begin
	     -- Loop through the list of question IDs and insert them into the exam
		 WHILE LEN(@question_ids_list) > 0
		 BEGIN
            -- Extract the first question ID from the list
            SET @question_id = CAST(SUBSTRING(@question_ids_list, 1, CHARINDEX(',', @question_ids_list + ',') - 1) 
			                   AS INT);
	        -- Check if the question exists
	        IF EXISTS (Select 1 from Exam where ID = @question_id)
	        BEGIN
	            -- Insert the question into the exam
                INSERT INTO Exam (ID , QuestionID)
                VALUES (@exam_id , @question_ids_list);
	        END
		END
	END
	ELSE
    BEGIN
        RAISERROR('Exam does not exist', 16, 1);
    END
END
execute AdddQstManuallySP @exam_id = 1 , @question_ids_list = 'TFMCQ'