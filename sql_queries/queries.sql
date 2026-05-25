create table Books (
      Book_ID	Serial  Primary Key,
      Title	Varchar (100),
      Author Varchar (100),
      Genre	Varchar (100),
      Published_Year Int,
      Price	Numeric (10,2),
      Stock	int
)

copy Books
       (
     Book_ID,
     Title,
     Author,
     Genre,
     Published_Year,
     Price,
     Stock
)

from 'D:\Projects\SQL\Book_Store\Data\Books.csv'
Delimiter ','
csv header ;
select * from books;

Create table Customers(
       Customer_ID	Serial  Primary key,
       Name	Varchar (100),
       Email	Varchar (100),
       Phone	Varchar (15),
       City	Varchar (50),
       Country	Varchar (50)
	)
Alter table Customers
Alter column country type varchar (100)


copy Customers (
     Customer_ID,
     Name,
     Email,
     Phone,
     City,
     Country
	)
from 'D:\Projects\SQL\Book_Store\Data\Customers.CSV' 
delimiter ','
CSV Header;

select * from Customers;

create table Orders ( 
      Order_ID	Serial Primary Key,
      Customer_ID	INT  references Customers (customer_id),
      Book_ID	INT references Books (Book_id),
      Order_Date Date,
      Quantity	Int,
      Total_Amount	Numeric (10,2)
)

copy Orders(
     Order_ID,
     Customer_ID,
     Book_ID,
     Order_Date,
     Quantity,
    Total_Amount
)

from 'D:\Projects\SQL\Book_Store\Data\Orders.csv'
delimiter ','
CSV Header; 

select * from Orders;

---Basic Queries- 11
-- 1) Retrieve all books in the 'Fiction' genre
select * from Books;

select * from Books
      where Genre ='Fiction';

select  genre, count (Genre) as total_Fiction_Genre
from Books
where genre ='Fiction'
group by genre;

-- 2) Find books published after the year 1950

select * from Books
      where Published_year>=1950;

-- 3) List all customers from the Canada:
select * from customers
        where country ='Canada' ;
		
-- 4) Show orders placed in November 2023:
select * from orders;

select * from orders
  where order_date between '2023-11-01' and '2023-11-30'
  order by order_date asc;
  
-- 5) Retrieve the total stock of books available:

select * From books;

select sum (stock) as Total_Stock 
     from books;
-- 6) Find the details of the most expensive book:

select book_id, title, price
  from books
   order by price desc
   limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from customers;
select * from orders;

select c.name,c.city, o. quantity
          from customers c
          join orders o
              on c.customer_id = o.customer_id
              where o.quantity > 1
              order by quantity desc ;


-- 8) Retrieve all orders where the total amount exceeds $20:

select customer_id, book_id, total_amount
        from orders 
		  where total_amount > 28
		  order by total_amount desc;
-- 9) List all genres available in the Books table:

select distinct genre, count (*) as total_genre
         from books
		 group by genre
		 order by genre desc;

-- 10) Find the book with the lowest stock:

select * from Books
      where stock>=1
      order by stock asc
	  limit 1;
	  
-- 11) Calculate the total revenue generated from all orders:
select * from orders;

select sum(total_amount) as Total_revenue
         from orders;

-- Advance Questions 9
-- 1) Retrieve the total number of books sold for each genre:

select * from orders;
select * from books;

select b.genre, sum(o.quantity) as total_book_sold 
      from books b
      join orders o
      on b.book_id = o.book_id
      group by b.genre
	  order by total_book_sold desc;

-- 2) Find the average price of books in the "Fantasy" genre:
select * from books;

select  avg(price) 
   from books
	    where genre='Fantasy';


-- 3) List customers who have placed at least 2 orders:

select customer_id, count(order_id) as No_of_orders
     from orders
	 group by customer_id
	 having count(order_id)>=2;


-- 4) Find the most frequently ordered book:

select * from orders;
select* from books;

select b.book_id, b.title,
    count(o.order_id) as Total_no_booksorder
    from books b 
 join
    orders o 
	on b.book_id = o.book_id
   group by (b.title,b.book_id)
order by Total_no_booksorder desc;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
 select title, price
       from books
where genre ='Fantasy'
order by price desc
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:

select b.author, sum(o.quantity)as Total_Quantity
from books b
join 
orders o
on
b.book_id = o.book_id
group by b.author
order by Total_Quantity desc;

-- 7) List the cities where customers who spent over $30 are located:

select c.name, c.city, o.total_amount 
from customers c
join 
orders o
on
c.customer_id= o.customer_id
where total_amount > 30
order by total_amount asc;

-- 8) Find the customer who spent the most on orders:

select * from 

