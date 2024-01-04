-- Q1. Write a query to display the customer's first name, last name, email, and city they live in.
select * from customer;
select * from address;
select * from city;
select first_name,last_name, email, city from customer c inner join address a on c.address_id=a.address_id inner join city ci on ci.city_id=a.city_id;

-- Q2. Retrieve the film title, description, and release year for the film that has the longest duration.
select * from film;
select max(rental_duration) from film;
select title, description, release_year from film where rental_duration = (select max(rental_duration) from film);

-- Q3. List the customer name, rental date, and film title for each rental made. Include customers who have never rented a film.
select * from customer;
select * from rental;
select * from inventory;
select * from film;
select concat(first_name," ",last_name) as customer_name, rental_date, title, rental_id from customer c inner join rental r on c.customer_id = r.customer_id inner join inventory i on r.inventory_id= i.inventory_id inner join film f on i.film_id=f.film_id group by rental_id having rental_id>=0;

-- Q4. Find the number of actors for each film. Display the film title and the number of actors for each film.
select *from film f;
select * from film_actor fa;
select count(distinct actor_id) from film_actor group by film_id; 
select title from film where film_id in (select count(distinct actor_id) as number_of_actors  from film_actor group by film_id);

-- Q5. Display the first name, last name, and email of customers along with the rental date, film title, and rental return date.
Select * from customer;
SELECT * FROM RENTAL;
select * from inventory;
select * from film;

select first_name, last_name, email, rental_date, title, return_date from customer c inner join rental r on c.customer_id=r.customer_id inner join inventory i on r.inventory_id=i.inventory_id inner join film f on i.film_id=f.film_id;

-- Q6 Retrieve the film titles that are rented by customers whose email domain ends with '.net'.
select email from customer where email like "%.net";
select * from film;
select * from rental;
select * from inventory;
select title, first_name, email from film f inner join inventory i on f.film_id=i.film_id inner join rental on  r.inventory_id=i.inventory_id inner join customer c on r.customer_id = c.customer_id where email in (select email from customer where email like "%.net");

-- Q7. Show the total number of rentals made by each customer, along with their first and last names.
select count(rental_id) from customer c inner join rental r on c.customer_id=r.customer_id group by first_name , last_name;


-- Q8. List the customers who have made more rentals than the average number of rentals made by all customers.
select first_name, last_name from customer where customer_id in (select customer_id from rental group by customer_id having count(rental_id)> (select avg(rental_id) from rental group by customer_id));

-- Q9. Display the customer first name, last name, and email along with the names of other customers living in the same city.
select * from customer;


-- Q10. Retrieve the film titles with a rental rate higher than the average rental rate of films in the same category.
select title, rental_rate from film f where rental_rate>(select avg(rental_rate), category_id from film  where category_id=f.category_id);

-- Q11. Retrieve the film titles along with their descriptions and lengths that have a rental rate greater than the
-- average rental rate of films released in the same year.
select title, description, length from film f where rental_rate>(select avg(rental_rate) from film where release_year=f.release_year);

-- Q12. List the first name, last name, and email of customers who have rented at least one film in the
-- 'Documentary' category.
-- film_category, category, rental, inventory, customer
select first_name, last_name, email from customer where customer_id in (select distinct c.customer_id from customer c join rental r on r.customer_id= c.customer_id join inventory i on r.inventory_id=i.inventory_id join film_category fc on i.film_id=fc.film_id join category ca on fc.category_id= ca.category_id where ca.name = "documentary" );


-- Q13. Show the title, rental rate, and difference from the average rental rate for each film.
SELECT title, rental_rate,
rental_rate - (SELECT AVG(rental_rate) FROM film) AS rate_difference
FROM film;

-- Q14.Retrieve the titles of films that have never been rented.
select * from inventory;
select title from film where film_id not in (select distinct film_id from inventory where film_id is not null);

-- Q15. List the titles of films whose rental rate is higher than the average rental rate of films released in the same
-- year and belong to the 'Sci-Fi' category.

SELECT 
    title
FROM
    film f
WHERE
    rental_rate > (SELECT 
            AVG(rental_rate)
        FROM
            film
        WHERE
            release_year = f.release_year)
        AND film_id IN (SELECT 
            film_id
        FROM
            film_category fc
        WHERE
            category_id IN (SELECT 
                    category_id
                FROM
                    category
                WHERE
                    name = 'Sci-fi'));
                    
-- Q16. Find the number of films rented by each customer, excluding customers who have rented fewer than five films.
-- film, inventory, rental, customer
SELECT customer_id, COUNT(rental_id) AS film_count
FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) >= 5;



