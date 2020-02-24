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