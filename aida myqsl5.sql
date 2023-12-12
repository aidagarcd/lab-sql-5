-- Drop column picture from staff.
-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
-- select customer_id from sakila.customer. where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.
-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. 
-- Follow these steps:
    -- Check if there are any non-active users
    -- Create a table backup table as suggested
    -- Insert the non active users in the table backup table
    -- Delete the non active users from the table customer

use sakila;

alter table staff drop column picture;
SHOW COLUMNS FROM staff;

select * from customer;
select * from customer where first_name = 'TAMMY'; -- 75
select * from staff;
update staff_id set name = 'TAMMY' where customer_id = 75;
insert into staff values (3, 'Tammy', 'Sanders', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'Tammy', null , now());

select * from rental;
set @film_title = 'Academy Dinosaur';
set @customer_first_name = 'Charlotte';
set @customer_last_name = 'Hunter';
set @staff_first_name = 'Mike';
set @staff_last_name = 'Hillyer';
SET @film_id = (SELECT film_id FROM film WHERE title = @film_title);
SET @customer_id = (SELECT customer_id FROM customer WHERE first_name = @customer_first_name AND last_name = @customer_last_name);
SET @staff_id = (SELECT staff_id FROM staff WHERE first_name = @staff_first_name AND last_name = @staff_last_name);
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id, last_update, day_type)
SELECT 
    NOW(),
    (SELECT inventory_id FROM inventory WHERE film_id = @film_id LIMIT 1),
    @customer_id,
    NULL,
    @staff_id,
    NOW(),
    'unknown'
WHERE @film_id IS NOT NULL AND @customer_id IS NOT NULL AND @staff_id IS NOT NULL;


SELECT * FROM customer WHERE active = 0;
CREATE TABLE IF NOT EXISTS backup_table AS SELECT * FROM customer WHERE active = 0;
INSERT INTO backup_table SELECT * FROM customer WHERE active = 0;
UPDATE customer SET active = 1 WHERE active = 0 AND customer_id > 0;


