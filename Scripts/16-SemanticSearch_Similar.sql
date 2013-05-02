-- why are they similar?
USE UnstructuredData
;
GO
declare @First nvarchar(100)
      , @Second  nvarchar(100)
	  , @FirstID HIERARCHYID
	  , @SecondID hierarchyid
;

SET @First = 'The_Adventures_of_Huckleberry_Finn_NT.pdf';
-- SET @First = 'stardragon-obooko-scifi0024.pdf';
SET @Second = 'The_Adventures_of_Tom_Sawyer_NT.pdf';
-- SET @Second = 'NeptuneCrossing-obooko-scifi0033.pdf'

SELECT @FirstID = path_locator 
 FROM dbo.AuthorDrafts
 WHERE Name = @First
 ;
SELECT @SecondID = path_locator
 FROM dbo.AuthorDrafts
  WHERE Name = @Second
;
 

SELECT 
   keyphrase
 , score
 , original = @First
 , Match = @Second 
 FROM semanticsimilaritydetailstable(dbo.AuthorDrafts, file_stream, @FirstID, file_stream, @SecondID)
 ORDER BY 
   score DESC
;
GO


-- technical docs
declare @First nvarchar(100)
      , @Second  nvarchar(100)
	  , @FirstID HIERARCHYID
	  , @SecondID hierarchyid
;

SET @First = 'SharePoint SSIS Adapters 2011.docx';
SET @Second = 'Exporting Master Data from Master Data Services.docx';

SELECT @FirstID = path_locator 
 FROM dbo.AuthorDrafts
 WHERE Name = @First
 ;
SELECT @SecondID = path_locator
 FROM dbo.AuthorDrafts
  WHERE Name = @Second
;
 

SELECT 
   keyphrase
 , score
 , original = @First
 , Match = @Second 
 FROM semanticsimilaritydetailstable(dbo.AuthorDrafts, file_stream, @FirstID, file_stream, @SecondID)
 ORDER BY 
   score DESC
;
GO
   