--1. How many customers has Foodie-Fi ever had?
select count(distinct customer_id) from subscriptions;

--2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
select 
extract(month from start_date) as monthlywise_subscription_trial,
count(customer_id) as cnt_of_people_purchased_trial 
from subscriptions 
where plan_id=0 
group by extract(month from start_date);

--3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
select 
s.plan_id,
plan_name,
count(s.plan_id) as cnt_of_events 
from subscriptions s join plans p on p.plan_id=s.plan_id 
where extract(year from start_date)>2020 
group by s.plan_id,plan_name 
order by s.plan_id asc; 

--4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
/*with churn_cnt as (select 
count(*) as churn_cnt 
from subscriptions where plan_id=4),

total_cnt as(
select 
  count(distinct customer_id) as total_cnt
  from subscriptions)

select 
churn_cnt,
round(((100.0*churn_cnt)/(total_cnt)),2)::text||'%' as churn_percentage 
from churn_cnt cross join total_cnt;
*/
select 
count(customer_id) as churn_cnt,
round((100.0*count(distinct customer_id))/(select count(distinct customer_id) from subscriptions),2)::text||'%' as churn_percentage 
from subscriptions 
where plan_id=4;

