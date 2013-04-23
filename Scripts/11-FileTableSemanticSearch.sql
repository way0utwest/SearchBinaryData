-- semantickeyphrase
USE UnstructuredData
;
go

-- most common phrases in all documents
SELECT name, document_key, keyphrase, score
 FROM semantickeyphrasetable( AuthorDrafts, *) AS b
   INNER JOIN AuthorDrafts a
     ON a.path_locator = b.document_key
 ORDER BY
    name
  , score DESC
 ;
   
-- row 881






