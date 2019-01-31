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

SELECT COUNT(*), g.Name 
FROM Track t
JOIN Genre g 
ON t.GenreId=g.GenreId
GROUP BY g.Name;

SELECT COUNT(*), g.name
FROM Track t
JOIN Genre g 
ON t.GenreId=g.GenreId
WHERE g.Name = 'Pop' OR g.Name='Rock' 
GROUP BY g.Name ;

SELECT a.name, COUNT(*)
FROM Album al
JOIN Artist a
ON al.ArtistId=a.ArtistId
GROUP BY a.Name ;


--USE DISTINCT

SELECT DISTINCT composer
FROM Track;

SELECT DISTINCT BillingPostalCode
FROM Invoice;

SELECT DISTINCT Company
FROM Customer;


--DELETE

DELETE FROM practice_delete
WHERE type='bronze';

DELETE FROM practice_delete
WHERE type='silver';

DELETE FROM practice_delete
WHERE value=150;


--ECOMMERCE SIMULATION

CREATE TABLE users(
  u_key SERIAL PRIMARY KEY,
  u_name text,
  email text
);

CREATE TABLE product(
  p_key SERIAL PRIMARY KEY,
  p_name text,
  price integer
);

CREATE TABLE orders(
  o_key SERIAL PRIMARY KEY,
  o_number integer,
  u_key integer REFERENCES users(u_key),
  p_key integer REFERENCES product(p_key)
);

INSERT INTO users(u_name, email)
VALUES
('Billy', 'billyboy@bmail.com'),
('Shelly', 'shellybelly@dbomail.com'),
('Chad', 'thegreateste@ball.com');

INSERT INTO product(p_name, price)
VALUES
('A Rock', 3),
('Pencil Nubbin', 20),
('ABC Gum', 80);

INSERT INTO orders(o_number, u_key, p_key)
VALUES
(1, (SELECT u_key FROM users WHERE u_name='Billy'), (SELECT p_key FROM product WHERE p_key=1)),
(1, (SELECT u_key FROM users WHERE u_name='Billy'), (SELECT p_key FROM product WHERE p_key=2)),
(1, (SELECT u_key FROM users WHERE u_name='Billy'), (SELECT p_key FROM product WHERE p_key=3)),

(2, (SELECT u_key FROM users WHERE u_name='Shelly'), (SELECT p_key FROM product WHERE p_key=1)),
(2, (SELECT u_key FROM users WHERE u_name='Shelly'), (SELECT p_key FROM product WHERE p_key=2)),

(3, (SELECT u_key FROM users WHERE u_name='Chad'), (SELECT p_key FROM product WHERE p_key=3)),
(3, (SELECT u_key FROM users WHERE u_name='Chad'), (SELECT p_key FROM product WHERE p_key=3)),
(3, (SELECT u_key FROM users WHERE u_name='Chad'), (SELECT p_key FROM product WHERE p_key=3)),
(3, (SELECT u_key FROM users WHERE u_name='Chad'), (SELECT p_key FROM product WHERE p_key=2));

SELECT p_name 
FROM product p
JOIN orders o
ON o.p_key=p.p_key
WHERE o_number=1;

SELECT * FROM orders;

SELECT SUM(price)
FROM product
WHERE p_key IN(
  SELECT p_key from orders WHERE o_number=1)

SELECT *
FROM orders
WHERE u_key IN(
  SELECT u_key from users WHERE u_name='Chad')

SELECT COUNT (DISTINCT o_number)
FROM orders
WHERE u_key IN(
  SELECT u_key from users WHERE u_name='Chad')
