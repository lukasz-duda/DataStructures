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
    Id bigint IDENTITY PRIMARY KEY,
    SenderId smallint FOREIGN KEY REFERENCES Person(Id) NOT NULL,
    [Subject] nvarchar(50) NOT NULL,
    Body nvarchar(1000) NOT NULL,
    Footer nvarchar(50) NOT NULL
)

CREATE TABLE Recipient
(
    EmailId bigint FOREIGN KEY REFERENCES Email(Id),
    PersonId smallint FOREIGN KEY REFERENCES Person(Id)
)

CREATE TABLE CopyRecipient
(
    EmailId bigint FOREIGN KEY REFERENCES Email(Id),
    PersonId smallint FOREIGN KEY REFERENCES Person(Id)
)

CREATE TABLE Attachment
(
    Id int PRIMARY KEY,
    [FileName] nvarchar(50) NOT NULL,
    Extension nvarchar(5) NOT NULL,
    FilePath nvarchar(255) NOT NULL,
    EmailId bigint FOREIGN KEY REFERENCES Email(Id)
)
   
select
    o.name AS [Table name],
    sum(c.max_length) AS [Maximum row length]
from sys.columns c
join sys.objects o on o.object_id = c.object_id
where o.type = 'u'
group by o.name