USE [master]
GO
CREATE DATABASE [semanticsdb] ON 
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\semanticsdb.mdf' ),
( FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\semanticsdb_log.ldf' )
 FOR ATTACH
GO



-- refresh databases

-- expand Semantic DB
-- What's in here?

-- register
EXEC sp_fulltext_semantic_register_language_statistics_db N'semanticsdb'
;









-- check
select 
   database_id ,
   register_date ,
   registered_by ,
   version 
 from sys.fulltext_semantic_language_statistics_database






-- check languages
SELECT 
  lcid ,
  name
 FROM sys.fulltext_semantic_languages
GO




-- check this worked for the table
USE UnstructuredData
;
GO 
SELECT OBJECTPROPERTYEX(OBJECT_ID('AuthorDrafts'), 'TableFullTextSemanticExtraction')
GO
          

-- check this worked for the column
SELECT COLUMNPROPERTY(OBJECT_ID('AuthorDrafts'), 'File_Stream', 'StatisticalSemantics')
GO

-- check the table
SELECT 
  object_id ,
  column_id ,
  type_column_id ,
  language_id ,
  statistical_semantics
 FROM sys.fulltext_index_columns
 WHERE object_id = OBJECT_ID('dbo.Authordrafts')
GO
                  


