create schema silver;
use silver;


select * from bronze_swiggy.customers
where loyalty_status  = '\r';

SELECT loyalty_status, HEX(loyalty_status)
FROM bronze_swiggy.customers
WHERE customer_id IN ('C0001','C0005');


SET SQL_SAFE_UPDATES = 0;

UPDATE bronze_swiggy.customers
SET loyalty_status = 
CASE
    WHEN TIMESTAMPDIFF(YEAR, signup_date, CURDATE()) < 1 THEN 'Bronze'
    WHEN TIMESTAMPDIFF(YEAR, signup_date, CURDATE()) < 3 THEN 'Silver'
    ELSE 'Gold'
END;


UPDATE bronze_swiggy.customers
SET loyalty_status = 
CASE
    WHEN TIMESTAMPDIFF(YEAR, signup_date, CURDATE()) < 1 THEN 'Bronze'
    WHEN TIMESTAMPDIFF(YEAR, signup_date, CURDATE()) < 3 THEN 'Silver'
    ELSE 'Gold'
END;


delete from bronze_swiggy.customers
where city = '';

SELECT city, HEX(city)
FROM bronze_swiggy.customers
WHERE customer_id IN ('C0075');


select * from bronze_swiggy.orders;

update bronze_swiggy.orders
set payment_method = 'Cash'
where payment_method = '';

delete from bronze_swiggy.restaurant
where 
cuisine_type = '';

delete from bronze_swiggy.restaurant
where city = '';

delete from bronze_swiggy.delivery
where city = '';

select * from bronze_swiggy.customers;
select * from bronze_swiggy.orders;
select * from bronze_swiggy.restaurant;
select * from bronze_swiggy.order_items;
select * from bronze_swiggy.delivery;

create view silver_swiggy_sale as
select c.customer_id,
c.customer_name,
c.city,
c.signup_date,
c.loyalty_status,
o.order_date,
o.total_amount,
o.payment_method,
o.order_status,
r.cuisine_type,
r.avg_rating as restaurant_ratings,
r.delivery_time_mins,
r.is_veg,
ot.item_name,
ot.quantity,
ot.price,
d.partner_id,
d.partner_name,
d.rating as partner_rating,
d.total_deliveries,
d.is_active
from bronze_swiggy.orders o
join bronze_swiggy.customers c on
o.customer_id = c.customer_id
join bronze_swiggy.restaurant r on
o.restaurant_id = r.restaurant_id
join bronze_swiggy.delivery d on
o.partner_id = d.partner_id
join bronze_swiggy.order_items ot on
o.order_id = ot.order_id;

select * from silver_swiggy_sale;

