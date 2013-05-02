-- find similar documents to a source document
USE UnstructuredData
;
go

DECLARE @title VARCHAR(200)
      , @DocID HIERARCHYID
;

-- SET @Title = 'Dracula_NT.pdf';
-- SET @Title = 'The_Adventures_of_Huckleberry_Finn_NT.pdf';
-- SET @Title = 'The_Merry_Adventures_of_Robin_Hood_NT.pdf';
-- SET @Title = 'SharePoint SSIS Adapters 2011.docx';
-- SET @title = 'Crime_and_Punishment_NT.pdf'
-- SET @title = 'networking-english.pdf'
--  SET @title = 'Azure_Services_Platform.pdf'
-- SET @title = 'stardragon-obooko-scifi0024.pdf'

SELECT @DocID = path_locator
    FROM AuthorDrafts
    WHERE name = @Title
;

SELECT 
       MatchedTitle = Name 
	 , score = Score
	 , SourceTitle = @Title 
    FROM SEMANTICSIMILARITYTABLE(AuthorDrafts, *, @DocID)
    INNER JOIN AuthorDrafts ON path_locator = matched_document_key
    ORDER BY score DESC
;
