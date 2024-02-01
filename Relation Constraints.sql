-- Relationships

-- Relationship between Instructor and Trainning_Manager
ALTER TABLE instructor ADD CONSTRAINT FK_Trainning_Manager
	FOREIGN KEY (Training_managerID) REFERENCES Instructor(ID)

-- Relationship between Instructor and Role
ALTER TABLE instructor ADD CONSTRAINT FK_inst_Roles
    FOREIGN KEY (RoleID) REFERENCES UserRoles(RoleID)

-- Relationship between Instructor and Class
ALTER TABLE Class ADD CONSTRAINT FK_Class_Instructor
    FOREIGN KEY (InstructorID) REFERENCES Instructor(ID)

-- Relationship between Course and Class
ALTER TABLE Class ADD CONSTRAINT FK_Class_Course
    FOREIGN KEY (CourseID) REFERENCES Course(ID)

-- Relationship between Exam and Course
ALTER TABLE Exam ADD CONSTRAINT FK_Exam_Course
    FOREIGN KEY (CourseID) REFERENCES Course(ID)

-- Relationship between Student and Branch
ALTER TABLE Student ADD CONSTRAINT FK_Student_Branch
	FOREIGN KEY (BranchID) REFERENCES Branch(ID)

-- Relationship between Student and Intake
ALTER TABLE Student ADD CONSTRAINT FK_Student_Intake 
	FOREIGN KEY (IntakeID) REFERENCES Intake(ID)

-- Relationship between Student and Track
ALTER TABLE Student ADD CONSTRAINT FK_Student_Track
	FOREIGN KEY (TrackID) REFERENCES Track(ID)

-- Relationship between Track and Department
ALTER TABLE Track ADD CONSTRAINT FK_Track_Department
    FOREIGN KEY (DepID) REFERENCES Department(ID)

-- Relationship between Student and class
ALTER TABLE student ADD CONSTRAINT FK_Student_Class
	FOREIGN KEY (ClassID) REFERENCES Class(ID)

-- Relationship between Instructor and Role
ALTER TABLE student ADD CONSTRAINT FK_stud_Roles
    FOREIGN KEY (RoleID) REFERENCES UserRoles(RoleID)

-- Relationship between StdAnswers and Student
ALTER TABLE StdAnswers ADD CONSTRAINT FK_StdAnswers_Student
    FOREIGN KEY (StdID) REFERENCES Student(ID)

-- Relationship between StdAnswers and Question
ALTER TABLE StdAnswers ADD CONSTRAINT FK_StdAnswers_Question
    FOREIGN KEY (QstID) REFERENCES Question(ID)

-- Relationship between StdAnswers and Exam
ALTER TABLE StdAnswers ADD CONSTRAINT FK_StdAnswers_Exam
    FOREIGN KEY (ExamID) REFERENCES Exam(ID)

-- Relationship between StudentExam and Student
ALTER TABLE StudentExam ADD CONSTRAINT FK_StudentExam_Student
    FOREIGN KEY (StudentID) REFERENCES Student(ID)

-- Relationship between StudentExam and Exam
ALTER TABLE StudentExam ADD CONSTRAINT FK_StudentExam_Exam
    FOREIGN KEY (ExamID) REFERENCES Exam(ID)

-- Relationship between Exam and Question
ALTER TABLE EXAM ADD CONSTRAINT FK_ExamQuestion
    FOREIGN KEY (QuestionID) REFERENCES question(ID)

-- Relationship between Course and Question
ALTER TABLE Question ADD CONSTRAINT FK_question_course
    FOREIGN KEY (CourseID) REFERENCES Course(ID)

-- Relationship between MCQuestion and Question
ALTER TABLE MCQuestion ADD CONSTRAINT FK_MCQ
    FOREIGN KEY (QuestionID) REFERENCES Question(ID)

-- Relationship between TFQuestion and Question
ALTER TABLE TFQuestion ADD CONSTRAINT FK_TFQuestion
    FOREIGN KEY (QuestionID) REFERENCES Question(ID)

-- Relationship between TxtQuestion and Question
ALTER TABLE TxtQuestion ADD CONSTRAINT FK_TxtQuestion
    FOREIGN KEY (QuestionID) REFERENCES Question(ID)

