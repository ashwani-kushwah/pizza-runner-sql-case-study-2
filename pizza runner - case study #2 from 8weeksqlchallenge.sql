CREATE DATABASE pizza_runner;

use pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);

INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" datetime
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);

INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);

INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);

INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');

-----     Questions    ---------


-- data cleaning 
-- customer_orders table
select order_id, customer_id, pizza_id,
case when exclusions = '' or exclusions like '%null%' then null
	else exclusions
	end,
case when extras = '' or extras like '%null%' then null
	else extras
	end,
order_time
from customer_orders

update customer_orders
set exclusions = case when exclusions = '' or exclusions like '%null%' then null
	else exclusions
	end

update customer_orders
set extras = case when extras = '' or extras like '%null%' then null
	else extras
	end


-- runner_orders table
select pickup_time, 
case when pickup_time = '' or pickup_time like '%null%' then null
	else pickup_time
	end,
case when distance='' or distance='%null%' then null
	when distance like '%km' then REPLACE(REPLACE(distance, 'km', ''), 'km', '')
	else distance
	end,
case when duration='' or duration='%null%' then null
	when duration like'%mins' then REPLACE(REPLACE(duration, 'mins', ''), 'mins', '')
	when duration like'%minute' then REPLACE(REPLACE(duration, 'minute', ''), 'minute', '')
	when duration like'%minutes' then REPLACE(REPLACE(duration, 'minutes', ''), 'minutes', '')
	else duration
	end,
case when cancellation like '' or cancellation like '%null%' or cancellation like '%NaN%'then null
	else cancellation
	end
from runner_orders

update runner_orders
set pickup_time = case when pickup_time = '' or pickup_time like '%null%' then null
	else pickup_time
	end
update runner_orders
set distance = case when distance='' or distance like'%null%' then null
	when distance like '%km' then REPLACE(REPLACE(distance, 'km', ''), 'km', '')
	else distance
	end
update runner_orders
set duration = case when duration='' or duration like '%null%' then null
	when duration like'%mins' then REPLACE(REPLACE(duration, 'mins', ''), 'mins', '')
	when duration like'%minute' then REPLACE(REPLACE(duration, 'minute', ''), 'minute', '')
	when duration like'%minutes' then REPLACE(REPLACE(duration, 'minutes', ''), 'minutes', '')
	else duration
	end
update runner_orders
set cancellation = case when cancellation like '' or cancellation like '%null%' or cancellation like '%NaN%'then null
	else cancellation
	end

--- changing the data types for runner_orders table
ALTER TABLE runner_orders
ALTER COLUMN pickup_time DATETIME
ALTER TABLE runner_orders
ALTER COLUMN distance FLOAT(53)
ALTER TABLE runner_orders
ALTER COLUMN duration INT



--A. Pizza Metrics
--1. How many pizzas were ordered?
--2. How many unique customer orders were made?
--3. How many successful orders were delivered by each runner?
--4. How many of each type of pizza was delivered?
--5. How many Vegetarian and Meatlovers were ordered by each customer?
--6. What was the maximum number of pizzas delivered in a single order?
--7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
--8. How many pizzas were delivered that had both exclusions and extras?
--9. What was the total volume of pizzas ordered for each hour of the day?
--10. What was the volume of orders for each day of the week?


-- 1. How many pizzas were ordered?
select count(order_id) as Total_Orders
from customer_orders

-- 2. How many unique customer orders were made?
select count(distinct(order_id)) as Total_Unique_Orders
from customer_orders

-- 3. How many successful orders were delivered by each runner?
select runner_id, count(order_id) as Total_Successful_Orders
from runner_orders
where cancellation is null
group by runner_id
order by runner_id

-- 4. How many of each type of pizza was delivered?
select co.pizza_id, count(co.order_id) as Count_orders
from customer_orders co, runner_orders ro
where co.order_id = ro.order_id
and cancellation is null
group by pizza_id
order by pizza_id

-- 5. How many Vegetarian and Meatlovers were ordered by each customer?
select customer_id,
	sum(case when pizza_id = 1 then 1 else 0 end) as Meatlovers_count,
	sum(case when pizza_id = 2 then 1 else 0 end) as Vegetarian
from customer_orders
group by customer_id
order by customer_id

-- 6. What was the maximum number of pizzas delivered in a single order?
with cte as(
select order_id, count(pizza_id) as Order_count
from customer_orders
group by order_id)

select max(order_count) Max_Orders
from cte

--7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
select * from customer_orders

select co.customer_id,
count( case when exclusions is not null then 1
	when extras is not null then 1 end) Changed_order,
count( case when exclusions is null then 1
	when extras is null then 1 end) Not_Changed_order
from customer_orders co, runner_orders ro
where co.order_id = ro.order_id
and cancellation is null
group by customer_id

--8. How many pizzas were delivered that had both exclusions and extras?
select co.customer_id,
count( case when exclusions is not null and extras is not null then 1 end) Both_Changed_order
from customer_orders co, runner_orders ro
where co.order_id = ro.order_id
and cancellation is null
group by customer_id

--9. What was the total volume of pizzas ordered for each hour of the day?
select datepart(HOUR, order_time), count(order_id)
from customer_orders
group by datepart(HOUR, order_time)
order by datepart(HOUR, order_time)

--10. What was the volume of orders for each day of the week?
select datename(WEEKDAY, order_time) AS DayOfWeek, count(order_id) AS OrderVolume
from customer_orders
group by datename(WEEKDAY, order_time)









--B. Runner and Customer Experience
--1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
--2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
--3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
--4. What was the average distance travelled for each customer?
--5. What was the difference between the longest and shortest delivery times for all orders?
--6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
--7. What is the successful delivery percentage for each runner?




