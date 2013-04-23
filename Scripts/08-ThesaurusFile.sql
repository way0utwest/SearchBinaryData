-- thesaurus files

-- ts + (three letter language) + .xml
-- tseng.xml - Not US English
-- tsenu.xml

-- edit manually. First time, remove comments


-- load thesaurus File
USE UnstructuredData
;
GO
EXEC sys.sp_fulltext_load_thesaurus_file 1033;
GO

SELECT
 name
 FROM authordrafts
 WHERE FREETEXT(*, 'wheelbarrow')
 ;
go
-- check pdf


-- both work
SELECT
 name
 FROM authordrafts
 WHERE FREETEXT(*, 'handbarrow')
 ;

