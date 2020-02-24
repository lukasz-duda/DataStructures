EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'Email'
GO
USE [master]
GO
ALTER DATABASE Email SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
DROP DATABASE Email
GO

CREATE DATABASE Email
GO

USE Email
GO

CREATE TABLE Person
(
    Id smallint IDENTITY PRIMARY KEY,
    FirstName nvarchar(30) NOT NULL,
    LastName nvarchar(50) NOT NULL,
    EmailAddress nvarchar(100) NOT NULL
)

CREATE TABLE Email
(
    Id int IDENTITY PRIMARY KEY,
    SenderId smallint FOREIGN KEY REFERENCES Person(Id) NOT NULL,
    Topic nvarchar(50) NOT NULL,
    Body nvarchar(1000) NOT NULL
)

CREATE TABLE CC
(
    EmailId int FOREIGN KEY REFERENCES Email(Id),
    PersonId smallint FOREIGN KEY REFERENCES Person(Id)
)

CREATE TABLE BCC
(
    EmailId int FOREIGN KEY REFERENCES Email(Id),
    PersonId smallint FOREIGN KEY REFERENCES Person(Id)
)