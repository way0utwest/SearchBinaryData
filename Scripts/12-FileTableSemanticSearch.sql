-- Find the Key Phrases in a Document
USE UnstructuredData
;
go

DECLARE @DocID hierarchyid

SELECT @DocID = path_locator 
 from dbo.AuthorDrafts
 where name = 'The_Adventures_of_Tom_Sawyer_NT.pdf'
-- where name = 'stardragon-obooko-scifi0024.pdf'

SELECT keyphrase, score
    FROM SEMANTICKEYPHRASETABLE(AuthorDrafts, *, @DocID)
    ORDER BY score DESC
GO

-- find document with a particular key phrase
SELECT TOP (25) DOC_TBL.Name, DOC_TBL.path_locator
FROM dbo.AuthorDrafts AS DOC_TBL
    INNER JOIN SEMANTICKEYPHRASETABLE
    (
    dbo.AuthorDrafts,
    file_stream
    ) AS KEYP_TBL
ON DOC_TBL.path_locator = KEYP_TBL.document_key
WHERE KEYP_TBL.keyphrase = 'whitewash'
ORDER BY KEYP_TBL.Score DESC;
GO

SELECT TOP (25) DOC_TBL.Name, DOC_TBL.path_locator
FROM dbo.AuthorDrafts AS DOC_TBL
    INNER JOIN SEMANTICKEYPHRASETABLE
    (
    dbo.AuthorDrafts,
    file_stream
    ) AS KEYP_TBL
ON DOC_TBL.path_locator = KEYP_TBL.document_key
WHERE KEYP_TBL.keyphrase = 'ship'
ORDER BY KEYP_TBL.Score DESC;
GO
-- check dracula



-- Find the Key Phrases That Make Documents Similar or Related
declare @SourceTitle nvarchar(100),@MatchedTitle  nvarchar(100), @SourceDocID hierarchyid, @MatchedDocID hierarchyid

SET @SourceTitle = 'The_Adventures_of_Tom_Sawyer_NT.pdf'
SET @MatchedTitle = 'Pride_and_Prejudice_NT.pdf'

 
SELECT @SourceDocID = path_locator FROM dbo.AuthorDrafts WHERE Name = @SourceTitle
SELECT @MatchedDocID = path_locator FROM dbo.AuthorDrafts WHERE Name = @MatchedTitle


SELECT @SourceTitle AS SourceTitle, @MatchedTitle AS MatchedTitle, keyphrase, score
 FROM semanticsimilaritydetailstable( dbo.AuthorDrafts
                                    , file_stream
									, @SourceDocID
									, file_stream
									, @MatchedDocID
									)
ORDER BY score DESC

-- check documents that might use a keyphrase here
SELECT TOP (25) 
    Term = 'Aunt'
  , DOC_TBL.Name
  , keyp_tbl.Score
FROM dbo.AuthorDrafts AS DOC_TBL
    INNER JOIN SEMANTICKEYPHRASETABLE
    (
    dbo.AuthorDrafts,
    file_stream
    ) AS KEYP_TBL
ON DOC_TBL.path_locator = KEYP_TBL.document_key
WHERE KEYP_TBL.keyphrase = 'disaster'
ORDER BY KEYP_TBL.Score DESC;
go


-- find documents that have a semantic meaning of disaster.
SELECT TOP (25) 
    Term = 'Disaster'
  , DOC_TBL.Name
  , keyp_tbl.Score
FROM dbo.AuthorDrafts AS DOC_TBL
    INNER JOIN SEMANTICKEYPHRASETABLE
    (
    dbo.AuthorDrafts,
    file_stream
    ) AS KEYP_TBL
ON DOC_TBL.path_locator = KEYP_TBL.document_key
WHERE KEYP_TBL.keyphrase = 'disaster'
-- AND file_type = 'docx'
ORDER BY KEYP_TBL.Score DESC;


-- try a new term
SELECT TOP (25) 
  Term = 'Availability'
  , DOC_TBL.Name
  , keyp_tbl.Score
FROM dbo.AuthorDrafts AS DOC_TBL
    INNER JOIN SEMANTICKEYPHRASETABLE
    (
    dbo.AuthorDrafts,
    file_stream
    ) AS KEYP_TBL
ON DOC_TBL.path_locator = KEYP_TBL.document_key
WHERE KEYP_TBL.keyphrase = 'availability'
--AND file_type = 'docx'
ORDER BY KEYP_TBL.Score DESC;


