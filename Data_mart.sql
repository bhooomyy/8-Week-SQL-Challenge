-- Convert the week_date to a DATE format
alter table weekly_sales
alter column week_date type VARCHAR(10);

update weekly_sales set week_date=to_date(week_date, 'dd-mm-yy');

alter table weekly_sales
alter column week_date type date
using to_date(week_date,'yyyy-mm-dd');

-- Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
alter table weekly_sales
add column week_number integer;
-- update weekly_sales set week_number = ceil(extract(day from week_date) / 7.0);
update weekly_sales
set week_number=ceil(extract(doy from week_date) / 7.0);
