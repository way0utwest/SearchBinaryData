-- full text searching
USE UnstructuredData
;
go



-- get keywords in index
SELECT TOP 100
	keyword
  , display_term
  , column_id
  , document_count
 FROM sys.dm_fts_index_keywords( DB_ID('UnstructuredData'), OBJECT_ID('AuthorDrafts'))
;
go

SELECT TOP 100
  keyword
, display_term
, column_id
, document_id
, occurrence_count
 FROM sys.dm_fts_index_keywords_by_document( DB_ID('UnstructuredData'), OBJECT_ID('AuthorDrafts'))
 WHERE display_term > 'aa'
;
go




-- look at the what the parser sees
SELECT
 *
  FROM sys.dm_fts_parser('FORMSOF( INFLECTIONAL, ''Ship'')', 1033, 0, 0)
;
go




-- contains - simple search
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(*, 'AlwaysOn')
 ;
 go
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'Always*')
 ;
 go
 SELECT
   name
  FROM authordrafts
  WHERE CONTAINS(file_stream, 'shipped')
  ORDER BY name
 ;
 go

 SELECT
   name
  FROM authordrafts
  WHERE CONTAINS(file_stream, 'ship')
  ORDER BY NAME
;
 go
-- stirred




-- contains with two terms
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'Shipping')
 ;
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'Log and Shipping')
 ;
 go
 -- huck finn, search "log"




-- near
SELECT
  name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'NEAR((Log, Shipping),2)')
 ;
 go



-- near
SELECT
  name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'NEAR((Log, Shipping),3000)')
 ;
 go



-- Use Tom Sawyer
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'NEAR((whitewash, brush),3)')
 ;
go
 -- page 16



 -- add length
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'NEAR((whitewash, brush),4)')
 ;
 go

 
-- contains, NOT operator
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'Robin and not "hood"')
 ;
 go
 


 -- formsof, inflectional and thesaurus
SELECT
  name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'mirror')
 ORDER BY name 
 ;
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'FORMSOF (INFLECTIONAL, mirror)')
 ORDER BY name 
 ;
  -- A Christmas Carol not in the first (search "mirrors")
go
SELECT
 name
 FROM authordrafts
 WHERE CONTAINS(file_stream, 'FORMSOF (INFLECTIONAL, rains)')
 ORDER BY name 
 ;
 -- Tom Sawyer, search "rains", "rain"



-- containstable, weight
SELECT
  b.[key]
, b.[rank]
 FROM CONTAINSTABLE(dbo.AuthorDrafts, file_stream, 'log and shipping') b
;



SELECT
   a.name
 , b.rank
 FROM authordrafts a
   INNER JOIN CONTAINSTABLE(dbo.AuthorDrafts, file_stream, 'log and shipping') b
     ON a.path_locator = b.[key]
 ORDER BY b.RANK DESC
 ;



SELECT
   a.name
 , b.rank
 FROM authordrafts a
   INNER JOIN CONTAINSTABLE(dbo.AuthorDrafts, file_stream, 
                            'ISABOUT( disaster weight(.9), log WEIGHT (.2), shipping weight(.2))') b
     ON a.path_locator = b.[key]
 ORDER BY b.RANK DESC
 ;

go








 -- add more properties 



 -- containstable



 -- containstable, isabout
