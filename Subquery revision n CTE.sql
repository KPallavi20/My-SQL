use mavenmovies;
 -- inner join
 
 select count(*) from film;
 select count(*) from film_actor;
 select count(*) from film as f inner join film_actor as fa on f.film_id = fa.film_id inner join actor as a on 
 a.actor_id = fa.actor_id;
 
 -- left join 
 select * from film as f left join film_actor as fa on f.film_id = fa.film_id ;
 
 -- right join
 select count(*) from film as f right join film_actor as fa on f.film_id = fa.film_id;

-- cross join
 select * from film cross join film_actor;
 
 -- full outer join
 -- select count(*) from film as f full outer join film_actor as fa on f.film_id = fa.film_id; 
 select * from film as f left join film_actor as fa on f.film_id = fa.film_id union
select * from film as f right join film_actor as fa on f.film_id = fa.film_id;

-- natural join
select * from film natural join film_category;

-- non - correlated query
select * from payment;
-- give me the customer id who is spending more than average
select avg(amount) from payment;
select distinct customer_id from payment where amount > 4.2;

select distinct customer_id from payment where amount > (select avg(amount) from payment);
 
 
-- retieve the film title , desc, and release year for the film that has the longest duration
select * from film;
select title , description , release_year from film where length = (select max(length) from film);


-- scaler subquery
-- show the title , rental_rate and diff from average renatl rate for each film
select title , rental_rate , rental_rate - (select avg(rental_rate) from film) as average_rental_diff from film;

-- multirow subquery
-- Write a query to generate a list of customer IDs along with the number of film rentals and the total payments.
select c.first_name, c.last_name , tot_rentals , tot_payments from customer c inner join 
( select customer_id , count(customer_id) as tot_rentals , sum(amount) as tot_payments
 from payment group by customer_id) a 
 on c.customer_id = a.customer_id;
 
 ( select customer_id , count(customer_id) as tot_rentals , sum(amount) as tot_payments
 from payment group by customer_id);
 
 
 -- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)
 select * from customer; -- name 
 select * from inventory; -- store_id
 select * from rental; -- customer_id
 
 select * from customer as c  inner join rental as r  on c.customer_id = r.customer_id
 inner join inventory as i on r.inventory_id = i.inventory_id ;

SELECT 
    c.customer_id, c.first_name, c.last_name
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
        INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id
        INNER JOIN
    store s ON i.store_id = s.store_id
WHERE
    s.store_id IN (1 , 2)
GROUP BY c.customer_id , c.first_name , c.last_name
HAVING COUNT(DISTINCT s.store_id) = 2;

 
--  Create a CTE with two named subqueries. The first one gets the actors with last names starting with s.
--  The second one gets all the pg films acted by them. Finally show the film id and title.

-- subquery 1
select * from actor where last_name like "s%" ;-- saving the result in variable - actor_s

-- sub query 2
select a.actor_id , a.first_name , a.last_name , f.title , f.film_id from actor as a inner join film_actor as fa on a.actor_id = fa.actor_id
inner join film as f on f.film_id = fa.film_id where rating = 'pg'; -- actor_pg

with actor_s as (
select * from actor where last_name like "s%"),
actor_pg as (
select a.actor_id , a.first_name , a.last_name , f.title , f.film_id from actor_s as a inner join film_actor as fa on a.actor_id = fa.actor_id
inner join film as f on f.film_id = fa.film_id where rating = 'pg')
select film_id , title from actor_pg;

-- Add one more subquery to the previous CTE to get the revenues of those movies
with actor_s as (
select * from actor where last_name like "s%"), -- task 1 - filter people with last name as 's'
actor_pg as (
select a.actor_id , a.first_name , a.last_name , f.title , f.film_id from actor_s as a inner join film_actor as fa on a.actor_id = fa.actor_id
inner join film as f on f.film_id = fa.film_id where rating = 'pg'), -- task 2 - filter film with rating as 'pg'
film_revenue as (
select ap.film_id , ap.title , p.amount from actor_pg as ap inner join inventory as i on ap.film_id = i.film_id inner join
rental as r on r.inventory_id = i.inventory_id inner join payment as p on p.rental_id = r.rental_id
) -- task 3 - join amount of filter films 
select title , sum(amount) from film_revenue group by title; -- task 4 - total reveniue of each movie

-- Question 1 - Give me the details of films along with its revenue having pg rating and actor with last name as s ?
-- number of tables - actor , film_actor , film, inventory , rental , payment

-- Write a query to generate a value for the activity_type column which returns the string “Active” or “Inactive”
--  depending on the value of the customer.active column
select * from customer;
select first_name , last_name , 
case
when active = 1 then 'active'
else 'inactive' 
end as activity_type
from customer;

-- Write a query to show the number of film rentals for May, June and July of 2005 in a single row.
select monthname(rental_date)as month_name , count(rental_id) from rental group by month_name;

select * from rental;

select sum(case when monthname(rental_date) = 'May' then 1 else 0 end) as may,
sum(case when monthname(rental_date) = 'June' then 1 else 0 end) as june ,
sum(case when monthname(rental_date) = 'July' then 1 else 0 end) as July  from rental;

-- Write a query to categorize films based on the inventory level. 
-- If the count of copies is 0 then ‘Out of stock’
-- If the count of copies is 1 or 2  then ‘Scarce’
-- If the count of copies is 3 or 4 then ‘Available’
-- If the count of copies is >= 5 then ‘Common’

select title ,
case
(select  count(*) from inventory where inventory.film_id = film.film_id )
when 0 then 'out of stock'
when 1 then 'Scares'
when 2 then 'Scares'
when 3 then 'Available'
when 4 then 'Available'
else 'common' end film_availabiliy 
from film;

--  Write a query to create a single row containing the number of films based on the ratings (G, PG and NC17)

SELECT 
    SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS G_count,
    SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS PG_count,
    SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS NC17_count
FROM film;

select distinct rating from film ;

--

select customer_id from customer where customer_id in (select customer_id from rental group by customer_id 
having count(rental_id) > ( select avg(num_rentals) from (select customer_id , count( rental_id) as num_rentals from rental group by 
customer_id ) as rental_counts
));

with rental_count as (
select customer_id , count( rental_id) as num_rentals from rental group by  customer_id),
avg_value as (
select avg(num_rentals) from rental_count),
filter_custemer as
( select * from rental_count where num_rentals > (select * from avg_value))
select * from filter_custemer;


describe film_actor;
select count(*) from film_actor;