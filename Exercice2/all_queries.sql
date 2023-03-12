-- 1. Use UPDATE to change the language of some films. Make sure that you use valid languages.
UPDATE language
SET name ='Arabic'
WHERE language_id = 5;


-- 2. Which foreign keys (references) are defined for the customer table? 
--    How does this affect the way in which we INSERT into the customer table?
SELECT * FROM customer;
--** The foreign key defined for the customer table is "store_id" from store table
--** first of all it can not be defined as an auto-increment type in creating customer table 
--** After that, for inserting that data into the customer table we must be sure that it exists in store table and refer to it.



-- 3. We created a new table called customer_review. Drop this table. Is this an easy step, or does it need extra checking?
DROP TABLE customer_review;
--** It's an easy step because it does not depend on any table or checking;



-- 4. Find out how many rentals are still outstanding (ie. have not been returned to the store yet).
SELECT count(*) autstanding_number
FROM rental
WHERE return_date IS NULL;


--Find the 30 most expensive movies which are outstanding (ie. have not been returned to the store yet)
SELECT f.film_id, f.title, f.rental_rate, 
r.rental_date, r.return_date
FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON f.film_id = i.film_id
WHERE r.return_date IS NULL
ORDER BY f.rental_rate DESC
LIMIT 30;



-- 6. Your friend is at the store, and decides to rent a movie.
--    He knows he wants to see 4 movies, but he can’t remember their names. 
--    Can you help him find which movies he wants to rent?

--    1.    The 1st film : The film is about a sumo wrestler, and one of the actors is Penelope Monroe.
SELECT f.title, f.description,
a.first_name, a.last_name
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
JOIN actor a
ON fa.actor_id = a.actor_id
WHERE f.description LIKE '%sumo%'
OR
( a.first_name = 'Penelope'  AND  a.last_name = 'Monroe');



--   2. The 2nd film : A short documentary (less than 1 hour long), rated “R”.

SELECT f.title, c.name, f.length, f.rating
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id

WHERE f.length < 60 AND  c.name ='Documentary' AND f.rating = 'R' ;


--   3. The 3rd film : A film that his friend Matthew Mahan rented. He paid over $4.00 for the rental, and he returned it between the 28th of July and the 1st of August, 2005.

SELECT f.title, f.rental_rate, r.return_date, c.first_name, c.last_name
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON f.film_id = i.film_id
WHERE rental_rate > 4.00
AND 
(c.first_name='Matthew' AND c.last_name ='Mahan')
AND
r.return_date BETWEEN '2005-07-28' AND '2005-08-01';


-- The 4th film : His friend Matthew Mahan watched this film, as well. 
--It had the word “boat” in the title or description, and it looked like it was a very expensive DVD to replace.

SELECT f.title, f.description, f.replacement_cost, c.first_name, c.last_name
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN customer c
ON r.customer_id = c.customer_id
WHERE ((f.title LIKE '%boat%') OR (f.description LIKE '%boat%'))
OR
(c.first_name ='Matthew' AND c.last_name = 'Mahan')
ORDER BY replacement_cost
LIMIT 1
;
