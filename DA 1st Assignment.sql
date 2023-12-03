-- Q1-- Identify the primary keys and foreign keys in maven movies db. Discuss the differences.
-- Primary Key -- it is a uniques identifier within a table. It generally represent the entire data of that particular row.
-- Foreign Key- Establishes relation between tables by taking reference of primary table
SELECT 
    TABLE_NAME, Column_name, constraint_name
FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    CONSTRAINT_NAME = 'PRIMARY'
        AND TABLE_SCHEMA = 'mavenmovies';

SELECT 
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    CONSTRAINT_NAME != 'PRIMARY'
        AND REFERENCED_TABLE_NAME IS NOT NULL
        AND TABLE_SCHEMA = 'mavenmovies';


-- Q2-- List all details of actors
SELECT 
    *
FROM
    actor;

-- Q3-- List all customer information from DB.
SELECT 
    *
FROM
    customer;

-- 4.List different countries.
use mavenmovies;
SELECT DISTINCT
    country
FROM
    country;

-- 5. Display all active customers.
SELECT 
    CONCAT(first_name, ' ', last_name)
FROM
    customer
WHERE
    active = 1;

-- 6. List of all rental IDs for customer with ID 1.
SELECT 
    customer_id, rental_id
FROM
    rental
WHERE
    customer_id = 1;

-- 7. Display all the films whose rental duration is greater than 5.
SELECT 
    title
FROM
    film
WHERE
    rental_duration > 5;

-- 8. List the total no. of films whose replacement cost is greater than $15 and less than $20.
SELECT 
    COUNT(title)
FROM
    film
WHERE
    replacement_cost BETWEEN '$15' AND '$20';

--  9. Display the count of unique first names of actors.
SELECT 
    COUNT(DISTINCT (first_name))
FROM
    actor;

-- 10. Display the first 10 record from customer table.
SELECT 
    *
FROM
    customer orderby
LIMIT 10;

-- 11. Display the first 3 record from customer table whose first name start with b.
SELECT 
    *
FROM
    customer
WHERE
    first_name LIKE 'b%'
ORDER BY first_name
LIMIT 3;


-- 12. Display the names of the first 5 movies which are rated as ‘G’.
use mavenmovies;
SELECT 
    TITLE
FROM
    film
WHERE
    rating = 'G'
ORDER BY title
LIMIT 5;


-- 13. Find all customers whose first name starts with "a".
use mavenmovies;
select concat(first_name," ",last_name) from customer where first_name like "a%";

-- 14. Find all customers whose first name ends with "a".
select concat(first_name," ",last_name) from customer where first_name like "%a";

-- 15. display the list of first four cities which name start and ends with a.
select city from city where city like "a%a" order by city limit 4;

-- 16. Find all customers whose first name have "NI" in any position.
select concat(first_name," ",last_name)as name from customer where first_name like '%NI%';

-- 17. Find all customers whose first name have "r" in the second position.
select concat(first_name," ",last_name)as name from customer where first_name like '_r%';

-- 18. Find all customers whose first name starts with "a" and at least 5 charactrs in length.
select concat(first_name," ",last_name)as name from customer where first_name like 'a%' and length(first_name)>=5;

-- 19. Find all customers whose first name starts with "a" and ends with 'o'.
select concat(first_name," ",last_name)as name from customer where first_name like 'a%o';

-- 20. Get the films with pg and pg-13 rating using IN operator.
select title from film where rating in ('pg', 'pg-13');

-- 21. Get the films with length between 50 to 100 using between operator.
 select title from film where length between 50 and 100;
 
 -- 22. Get the top 50 actors using limit operator.
SELECT 
    CONCAT(first_name, ' ', last_name) AS name
FROM
    actor
ORDER BY name
LIMIT 50
 
 -- 23. Get the distinct film ids from inventory table.
select distinct
    film_id
FROM
    inventory;



















-- 


















-- 

