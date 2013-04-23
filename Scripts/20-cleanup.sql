-- clean up - Search Binary Data
USE master
;
go
EXEC sp_fulltext_semantic_unregister_language_statistics_db
;
go
-- EXEC sys.sp_detach_db @dbname = N'statisticsdb'
go

DROP DATABASE UnstructuredData
GO
