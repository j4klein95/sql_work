USE sakila;
-- 1a
SELECT * from actor;
-- 2b
select concat(first_name, ' ', last_name) from actor as Actor_Name;
-- 2a
select actor_id, first_name, last_name from actor
where first_name = "Joe";
-- 2b
select * from actor
where last_name like '%gen%';
-- 2c
select * from actor
where last_name like '%li%' order by last_name, first_name;
-- 2d
select country_id, country
from country where country in(
'Afghanistan',
'Bangladesh',
'China');
-- 3a
alter table actor
add middle_name varchar(30);

select * from actor
order by actor_id, first_name, middle_name, last_name, last_update;

-- 3b
alter table actor
MODIFY COLUMN last_name blob;

-- 3c
alter table actor
drop column middle_name;
 -- 4a
 select last_name from actor;
 select count(last_name)
 from actor;
 -- 4b
SELECT COUNT(Distinct last_name)
from actor;
-- 4c
UPDATE actor
set first_name = 'HARPO'
where first_name = 'GROUCHO';
-- 4d
UPDATE actor
set first_name = 'GROUCHO'
where first_name = 'HARPO';
-- 5a
SHOW CREATE TABLE address;
-- 6a join on addres id
SELECT staff.first_name, staff.last_name, address.address
from staff
JOIN address ON staff.address_id=address.address_id;
-- 6b come back too later
SELECT SUM(amount)
FROM payment
where payment_date BETWEEN '2005-08-01' AND '2005-08-31' AND staff_id IN
(
	SELECT staff_id
    FROM staff
    WHERE staff_id = 2
    );

SELECT SUM(amount)
FROM payment
where payment_date BETWEEN '2005-08-01' AND '2005-08-31' AND staff_id IN
(
	SELECT staff_id
    FROM staff
    WHERE staff_id = 1
    );
-- 6c
select film_id, title, count(actor_id) as 'num of actors'
from film_actor
inner join film using(film_id)
group by title;
-- 6d
SELECT COUNT(film_id)
from film
join inventory using(film_id)
where film.title = 'Hunchback Impossible';
-- 6e
SELECT customer_id, last_name, sum(amount) as 'purchase total'
from customer
join payment using(customer_id)
group by last_name;
-- 7a
SELECT film_id, title
from film
where language_id in
(
	Select language_id
    from language
    where name='English' AND title like 'K%' OR title like 'Q%'
    );
-- 7b
SELECT film_id, title, description, actor_id
from film
join film_actor using(film_id)
where title='Alone Trip';
-- 7c
SELECT email
from customer
where address_id in
(
	SELECT address_id
    from address
    where city_id in
    (
		Select city_id
        from city
        where country_id in
        (
			Select country_id
            from country
            where country='Canada'
		)
	)
);
-- 7d
SELECT film_id, title
from film
where film_id in
	(
		SELECT film_id
        from film_category
        where category_id in
        (
			SELECT category_id
            from category
            where name='Family'
		)
     );
-- 7e
select title, rating, count(film_id) as 'number_of_copies'
from film
join inventory using(film_id)
join rental using(inventory_id)
group by title
order by number_of_copies desc;
-- 7f
SELECT store_id, SUM(amount)
from payment
join staff using(staff_id)
join store using(store_id)
group by store_id;
-- 7g
SELECT store_id, city, country
from store
join address using(address_id)
join city using(city_id)
join country using(country_id)
group by store_id;
-- 7h
SELECT name, SUM(amount)
from payment
join rental using(rental_id)
join inventory using(inventory_id)
join film using(film_id)
join film_category using(film_id)
join category using(category_id)
group by name
order by SUM(amount) desc;
-- 8a
CREATE VIEW `Top Grossing Genre` AS
SELECT name, SUM(amount)
from payment
join rental using(rental_id)
join inventory using(inventory_id)
join film using(film_id)
join film_category using(film_id)
join category using(category_id)
group by name
order by SUM(amount) desc;
-- 8b
SELECT * FROM `top grossing genre`;
-- 8c
DROP VIEW `top grossing genre`;
