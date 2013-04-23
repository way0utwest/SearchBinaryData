-- FTS setup
-- ensure unstructured Data is created from FileTable demo
-- create a new database
create database UnstructuredData
go
-- add a filestream FG
ALTER DATABASE [UnstructuredData] ADD FILEGROUP [FS] CONTAINS FILESTREAM 
GO
-- Add a file to the Filestream FG
ALTER DATABASE [UnstructuredData] 
  ADD FILE ( NAME = N'UnstructuredFS', FILENAME = N'c:\fs\UnstructuredFS' ) TO FILEGROUP [FS]
go
-- Enable the database for access, specify the folder for storage. This is 
alter database UnstructuredData
  SET FILESTREAM 
      ( NON_TRANSACTED_ACCESS = FULL, 
	    DIRECTORY_NAME = N'FS' );
go
Use UnstructuredData
go
-- Create a filetable
CREATE TABLE AuthorDrafts AS FileTable with ( FileTable_Directory = 'Demo')
GO
-- check the table.
select 
   stream_id ,
   file_stream ,
   name ,
   path_locator ,
   parent_path_locator ,
   file_type ,
   cached_file_size ,
   creation_time ,
   last_write_time ,
   last_access_time ,
   is_directory ,
   is_offline ,
   is_hidden ,
   is_readonly ,
   is_archive ,
   is_system ,
   is_temporary
 from AuthorDrafts;
go

-- check the share
select  FileTableRootPath('dbo.AuthorDrafts');
go

-- copy ebooks and sample data

-- recheck the table
select 
   stream_id ,
   file_stream ,
   name ,
   path_locator ,
   parent_path_locator ,
   file_type ,
   cached_file_size ,
   creation_time ,
   last_write_time ,
   last_access_time ,
   is_directory ,
   is_offline ,
   is_hidden ,
   is_readonly ,
   is_archive ,
   is_system ,
   is_temporary
 from AuthorDrafts;
go

-- FTS index on Author Drafts
-- use GUI Wizard

/*
-- create catalog
CREATE FULLTEXT CATALOG AuthorDrafts_Catalog AS DEFAULT;
go
-- Index
-- Needs PK index name from table
-- Use wizard
CREATE FULLTEXT INDEX ON dbo.AuthorDrafts
    (name,
    file_stream TYPE COLUMN file_type)
    KEY INDEX PK__AuthorDr__5A5B77D5337E95C5
    ON AuthorDrafts_Catalog
    WITH
        CHANGE_TRACKING AUTO,
        STOPLIST = SYSTEM;

-- run full population
*/
