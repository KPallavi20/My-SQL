
-- Write a query to count the number of film rentals for each customer 
-- and the containing query then retrieves those customers who have rented exactly 30 films.

-- customer , rental

select * from customer;
select * from rental;

select first_name , last_name from customer where (select count(*) from rental where rental.customer_id = customer.customer_id) = 30;


-- Write a query to find all customers whose total payments for all film rentals are between 100 and 150 dollars.
-- customer , payment


-- retieve the film title along with their description and lengths that have rental rate greater than avg rental_rate f films
-- released in same year

select title , description ,length from film as f where rental_rate > (
select avg(rental_rate) from film where release_year = f.release_year);

select first_name , last_anme from customer where customer_id in ( select customer_id from rental group by customer_id having count(rental_id)
> (select avg(rental_count) from (select count(rental_id) as rental_count from rental group by customer_id) as avg_rentals));

select customer_id , count(rental_id) as film_count from rental group by customer_id having count(rental_id) >= 5; 

with agr_film_actor as (
 select title , count(fa.actor_id) as count_of_actor from film_actor fa inner join film f on f.film_id = fa.film_id group by f.title
 )
 select title , count_of_actor ,
 case
 when count_of_actor > 5 then "big star cas"  else "small start cast" end as star_cast from agr_film_actor;
 
 
 
with recursive even_no (n) as (
select 10 --  anchor
union all
select n+2 from even_no where n < 20 -- recursive
)
select * from even_no;

with recursive odd_no (n) as (
select 6 --  anchor
union all
select 2*n+1 from odd_no where n < 25 -- recursive
)
select * from odd_no;
 
 
 CREATE TABLE emp (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES emp(emp_id)
);

INSERT INTO emp (emp_id, emp_name, manager_id) VALUES
    (1, 'John Doe', NULL), -- Top-level employee
    (2, 'Alice Smith', 1), -- Employee managed by John Doe
    (3, 'Bob Johnson', 1), -- Employee managed by John Doe
    (4, 'Charlie Brown', 2), -- Employee managed by Alice Smith
    (5, 'Diana Williams', 2), -- Employee managed by Alice Smith
    (6, 'Eva Garcia', 3), -- Employee managed by Bob Johnson
    (7, 'Franklin Wang', 3); -- Employee managed by Bob Johnson

with recursive emp_hirarchy as (
select emp_id , emp_name , manager_id , 0 as level from emp where manager_id is null
union all 
select e.emp_id , e.emp_name , e.manager_id , eh.level+1 from emp as e join emp_hirarchy as eh on e.manager_id = eh.emp_id)
select emp_id , emp_name , manager_id , level from emp_hirarchy;


-- calculate the average rental duration for films and display both the individual average duration
-- for each film and the overall average duration.
select * from film;
select film_id , rating, title , rental_duration , avg(rental_duration) over() ,
avg(rental_duration) over (partition by rating)
from film;

-- assign the ranks based on ratings alog with rental_durations
select rating, rental_duration ,
rank() over (partition by rating order by rental_duration) as rankings
from film;



-- Retrieve the top 5 films with the highest rental rates, displaying the film title, rental rate, and the average rental
-- rate for all films. Use window functions to rank the films based on their rental rates.

select title, rental_rate,
avg(rental_rate) over(),
rank() over(order by rental_rate asc)
from film 
order by rental_rate desc
limit 5;

-- Find the total number of rentals for each customer, along with their  -- 3:27 - 3:32
-- individual rental counts and the average number of rentals across all customers. -- rental == customer_id , count(rental) , avg(count())
-- add new column with individual having higher value than avg is marked higher or else lower
-- give me the list of people who rented movies higher than average -- 3:36 - 3:40
select customer_id , count(rental_id) as total_count, avg(count(rental_id)) over() as avg_count,
 case when count(rental_id) - avg(count(rental_id)) over() > 0 then "higher" else "lower"  end count_stats
from rental group by customer_id order by count_stats;

-- Find the films that have been rented the least number of times. Display the film 
-- title, rental count, and the average rental count across all films.
-- from - join - where - group by - having - select - order by - limit
select title , count(rental_id) as no_of_rental, avg(count(rental_id)) over() from
film f left join inventory i on f.film_id = i.film_id
left join rental r on r.inventory_id = i.inventory_id group by title order by no_of_rental;

-- Display the title and rental duration of films from the database, 
-- alongside the title and rental duration of the subsequent film (using LEAD function) 

select title , rental_duration , lag(title, 7) over(order by rental_duration),
lag(rental_duration, 2) over(order by rental_duration)  from film;

-- lag -- when you want to compare performance on weekly bases 


-- function - string , numeric , date function , aggregate , window functions

select concat(first_name , " " , last_name) from actor;


-- user defined functions
-- create a function to get a squared value


 
-- SET GLOBAL log_bin_trust_function_creators = 1;
-- delimiter //

-- create function squared (num int)
-- returns int
-- begin
-- declare result int;
-- set result = num*num;
-- return result;
-- end //

-- delimiter ;

select squared(5);