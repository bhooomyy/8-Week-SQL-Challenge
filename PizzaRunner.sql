update customer_orders 
set 
exclusions=(case when exclusions is NULL or exclusions LIKE 'null' then ' ' else exclusions end),
extras=(case when extras is NULL or extras LIKE 'null' then ' ' else extras end);

select * from customer_orders;

update runner_orders
set
pickup_time=(case when pickup_time is null or pickup_time like 'null' then ' ' else pickup_time end),
distance=(case when distance like 'null' then ' ' else replace(distance,'km','') end),
duration=(case when duration like 'null' then ' ' else replace(replace(replace(duration,'mins',''),'minutes',''),'minute','') end),
cancellation=(case when cancellation is null or cancellation like 'null' then ' ' else cancellation end);

select * from runner_orders;

-- Queries
--How many pizzas were ordered?
select count(*) from customer_orders;

--How many unique customer orders were made?
select count(distinct order_id) from customer_orders;

--How many successful orders were delivered by each runner?
select runner_id,count(*) as total_orders_delivered from runner_orders where duration  not like ' ' group by runner_id order by runner_id asc;

--How many of each type of pizza was delivered?
with intermediateTable as (select pizza_id,count(pizza_id) as cnt_of_pizza from customer_orders c join runner_orders r on c.order_id=r.order_id where duration not like ' ' group by pizza_id order by pizza_id asc)
select i.pizza_id,p.pizza_name,i.cnt_of_pizza from intermediateTable i join pizza_names p on i.pizza_id=p.pizza_id;