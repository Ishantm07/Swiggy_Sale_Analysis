create schema gold_swiggy;
use gold_swiggy;

select * from silver_swiggy.silver_swiggy_sale;


DELIMITER $$

CREATE PROCEDURE sp_get_swiggy_kpis(IN order_date INT)
BEGIN

-- Customers


select count(distinct customer_id) as total_cust from 
silver_swiggy.silver_swiggy_sale;

select round(sum(total_amount),2) as total_revenue from
silver_swiggy.silver_swiggy_sale;

select sum(quantity) as total_cust,
round(sum(total_amount),2) as total_revenue,
round(sum(total_amount)/sum(quantity),1) as avg_selling
from silver_swiggy.silver_swiggy_sale;


select loyalty_status ,sum(quantity) as total_count from silver_swiggy.silver_swiggy_sale
group by loyalty_status;


select customer_id,customer_name, sum(quantity) as total_order from silver_swiggy.silver_swiggy_sale
group by customer_id, customer_name
having sum(quantity) > (select
avg(quantity) as avg_orders from silver_swiggy.silver_swiggy_sale)
order by sum(quantity) desc;


select count(*) from silver_swiggy.silver_swiggy_sale
having sum(quantity) > (select
avg(quantity) as avg_orders from silver_swiggy.silver_swiggy_sale)
order by sum(quantity) desc;



SELECT 
    customer_id,
    customer_name,
    quantity,
    CASE 
        WHEN DATE(order_date) = first_order_date THEN 'New'
        ELSE 'Returning'
    END AS order_category
FROM (
    SELECT 
        customer_id,
        customer_name,
        quantity,
        order_date,
        MIN(DATE(order_date)) OVER (PARTITION BY customer_id) AS first_order_date
    FROM silver_swiggy.silver_swiggy_sale
) AS t;

with returning as (
select 
customer_id,customer_name,
sum(quantity) as total_rev,
min(order_date) as first_date
from silver_swiggy.silver_swiggy_sale
group by customer_id,customer_name),
category as (
select
s.customer_id,s.customer_name,s.quantity,f.total_rev,
case when
s.order_date = f.first_date then 'New'
when 
s.order_date > f.first_date then 'Returning'
 end as order_category
 from silver_swiggy.silver_swiggy_sale s 
 join returning f on
 s.customer_id = f.customer_id)
 select customer_id,customer_name,order_category,sum(quantity) as total_reve,
 sum(quantity)/max(total_rev) as rev_perct
 from category 
 group by customer_id,customer_name,order_category;
 

select city,sum(quantity) as total_order
from silver_swiggy.silver_swiggy_sale
group by city
order by sum(quantity) desc;


-- Restaurant KPIS
select *
from silver_swiggy.silver_swiggy_sale;


select avg(restaurant_ratings) as avg_rest
from silver_swiggy.silver_swiggy_sale;

select cuisine_type, sum(quantity) as total_orders
from silver_swiggy.silver_swiggy_sale
group by cuisine_type
order by sum(quantity) desc;


-- order and sales kpi

select sum(quantity) as total_cust,
round(sum(total_amount),2) as total_revenue,
round(sum(total_amount)/sum(quantity),1) as avg_selling
from silver_swiggy.silver_swiggy_sale;

select *
from silver_swiggy.silver_swiggy_sale;


with total_orders as 
(select customer_id,
sum(quantity) as total_order
from silver_swiggy.silver_swiggy_sale
group by customer_id)

select s.customer_id, s.payment_method,
count(s.payment_method) as total_ord, 
count(s.payment_method) / max(total_order) as perct_pmt_mthd
from silver_swiggy.silver_swiggy_sale s
join total_orders t on
s.customer_id  = t.customer_id
group by s.customer_id, s.payment_method; 


-- Deliver_kpi


select * from silver_swiggy.silver_swiggy_sale;

select partner_id,partner_name,
round(avg(partner_rating),2) as partner_rtg
from silver_swiggy.silver_swiggy_sale
group by partner_id,partner_name
order by avg(partner_rating) desc;

select partner_id,partner_name,
sum(total_deliveries) as partner_deliveries
from silver_swiggy.silver_swiggy_sale
group by partner_id,partner_name
order by sum(total_deliveries) desc;

end$$
DELIMITER ;

call sp_get_swiggy_kpis(30);


