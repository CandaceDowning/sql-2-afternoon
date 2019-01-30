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

-- BLACK DIAMOND
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


