-- FREETEXT
USE UnstructuredData
go

  -- basic freetext
SELECT
 name
 FROM authordrafts
 WHERE FREETEXT(*, 'Fast Track Data Warehouse')
 ORDER BY name
 ;

-- why so many?


-- Let's be more specific
SELECT
  name
 FROM authordrafts
 WHERE FREETEXT(File_stream, 'Data Warehouse')
 ORDER BY name
 ;

-- Let's be more specific
SELECT
  name
 FROM authordrafts
 WHERE FREETEXT(File_stream, 'Data')
 ORDER BY name
 ;


USE AdventureWorks2008
go


SELECT Title
FROM Production.Document
WHERE FREETEXT (Document, 'vital safety components' );
GO
SELECT Title
FROM Production.Document
WHERE FREETEXT (Document, 'vital safety' );
GO
SELECT Title
FROM Production.Document
WHERE FREETEXT (Document, 'vital' );
GO
