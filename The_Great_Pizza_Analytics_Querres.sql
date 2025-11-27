--The Great Pizza Analytics Challenge Mini Project

-- List all unique pizza categories.
select distinct category as pizza_category from pizza_types;

--Display pizza_type_id, name, and ingredients, replacing NULL ingredients with "Missing Data". Show first 5 rows.
select pizza_type_id, name, coalesce(ingredients,'Missing Data') from pizza_types limit 5;

-- Check for pizzas missing a price.
select pizza_id,pizza_type_id,size,price from pizzas where price is null;

--Orders placed on '2015-01-01'.
select order_id,date,time from orders where date='2015-01-01';

-- List pizzas with price descending.
select pizza_id,pizza_type_id,size,price from pizzas order by price desc;

-- Pizzas sold in sizes 'L' or 'XL'.
select pizza_id,pizza_type_id,size,price from pizzas where size in ('L','XL');

-- Pizzas priced between $15.00 and $17.00.
select pizza_id,pizza_type_id,size,price from pizzas where price between 15.00 and 17.00;

-- Pizzas with "Chicken" in the name.
select pizza_type_id,name,ingredients from pizza_types where name like '%Chicken%';

-- Orders on '2015-02-15' or placed after 8 PM.
select order_id,date,time from orders where date='2015-02-15' or time > '20:00:00';

--Total quantity of pizzas sold.
select sum(quantity) from order_details;

-- Average pizza price.
select round(avg(price),2) from pizzas;

--Total order value per order.
select o.order_id,sum(price) as order_value 
from order_details o join pizzas p on o.pizza_id = p.pizza_id 
group by o.order_id order by order_id;

--Total quantity sold per pizza category.
select category, sum(quantity) as qty_sold 
from pizzas p join pizza_types pt on p.pizza_type_id = pt.pizza_type_id join order_details o 
on o.pizza_id = p.pizza_id group by category;

--Categories with more than 5,000 pizzas sold.
select category, sum(quantity) as qty_sold 
from pizzas p join pizza_types pt on p.pizza_type_id = pt.pizza_type_id 
	join order_details o on o.pizza_id = p.pizza_id group by category having sum(quantity) > 5000;

--Pizzas never ordered.
select p.pizza_id, Pizza_type_id,size,price 
from pizzas p left join order_details o on p.pizza_id = o.pizza_id 
where o.pizza_id is null; 

-- Price differences between different sizes of the same pizza.
select p1.pizza_id,p1.pizza_type_id, p1.size AS size1, p1.price AS price1,
p2.size AS size2,p2.price AS price2,round(p2.price - p1.price, 2) AS price_difference 
from pizzas p1 join pizzas p2 on p1. pizza_type_id = p2.pizza_type_id 
and p1.size <> p2.size order by p1.pizza_type_id, size1;
