use mavenmovies;
-- answer no1 
SELECT COUNT(*) AS total_rentals
FROM rental;
-- answer no2
SELECT AVG(DATEDIFF(return_date, rental_date)) AS avg_rental_duration
FROM rental;
-- answer no3
SELECT UPPER(first_name) AS upper_first_name, UPPER(last_name) AS upper_last_name
FROM customer;
-- answer no4
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;
-- answer no5
SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id;
-- answer no6
SELECT 
   s.store_id, SUM(p.amount) AS total_revenue
FROM
    store s
        JOIN
    staff st ON s.store_id = st. store_id
        JOIN
    payment p ON st.staff_id =p.staff_id
GROUP BY s.store_id;
-- answer no7
SELECT 
    f.title AS movie_title, c.first_name, c.last_name
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    customer c ON r.customer_id = c.customer_id;
    -- answer no 8
    SELECT 
    a.first_name, a.last_name
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film f ON fa.film_id = f.film_id
WHERE
    f.title = 'gone with the wind';
-- Determine the total number of rentals for each category of movies.


select * from film;

select * from film_category ;
select *from rental ;

SELECT c.category_id, c.name AS category_name, COUNT(*) AS rental_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, category_name
ORDER BY rental_count DESC;

-- answer 2

SELECT l.language_id, l.name AS language_name, AVG(f.rental_rate) AS avg_rental_rate
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id, language_name
ORDER BY avg_rental_rate DESC;

-- answer no 3

SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       SUM(p.amount) AS total_spent_on_rentals
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent_on_rentals DESC;
 -- answer no 4
 
 SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       f.title AS movie_title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city = 'London'
ORDER BY c.customer_id, movie_title;

-- answer no 5
SELECT f.film_id,
       f.title AS movie_title,
       COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, movie_title
ORDER BY rental_count DESC
LIMIT 5;

-- answer no 6 

SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
WHERE s.store_id IN (1, 2)
GROUP BY c.customer_id, customer_name
HAVING COUNT(DISTINCT s.store_id) = 2;




