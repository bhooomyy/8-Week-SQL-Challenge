update customer_orders 
set 
exclusions=(case when exclusions is NULL or exclusions LIKE 'null' then ' ' else exclusions end),
extras=(case when extras is NULL or extras LIKE 'null' then ' ' else extras end);

select * from customer_orders;

