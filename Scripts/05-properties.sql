-- property lists
USE UnstructuredData
go


 -- contains, property()
 SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'Steve and Jones')
 ;
 go
-- create a search prroperty
CREATE SEARCH PROPERTY LIST TitleProperties;
GO
ALTER SEARCH PROPERTY LIST TitleProperties
   ADD 'Title'
   WITH ( PROPERTY_SET_GUID = 'F29F85E0-4FF9-1068-AB91-08002B27B3D9', PROPERTY_INT_ID = 2,
      PROPERTY_DESCRIPTION = 'System.Title - Title of the item.' );
GO


ALTER FULLTEXT INDEX ON dbo.AuthorDrafts
   SET SEARCH PROPERTY LIST TitleProperties
   WITH NO POPULATION
;
GO

ALTER FULLTEXT INDEX ON dbo.AuthorDrafts
   START FULL POPULATION
; 
go

SELECT name
 FROM dbo.AuthorDrafts 
 WHERE CONTAINS(PROPERTY(file_stream,'Title'), 'Steve and Jones'); 

SELECT name
 FROM dbo.AuthorDrafts 
 WHERE CONTAINS(PROPERTY(file_stream,'Title'), 'Steve'); 







ALTER SEARCH PROPERTY LIST TitleProperties
   ADD 'Author'
   WITH ( PROPERTY_SET_GUID = 'F29F85E0-4FF9-1068-AB91-08002B27B3D9', PROPERTY_INT_ID = 4,
      PROPERTY_DESCRIPTION = 'System.Author - Author of the item.' );
GO


ALTER FULLTEXT INDEX ON dbo.AuthorDrafts
   SET SEARCH PROPERTY LIST AuthorProperties
   WITH NO POPULATION
;
GO

ALTER FULLTEXT INDEX ON dbo.AuthorDrafts
   START FULL POPULATION
; 
go





-- check progress
SELECT  
  d.name ,
  catalog_id ,
  o.name ,
  population_type_description ,
  range_count ,
  completed_range_count ,
  outstanding_batch_count ,
  status_description ,
  completion_type_description ,
  worker_count ,
  queued_population_type_description ,
  start_time ,
  incremental_timestamp
 FROM sys.dm_fts_index_population p
  INNER JOIN master.sys.databases d
    ON p.database_id = d.database_id
  INNER JOIN sys.objects o
    ON p.table_id = o.object_id




-- check for properties
SELECT name
 FROM dbo.AuthorDrafts 
 WHERE CONTAINS(PROPERTY(file_stream,'Author'), 'Steve'); 

 SELECT name
 FROM dbo.AuthorDrafts 
 WHERE CONTAINS(PROPERTY(file_stream,'Author'), 'Beth'); 