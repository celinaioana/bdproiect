USE [master]
GO
/****** Object:  Database [dbproject]    Script Date: 5/31/2023 5:10:24 PM ******/
CREATE DATABASE [dbproject]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbproject', FILENAME = N'D:\sql\MSSQL16.SQLEXPRESS\MSSQL\DATA\dbproject.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbproject_log', FILENAME = N'D:\sql\MSSQL16.SQLEXPRESS\MSSQL\DATA\dbproject_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [dbproject] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbproject].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbproject] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbproject] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbproject] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbproject] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbproject] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbproject] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [dbproject] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbproject] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbproject] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbproject] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbproject] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbproject] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbproject] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbproject] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbproject] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbproject] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbproject] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbproject] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbproject] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbproject] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbproject] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbproject] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbproject] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbproject] SET  MULTI_USER 
GO
ALTER DATABASE [dbproject] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbproject] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbproject] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbproject] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbproject] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbproject] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [dbproject] SET QUERY_STORE = ON
GO
ALTER DATABASE [dbproject] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [dbproject]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateAverageFeeAmount]    Script Date: 5/31/2023 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CalculateAverageFeeAmount]()
returns decimal(10, 2)
as begin
declare @average_amount decimal(10, 2)
select @average_amount = AVG(amount) from fees
return @average_amount
end
GO
/****** Object:  UserDefinedFunction [dbo].[CalculateTotalFeeAmount]    Script Date: 5/31/2023 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CalculateTotalFeeAmount](@id int)
returns decimal(10, 2)
as begin
declare @total_amount decimal(10, 2)
select @total_amount = SUM(amount) from fees
where student_id = @id
return @total_amount
end 
GO
/****** Object:  Table [dbo].[attendance]    Script Date: 5/31/2023 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendance](
	[attendance_id] [int] NOT NULL,
	[student_id] [int] NULL,
	[course_id] [int] NULL,
	[date_course] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[attendance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[courses]    Script Date: 5/31/2023 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courses](
	[course_id] [int] NOT NULL,
	[course_name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fees]    Script Date: 5/31/2023 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fees](
	[fee_id] [int] NOT NULL,
	[student_id] [int] NULL,
	[amount] [decimal](10, 2) NULL,
	[payment_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[fee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[scholarships]    Script Date: 5/31/2023 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[scholarships](
	[scholarship_id] [int] NOT NULL,
	[student_id] [int] NULL,
	[scholarship_name] [varchar](100) NOT NULL,
	[amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[scholarship_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[students]    Script Date: 5/31/2023 5:10:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students](
	[id] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[address] [varchar](200) NOT NULL,
	[contact_information] [varchar](100) NOT NULL,
	[admission_year] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (1, 1, 1, CAST(N'2023-05-17' AS Date))
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (2, 2, 3, CAST(N'2023-04-12' AS Date))
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (3, 3, 2, CAST(N'2023-03-15' AS Date))
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (4, 4, 6, CAST(N'2023-02-08' AS Date))
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (5, 5, 4, CAST(N'2023-01-31' AS Date))
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (6, 5, 3, CAST(N'2023-02-14' AS Date))
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (8, 8, 6, CAST(N'2023-06-02' AS Date))
INSERT [dbo].[attendance] ([attendance_id], [student_id], [course_id], [date_course]) VALUES (10, 7, 1, CAST(N'2023-04-19' AS Date))
GO
INSERT [dbo].[courses] ([course_id], [course_name]) VALUES (1, N'Teoria Sistemelor')
INSERT [dbo].[courses] ([course_id], [course_name]) VALUES (2, N'Baze de date')
INSERT [dbo].[courses] ([course_id], [course_name]) VALUES (3, N'Matematici Speciale')
INSERT [dbo].[courses] ([course_id], [course_name]) VALUES (4, N'Inf. aplicata')
INSERT [dbo].[courses] ([course_id], [course_name]) VALUES (5, N'Modelarea Proceselor')
INSERT [dbo].[courses] ([course_id], [course_name]) VALUES (6, N'Semnale si sisteme')
GO
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (1, 1, CAST(1000.00 AS Decimal(10, 2)), CAST(N'2023-05-17' AS Date))
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (2, 1, CAST(1200.00 AS Decimal(10, 2)), CAST(N'2023-04-16' AS Date))
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (3, 2, CAST(1400.00 AS Decimal(10, 2)), CAST(N'2023-06-18' AS Date))
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (4, 3, CAST(1000.00 AS Decimal(10, 2)), CAST(N'2023-06-18' AS Date))
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (5, 5, CAST(1100.00 AS Decimal(10, 2)), CAST(N'2023-06-18' AS Date))
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (6, 6, CAST(1300.00 AS Decimal(10, 2)), CAST(N'2023-06-18' AS Date))
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (7, 4, CAST(1800.00 AS Decimal(10, 2)), CAST(N'2023-06-18' AS Date))
INSERT [dbo].[fees] ([fee_id], [student_id], [amount], [payment_date]) VALUES (8, 8, CAST(1900.00 AS Decimal(10, 2)), CAST(N'2023-06-18' AS Date))
GO
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (1, 1, N'Bursa de merit', CAST(1900.00 AS Decimal(10, 2)))
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (2, 3, N'Bursa de merit', CAST(1900.00 AS Decimal(10, 2)))
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (3, 4, N'Bursa sociala', CAST(1000.00 AS Decimal(10, 2)))
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (4, 2, N'Bursa performanta', CAST(2400.00 AS Decimal(10, 2)))
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (5, 5, N'Bursa de merit', CAST(1900.00 AS Decimal(10, 2)))
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (6, 6, N'Bursa performanta', CAST(2400.00 AS Decimal(10, 2)))
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (7, 7, N'Bursa sociala', CAST(1000.00 AS Decimal(10, 2)))
INSERT [dbo].[scholarships] ([scholarship_id], [student_id], [scholarship_name], [amount]) VALUES (8, 8, N'Bursa performanta', CAST(2400.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (1, N'Maria Pop', N'str. Libertatii, 15', N'popmaria@gmail.com', 2021)
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (2, N'Alex Rusu', N'str. Lalelelor, 28', N'alexrusu@gmail.com', 2019)
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (3, N'Matei Olpa', N'str. Unirii, 39', N'olpa123@yahoo.com', 2020)
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (4, N'Jessica Alba', N'str. ICB, 45', N'jessica@gmail.com', 2018)
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (5, N'Eva Longoria', N'str. Petuniei, 76', N'evalong@yahoo.com', 2016)
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (6, N'Jennifer Aniston', N'str. NYU, 99', N'jenniferan@yahoo.com', 2017)
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (7, N'Matt LeBlanc', N'str. Rozelor, 90A', N'mattlebl@yahoo.com', 2016)
INSERT [dbo].[students] ([id], [name], [address], [contact_information], [admission_year]) VALUES (8, N'Courtney Cox', N'str. CDG, 36', N'courtneycox@yahoo.com', 2017)
GO
ALTER TABLE [dbo].[attendance]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[courses] ([course_id])
GO
ALTER TABLE [dbo].[attendance]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[students] ([id])
GO
ALTER TABLE [dbo].[fees]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[students] ([id])
GO
ALTER TABLE [dbo].[scholarships]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[students] ([id])
GO
/****** Object:  StoredProcedure [dbo].[GetStudentDetails]    Script Date: 5/31/2023 5:10:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetStudentDetails](@id int, @name varchar(100), @address varchar(200), @contact_information varchar(100), @addmission_year int)
as begin
select * from students where id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[GetStudentsWithTotalFees]    Script Date: 5/31/2023 5:10:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetStudentsWithTotalFees](@student_id int)
AS BEGIN
    SELECT s.name, SUM(f.amount) AS total_fees
    FROM students s
    INNER JOIN fees f ON s.id = f.student_id
    GROUP BY s.name
    HAVING SUM(f.amount) > 1000;
END;
GO
/****** Object:  Trigger [dbo].[CustomInsertScholarship]    Script Date: 5/31/2023 5:10:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[CustomInsertScholarship]
ON [dbo].[scholarships]
INSTEAD OF INSERT
AS
BEGIN
    
    DECLARE @newScholarshipId INT;
    SET @newScholarshipId = (SELECT MAX(scholarship_id) + 1 FROM scholarships);
    
    INSERT INTO scholarships (scholarship_id, student_id, scholarship_name, amount)
    SELECT @newScholarshipId, student_id, scholarship_name, amount
    FROM INSERTED;

    DECLARE @student_id INT;
    SET @student_id = (SELECT student_id FROM INSERTED);
    
    UPDATE scholarships
	SET amount = amount + 1
    WHERE student_id = @student_id;
END;
GO
ALTER TABLE [dbo].[scholarships] ENABLE TRIGGER [CustomInsertScholarship]
GO
/****** Object:  Trigger [dbo].[UpdateTotalScholarshipAmount]    Script Date: 5/31/2023 5:10:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[UpdateTotalScholarshipAmount]
on [dbo].[scholarships] 
after insert, update, delete
as begin
declare @id int
set @id = (select student_id from inserted)
update scholarships
set amount = (select SUM(amount) from scholarships where student_id = @id)
where student_id = @id
end
GO
ALTER TABLE [dbo].[scholarships] ENABLE TRIGGER [UpdateTotalScholarshipAmount]
GO
/****** Object:  Trigger [dbo].[UpdateAdmissionYear]    Script Date: 5/31/2023 5:10:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[UpdateAdmissionYear]
on [dbo].[students] after insert
as begin
update students
set admission_year = year(GETDATE())
where id = (select id from inserted) 
end
GO
ALTER TABLE [dbo].[students] ENABLE TRIGGER [UpdateAdmissionYear]
GO
USE [master]
GO
ALTER DATABASE [dbproject] SET  READ_WRITE 
GO
