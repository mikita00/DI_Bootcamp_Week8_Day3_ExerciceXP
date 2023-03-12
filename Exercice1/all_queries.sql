-- 1. Get a list of all film languages.
SELECT * FROM language;

-- 2. Get a list of all films joined with their languages – select the following details : film title, description, and language name. Try your query with different joins:

--   1. Get all films, even if they don’t have languages.
SELECT f.title, f.description, l.name
FROM film AS f
LEFT JOIN language AS l
ON f.language_id = l.language_id;


--   2. Get all languages, even if there are no films in those languages.
SELECT f.title, f.description, l.name
FROM film AS f
RIGHT JOIN language AS l
ON f.language_id = l.language_id;


-- 3. Create a new table called new_film with the following columns : id, name. Add some new films to the table.
CREATE TABLE new_film(id SERIAL NOT NULL PRIMARY KEY, name VARCHAR(100) NOT NULL );

INSERT INTO new_film(name)
VALUES 
('Suits'),
('Scorpion'),
('Disignated' ),
('Power');

-- 4. Create a new table called customer_review, which will contain film reviews that customers will make.
--    Think about the DELETE constraint: if a film is deleted, its review should be automatically deleted.
--     It should have the following columns:
--     review_id – a primary key, non null, auto-increment.
--     film_id – references the new_film table. The film that is being reviewed.
--     language_id – references the language table. What language the review is in.
--     title – the title of the review.
--     score – the rating of the review (1-10).
--     review_text – the text of the review. No limit on the length.
--     last_update – when the review was last updated

CREATE TABLE customer_review(
	review_id SERIAL,
	film_id INTEGER,
	language_id INTEGER,
	title VARCHAR(100) NOT NULL,
	score INTEGER NOT NULL CHECK (score >= 1 AND score <= 10),
	review_text TEXT NOT NULL,
	last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(review_id),
	CONSTRAINT fk_new_film FOREIGN KEY(film_id) REFERENCES new_film(id) ON DELETE CASCADE,
	CONSTRAINT fk_language FOREIGN KEY (language_id) REFERENCES language(language_id)
	
);

-- 5. Add 2 movie reviews. Make sure you link them to valid objects in the other tables.

INSERT INTO customer_review( film_id, language_id, title, score, review_text)
VALUES
(2, 1, 'Scorpion', 9, 'Scorpion is a intellectual film which main actors are gifted'),
(4, 5, 'Power', 10, 'Power is an america-black film in which it is about selling drug');


-- 6. Delete a film that has a review from the new_film table, what happens to the customer_review table?
DELETE FROM new_film WHERE id = 2;
SELECT * FROM new_film;
SELECT * FROM customer_review;