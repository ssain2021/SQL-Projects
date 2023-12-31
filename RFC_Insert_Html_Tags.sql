USE [Gravy]
GO
/****** Object:  UserDefinedFunction [dbo].[RFC_Insert_Html_Tags]    Script Date: 05-05-2022 00:46:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--CREATE OR ALTER FUNCTION [dbo].[splitPosition] 

ALTER   FUNCTION [dbo].[RFC_Insert_Html_Tags] 
 ( @string varchar(max), @sep varchar(2)= ';' )  
--  Default Separator is ';'

RETURNS varchar(max)
AS
BEGIN
	if (@sep=':') or (@sep=' ') 
	  begin
		return  @string 
	  end

-- If html tags already exist. Return same string
	if (CHARINDEX('<ul>', @string) > 0 ) OR ( CHARINDEX('<li>', @string) > 0 ) 	
	  begin
		return  @string 
	  end

	if (CHARINDEX(@sep, @string) <= 0 )  -- No  Delimiter. Return String.
	  begin
		return @string
	  end

-- Remove the first Leading semicolon
	if (LEFT(@string, 1) = @sep ) 
	  begin
	    set @string = SUBSTRING(@string, 2, (len(@string)-1))
	  end

	set @string = trim(@string)

-- Remove the Last Leading semicolon
	if (RIGHT(@string, 1) = @sep ) 
	  begin
	    set @string = SUBSTRING(@string, 1, (len(@string)-1))
	  end

	set @string = trim(@string)

  if ( CHARINDEX(';;', @string) > 0 OR CHARINDEX('::', @string) > 0 OR CHARINDEX(':;', @string) > 0 )
    Begin
	  set @string = Replace(@string, ';;', ';')
	  set @string = Replace(@string, '::', ':')
	  set @string = Replace(@string, ':;', ': ;')
    End

	---- Check Only ';' is Present, No ':' for Tags. Insert Html <li> <ul> Tags Only.    
	if (CHARINDEX(':', @string) <= 0 )  -- No Label ':' Separator, Insert Html Tags
	  begin
		set @string = replace(@string,@sep,'</li><li>')
		set @string = '<ul><li>' + @string + '</li></ul>'
		return @string
	  end

	declare @ix int=1
	declare @nsep int=0
	declare @oldposition int=0
	declare @position int=0
	declare @Flag varchar(10)='F'
	declare @temp varchar(max)=''
	declare @Final varchar(max)=''

	set @nsep=len(@string) - len(replace(@string,@sep,''))

  if (CHARINDEX(@sep, @string) <= 0 )    --  No Separator. Exceptional case
	Begin
	  set @Flag = 'X'
	End

	if (RIGHT(@string, 1) <> @sep ) 
	 begin
	   set @Flag = 'T'
	 end

	while @ix <= @nsep 
	  begin
	    set @position = CHARINDEX(@sep, @string, @oldposition)
	    set @temp = SUBSTRING(@string, @oldposition, (@position - @oldposition))
	    set @temp = '<li><b>' + replace(@temp, ':', '</b>:') + '</li>'
		set @Final = @Final + @temp

		set @oldposition = @position + 1
        set @ix = @ix +1
	  end

	if (@Flag = 'X') 
	begin
	  set @temp = @string
	  set @temp = '<li><b>' + replace(@temp, ':', '</b>:') + '</li>'
	  set @Final = @Final + @temp
	End

	if (@Flag = 'T') 
	begin
		set @temp = SUBSTRING(@string, @oldposition, (len(@string) - @oldposition+1))
		set @temp = '<li><b>' + replace(@temp, ':', '</b>:') + '</li>'
		set @Final = @Final + @temp
	end

	set @Final = '<ul>' + @Final + '</ul>'
	return trim(@Final)

END


 