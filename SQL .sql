/*Name of the customer that made the higest total payments*/
SELECT customer.first_name, customer.last_name,
SUM(payment.amount)AS total_payments
FROM customer
INNER JOIN payment 
ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id, customer.first_name,customer.last_name
HAVING 
SUM(payment.amount)IN
(SELECT MAX(total_payments)
 FROM(SELECT customer_id,SUM(amount)AS total_payments FROM payment 
GROUP BY customer_id) AS highest_total);


--movie that was rented the most--
SELECT m.title AS movie_title, COUNT(r.rental_id) AS rental_id
FROM film AS m
JOIN inventory AS i
ON m.film_id=i.film_id
JOIN rental AS r
ON i.inventory_id=r.inventory_id
GROUP BY m.title
ORDER BY rental_id DESC
LIMIT 1;


--movies that has been rented so far--
SELECT DISTINCT f.title AS rented_movies
FROM film AS f
JOIN inventory AS i 
ON f.film_id=i.film_id
JOIN rental AS r
ON r.inventory_id=i.inventory_id
WHERE r.rental_id IS NOT NULL;


--movies that has not been rented so far—
SELECT DISTINCT f.title AS movie_title
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id=i.film_id
LEFT JOIN rental AS r
ON i.inventory_id=r.inventory_id
WHERE r.rental_id IS NULL;


--which customers have not rented any movies so far—
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r
ON c.customer_id=r.customer_id
WHERE r.rental_id IS NULL;


--each movie and the number of times it got rented--
SELECT DISTINCT f.title AS movie_title, 
COUNT (r.rental_id)AS rental_count
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id=i.film_id
LEFT JOIN rental AS r
ON i.inventory_id=r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;


--first and the last name and the number of films each actor acted in--
SELECT a.first_name,a.last_name,COUNT(*)AS number_of_films
FROM film f
JOIN film_actor fa
ON f.film_id=fa.film_id
JOIN actor a
ON a.actor_id=fa.actor_id
GROUP BY 1,2
ORDER BY 3 DESC;


--The name of actors that acted in more than 20 movies--
SELECT concat(a.first_name, ' ', a.last_name)
AS full_name,
COUNT (DISTINCT(f.film_id))AS movie_count
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id=fa.actor_id
JOIN film AS f
ON fa.film_id=f.film_id
GROUP BY 1
HAVING COUNT (1) >20
ORDER BY 2


--The movies and the number of times it got rented for all the movies rated PG—
SELECT f.title, COUNT (*)times_rented,f.rating
FROM film f 
JOIN inventory i
ON f.film_id=i.film_id
JOIN rental r
ON r.Inventory_id=i.inventory_id
WHERE f.rating= 'PG'
GROUP BY 1,3
ORDER BY 2 desc;


--The customers name that shares the same address--
SELECT c.first_name, last_name, a.address_id, a.address
FROM customer c,address a
WHERE a.address=a.address;


--movies offered in store_id 1 and not offered in store_id 2--
SELECT DISTINCT f.film_id, inv1.store_id
FROM film f
LEFT JOIN inventory inv1
ON f.film_id=inv1.film_id AND inv1.store_id=1
LEFT JOIN inventory inv2
ON f.film_id=inv2.film_id AND inv2.store_id=2
WHERE inv1.inventory_id IS NOT NULL AND inv2.inventory_id IS NULL;


-- movies offered in any of the two stores 1 and 2--
SELECT DISTINCT f.title as movie_title,i.store_id
FROM film f
JOIN inventory i
ON f.film_id=i.film_id
WHERE i.store_id IN (1,2);


-- movies titles of movies offered in both stores at the same time—
SELECT DISTINCT f.title as movie_title
FROM film f
JOIN inventory inv1
ON f.film_id=inv1.film_id
JOIN inventory inv2
ON f.film_id=inv2.film_id
WHERE inv1.store_id=1 AND inv2.store_id=2;


--movie titles for the most rented movie in the store with store_id 1--
SELECT f.title, i.store_id, count(r.rental_id)as most_rented_movie
FROM film AS f
LEFT JOIN inventory AS i
ON f.film_id=i.film_id
LEFT JOIN rental AS r
ON i.inventory_id=r.inventory_id
WHERE store_id = 1
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1;


--Number of movies not offered for rent in the stores yet--
SELECT COUNT (*) AS movie_not_offered_for_rent
FROM film f
LEFT JOIN inventory i
ON f.film_id=i.film_id
LEFT JOIN store s
ON i.store_id=s.store_id
WHERE s.store_id IS NULL OR s.store_id NOT IN (1,2);


--number of rented movies under each rating—
SELECT rating, COUNT(*)AS number_of_movies_rented
FROM film
GROUP BY rating
ORDER BY rating;



--The profit of each of the stores 1 and 2--
SELECT store_id, SUM(p.amount) AS total_profit
FROM payment p
JOIN rental r
ON p.rental_id=r.rental_id
JOIN inventory i
ON i.inventory_id=r.inventory_id
GROUP BY 1
ORDER BY 2; 





