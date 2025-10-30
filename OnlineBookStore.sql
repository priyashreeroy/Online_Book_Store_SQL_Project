SELECT * FROM Books ;
SELECT * FROM customers;
SELECT * FROM Orders;

--1) Retrieve all books in the "Fiction"genre:
SELECT * FROM Books 
WHERE genre='Fiction';
--2) Finds books published after the year 1950 :
SELECT * FROM Books
WHERE published_year >1950 ;
--3) list all customers from canada 
SELECT * FROM Customers
WHERE country ='Canada';
--4) Show orders placed in Novemer 2023:
SELECT * FROM Orders 
WHERE order_date BETWEEN '2023-11-21' AND '2023-11-30' ;
--5) Retrieve the total stock of books available:
SELECT SUM(stock) AS Total_Stock 
FROM Books ;
--6) Find the details of the most expensive book :
SELECT * FROM Books ORDER BY price DESC LIMIT 1 ;
--7) Show all customers who ordered more than 1 quantity of a book :
SELECT o.order_id , o.customer_id, c.name , o.book_id , o.order_date ,o.quantity,o.total_amount
FROM customers c 
JOIN Orders o  ON o.customer_id = c.customer_id AND quantity >1 ;
--8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders
WHERE total_amount>20;
--9) List all genre in the book table 
SELECT DISTINCT genre FROM Books;
--10) Find the book with the lowest stock .
SELECT * FROM Books 
ORDER BY stock 
LIMIT 1 ;
--11) Calculate the total revenue generated from all orders :
SELECT SUM(total_amount)AS Revenue 
FROM Orders;
--12) Retrieve the total number of books sold for each genre :
SELECT b.genre , SUM(o.quantity) AS total_books_sold
FROM Orders o 
JOIN Books b on o.book_id = b.book_id
GROUP BY b.genre ;
--13) Find the average price of books in the 'Fantasy'genre :
SELECT genre , AVG(price)AS Average_price 
FROM Books 
WHERE genre ='Fantasy'
GROUP BY genre ;
--14) List Customers who have placed atleast 2 orders :
SELECT customer_id , Count(order_id) AS orders_placed 
FROM Orders 
GROUP BY customer_id 
HAVING Count(order_id)>=2;
--15) Find the most frequently ordered books :
SELECT b.title , o.book_id , COUNT(order_id) AS Count_ordered_books
FROM Books b 
JOIN 
Orders o ON o.book_id = b.book_id 
GROUP BY o.book_id , b.title 
ORDER BY Count_ordered_books DESC 
LIMIT 1 ;
--16) Show the top 3 most expensive books of 'Fantasy 'genre :
SELECT book_id , title , genre , price 
FROM Books 
WHERE genre = 'Fantasy'
ORDER BY price DESC 
LIMIT 3 ;
--17) Retrieve the total quantity of books sold by each author :
SELECT b.title ,b.author, SUM(quantity) AS total_quantity 
FROM Books b 
JOIN 
Orders o ON o.book_id = b.book_id 
GROUP BY b.title , b.author ;
--18) List the cities where customers who spend over $30 are located :
--SELECT * FROM customers;
--SELECT * FROM Orders ;
SELECT  DISTINCT c. city , o. total_amount
FROM customers  c
JOIN Orders o  ON o.customer_id = c.customer_id
WHERE o.total_amount>30;
--19) Find the customer who spend the most on orders:
--SELECT * FROM Orders;
SELECT  o.customer_id,c.name ,  SUM(total_amount) AS Total_spend
FROM customers c
JOIN Orders o ON o.customer_id = c.customer_id
GROUP BY o.customer_id , c.name
ORDER BY Total_spend DESC
LIMIT 1;
--20) calculate the stock remaining after fulfilling the orders:
--SELECT * FROM Books ;
--SELECT * FROM Orders;
SELECT  b.book_id ,b.title,
b.stock - SUM(o.quantity)AS Remainning_Stock
from Books b 
JOIN Orders o on o.book_id = b.book_id
GROUP BY b.book_id , b.title ;
