create database swiggy;

create schema bronze_swiggy;

use  bronze_swiggy;


create table customers(
customer_id int,
customer_name nvarchar(50),	
phone_no nvarchar(50),
city nvarchar(50),
signup_date date,
loyalty_status nvarchar(50)
);

create table orders(
order_id int,
customer_id	int,
restaurant_id int,
partner_id int,
order_date date,
total_amount float,
payment_method	nvarchar(50),
order_status nvarchar(50)
);

create table restaurant(
restaurant_id int,
restaurant_name nvarchar(50),	
city nvarchar(50),	
cuisine_type nvarchar(50),	
avg_rating float,
delivery_time_mins date,
is_veg nvarchar(50))
;

create table order_items(
order_item_id int,
order_id int,	
item_name nvarchar(50),
quantity int,
price float);


create table delivery(
partner_id	nvarchar(50),
partner_name nvarchar(50),
city nvarchar(50),
rating float,	
total_deliveries int,	
is_active nvarchar(50));
 drop table bronze_swiggy.delivery;
alter table bronze_swiggy.customers
modify customer_id nvarchar(50);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Swiggy\\swiggy_customers.csv'
INTO TABLE bronze_swiggy.customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id ,
customer_name ,	
phone_no ,
city ,
signup_date ,
loyalty_status 
);
SHOW VARIABLES LIKE 'secure_file_priv';

select * from bronze_swiggy.customers;
alter table bronze_swiggy.orders
modify order_id nvarchar(50),
modify customer_id nvarchar(50),
modify restaurant_id nvarchar(50),
modify partner_id nvarchar(50);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Swiggy\\swiggy_orders.csv'
INTO TABLE bronze_swiggy.orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,	
customer_id,
restaurant_id,	
partner_id,	
order_date ,	
total_amount,	
payment_method,	
order_status
);

alter table bronze_swiggy.restaurant
modify restaurant_id nvarchar(50);
alter table bronze_swiggy.restaurant
modify delivery_time_mins int;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Swiggy\\swiggy_restaurants.csv'
INTO TABLE bronze_swiggy.restaurant
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(restaurant_id,	
restaurant_name,	
city,	
cuisine_type,	
avg_rating,	
delivery_time_mins,	
is_veg
);


select * from bronze_swiggy.restaurant;

alter table bronze_swiggy.order_items
modify order_item_id nvarchar(50),
modify order_id nvarchar(50);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Swiggy\\swiggy_order_items.csv'
INTO TABLE bronze_swiggy.order_items
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_item_id,	
order_id,	
item_name,	
quantity,	
price
);

select * from bronze_swiggy.order_items;

alter table bronze_swiggy.delivery
modify partner_id nvarchar(50);


load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Swiggy\\swiggy_delivery_partners.csv'
INTO TABLE bronze_swiggy.delivery
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(partner_id,	
partner_name,	
city,	
rating,	
total_deliveries,	
is_active
);





