--JOINS

SELECT * 
FROM Invoice i
JOIN InvoiceLine  il
ON il.InvoiceLineId=i.InvoiceId
WHERE il.UnitPrice>0.99;

SELECT 
i.InvoiceDate, 
i.Total,
c.FirstName,
c.LastName
FROM Invoice i
JOIN Customer c
ON c.CustomerId=i.CustomerId;

SELECT 
c.FirstName,
c.LastName,
e.FirstName,
e.LastName
FROM Customer c
JOIN Employee e
ON e.EmployeeId=c.SupportRepId;

SELECT 
al.title,
ar.name
FROM Album al
JOIN Artist ar
ON al.ArtistId=ar.ArtistId;

SELECT 
plt.TrackId
FROM PlaylistTrack plt
JOIN Playlist pl
ON pl.PlaylistId=plt.PlaylistId
WHERE pl.name= 'Music';

SELECT 
t.name
FROM Track t
JOIN PlaylistTrack plt
ON plt.TrackId=t.TrackId
WHERE plt.PlaylistId= 5;

SELECT 
t.name,
pl.name
FROM Track t
JOIN PlaylistTrack plt
ON plt.TrackId=t.TrackId
JOIN Playlist pl
ON pl.PlaylistId=plt.PlaylistId;

SELECT 
t.Name,
al.Title
FROM Track t
JOIN Album al
ON al.AlbumId=t.AlbumId
JOIN Genre g
ON g.GenreId=t.GenreId
WHERE g.Name='Alternative & Punk';

-- JOINS: BLACK DIAMOND
SELECT 
a.Name AS artist_name,
al.Title AS album_title,
g.Name AS genre_name,
t.Name AS track_name
FROM Artist a
JOIN Album al
ON al.ArtistId=a.ArtistId
JOIN Track t
ON t.AlbumId=al.AlbumId
JOIN Genre g
ON g.GenreId=t.GenreID
JOIN PlaylistTrack plt
ON plt.TrackID=t.TrackID
JOIN Playlist pl
ON pl.PlaylistId=plt.PlayListId;


--NESTED Queries

SELECT * 
FROM Invoice 
WHERE InvoiceID IN (
  SELECT InvoiceId FROM InvoiceLine WHERE UnitPrice>0.99); 

SELECT *
FROM PlaylistTrack
WHERE PlaylistId IN ( 
  SELECT PlaylistId FROM Playlist WHERE name = 'Music');  

SELECT Name
FROM Track
WHERE TrackId IN ( 
  SELECT TrackId FROM PlaylistTrack WHERE PlaylistId = 5);

SELECT *
FROM Track
WHERE GenreId IN ( 
  SELECT GenreId FROM Genre WHERE name = 'Comedy');

SELECT *
FROM Track
WHERE AlbumId IN ( 
  SELECT AlbumId FROM Album WHERE Title = 'Fireball');

SELECT *
FROM Track
WHERE AlbumId IN ( 
  SELECT AlbumId FROM Album WHERE ArtistId IN(
  SELECT ArtistID FROM Artist WHERE name='Queen'));


--UPDATING ROWS

UPDATE Customer 
SET Fax=null
WHERE Fax IS NOT null;

UPDATE Customer 
SET Company='Self'
WHERE Company IS null;

UPDATE Customer 
SET LastName='Thompson'
WHERE FirstName='Julia' AND LastName='Barnett';

UPDATE Customer 
SET SupportRepID=4
WHERE Email='luisrojas@yahoo.cl';

UPDATE Track 
SET Composer='The darkness Around us'
WHERE GenreId=(SELECT GenreID FROM Genre WHERE name='Metal')
AND Composer=null;


--GROUP BY

