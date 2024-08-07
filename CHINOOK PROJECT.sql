-- Top 5 customers who spent the most, to get this info we need to extract data from the customer and invoice table 
SELECT CONCAT(FirstName, ' ', LastName) AS Top_5_customers
	FROM customer
INNER JOIN 
	invoice 
ON
	customer.CustomerId = invoice.CustomerId
ORDER BY 
	Total DESC
LIMIT 5;


-- the second tasks requires that i list all the invoices and the name of the customers who placed them
-- to do this i need to draw data from the customer table and invoice table
SELECT CONCAT(c.FirstName, ' ',c.LastName) AS Customer_name, i.InvoiceId AS Invoices 
	FROM customer c
INNER JOIN 
	invoice i 
ON 
	c.CustomerId = i.CustomerId
ORDER BY 
	Invoices;


-- the third task requires that i identify the most popular genre i.e the genre with the most tracks
-- to get this informaion we had to collect data from the genre and track table
SELECT g.`Name` AS Most_popular_genre
	FROM genre g
INNER JOIN 
	track t 
ON 
	g.GenreId = t.GenreId
ORDER BY 
	TrackId DESC
LIMIT 1;


-- task 5 requires that we find the total sale for each country 
-- to get this information we had to retrieve data from the customer and invoice table
SELECT c.Country, SUM(ROUND(Total)) AS Total_sales
	FROM customer c
INNER JOIN 
	invoice i 
ON
	c.CustomerId = i.CustomerId
GROUP BY 
	Country
ORDER BY 
	Total_sales DESC;


-- Task no 6 , get the names of the customers with more than 5 invoices 
SELECT DISTINCT CONCAT(c.FirstName, ' ', c.LastName) AS Customer
	FROM invoice i 
INNER JOIN 
	customer c 
ON 
	I.CustomerId = c.customerId 
WHERE 
	InvoiceId > 5
ORDER BY 
	Customer;


-- task no 7, list all the playlist and the number of tracks in each. I would need three tables to achieve this task 
-- first i identify the tables and determine their relationship
SELECT 
	* 
FROM 
	playlist;
SELECT * 
	FROM track;
SELECT * 
	FROM playlisttrack;
-- after looking at the tables i discover that the trackid has the wrong format which can have a very negative effect on our result soo i correct the data type changing it to a string format.
ALTER TABLE 
	track
MODIFY COLUMN 
	TrackId TEXT;

-- next I join the relevant tables to carry out the given task
SELECT p.`Name` AS Playlists, COUNT(t.TrackId) AS Tracks_total
	FROM track t
INNER JOIN 
	playlisttrack pt 
ON
    t.TrackId = pt.TrackId
INNER JOIN 
	playlist p 
ON 
    pt.PlaylistId = p.PlaylistId
GROUP BY 
	Playlists
ORDER BY 
	Tracks_total DESC;


-- task no 10 find the total no of invoices for each customer 
-- identify the relevant tables 
SELECT * 
	FROM invoice;
SELECT * 
	FROM customer;
-- I NEED TO CORRECT THE InvoiceId data type AND CHANGE IT FROM INTEGER TO STRING 
ALTER TABLE 
	invoice
MODIFY COLUMN 
	InvoiceId TEXT;

-- JOIN BOTH TABLES TO ANSWER THE TASK 
SELECT 
	CONCAT(c.FirstName, ' ', c.LastName) AS Customer, COUNT(i.InvoiceId) AS Invoices_total
FROM 
	customer c
INNER JOIN 
	invoice i 
ON
	c.CustomerId = i.CustomerId
GROUP BY 
	Customer
ORDER BY 
	Invoices_total DESC;


-- Task no 13 find the average invoice total for customers in each country
SELECT 
	* FROM invoice;
SELECT 
	* FROM customer;
-- change the datatype of the invoiceid AND Customer id column to text 
ALTER TABLE 
	invoice
MODIFY COLUMN 
	InvoiceId TEXT,
MODIFY COLUMN 
	CustomerId TEXT;

ALTER TABLE 
	customer
MODIFY COLUMN 
	CustomerId TEXT;

-- answer the task 
SELECT 
	c.Country, AVG(i.Total) AS Average_total_sales
FROM 
    invoice i
INNER JOIN customer c ON 
	i.CustomerId = c.CustomerId
GROUP BY 
	Country;

-- task no 14 identify customers who never made a purchase 
SELECT * 	
	FROM customer;
    
SELECT * 
	FROM invoice;

SELECT 
	CONCAT(c.FirstName, ' ', c.LastName) AS Customer_Name
FROM 
   customer c
INNER JOIN invoice i ON
	 i.CustomerId = c.CustomerId
WHERE i.InvoiceId IS NULL;

-- TASK 15 FIND THE INVOICE WITH THE HIGHEST TOTAL AMOUNT 
SELECT *
	FROM invoice;
    
SELECT InvoiceId AS Invoice_with_the_highest_total_amount
	FROM invoice
ORDER BY Total DESC
LIMIT 1;

-- task 16 list albums with more than 10 tracks 
-- first a have general overview of the table 
SELECT * 
	FROM track;
-- write the query to perform the task
SELECT AlbumId AS Album
	FROM track
GROUP BY Album
	HAVING COUNT(TrackId) > 10;
    
    
-- PROBLEM STATEMENT
-- Identify customers at risk of churn based on customers who didnt purchase 6 months from the last sales date 
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS Customers_at_risk_of_churn
	FROM customer c
WHERE c.CustomerId NOT IN (
     SELECT DISTINCT i.CustomerId
     FROM invoice i
     WHERE i.InvoiceDate >= DATE_SUB('2013-12-31', INTERVAL 6 MONTH)
);  





