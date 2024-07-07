USE Library
-- 1
CREATE FUNCTION BookPages()
RETURNS table
AS
RETURN(
SELECT  B. [Name] AS [Book name], P.[Name] AS [Press name], B.Pages I
FROM [Books] AS B
JOIN [Press] AS P ON B.Id_Press = P. Id
WHERE B.Pages = (SELECT MIN(Pages) 
				 FROM [Books]
				 WHERE Id_Press = B.Id_Press)
)

SELECT *
FROM BookPages()
-- 2
CREATE FUNCTION PubName(@PagesNumber AS int)
RETURNS table
AS
RETURN(
SELECT P.Name
FROM Books AS B
JOIN Press AS P ON B.Id_Press = P. Id
GROUP BY P.Name
HAVING AVG(B.Pages) > @PagesNumber
)

SELECT *
FROM PubName(100)