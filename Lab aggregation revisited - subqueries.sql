use sakila;
-- 1. Select the first name, last name, and email address of all the customers who have rented a movie.
select concat(first_name, ' ',last_name) as customer_name, email from customer where customer_id in (select customer_id from customer join rental using (customer_id)); 
-- 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select concat(first_name, ' ',last_name) as customer_name, c.customer_id, avg(amount) from customer c join payment p using (customer_id) group by customer_id;
-- 3.1 Select the name and email address of all the customers who have rented the "Action" movies - Write the query using multiple join statements
select concat(first_name, ' ',last_name) as customer_name, email from customer c join rental r using (customer_id)
join inventory i using (inventory_id)
join film_category fc using (film_id)
join category cat using (category_id)
where cat.name = 'Action' group by customer_id;
-- 3.2 Write the query using sub queries with multiple WHERE clause and IN condition
select concat(first_name, ' ',last_name) as customer_name, email from customer where customer_id in (select rental_id from rental where rental_id in
(select inventory_id from inventory where inventory_id in
(select film_id from film_category where category_id in
(select category_id from category where name = "Action")))) group by customer_id;
--  the above two queries produce the same results
-- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment.
select concat(first_name, ' ',last_name) as customer_name, amount,
case 
when 0 < amount and amount < 2 then 'low'
when 2 < amount and amount < 4 then 'medium'
when amount > 4 then 'hight'
end as transaction_level
from customer join payment using (customer_id) group by customer_id;


