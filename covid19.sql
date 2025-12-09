create database covid19;
use covid19;
desc full_grouped;
select * from full_grouped;
rename table full_grouped to covid_data;
desc covid_data;
alter table covid_data change column `Country/Region` country varchar(30);
alter table covid_data change column `New cases` New_cases int;
alter table covid_data change column `New deaths` New_deaths int;
alter table covid_data change column `New recovered` New_recovered int;
alter table covid_data change column `WHO Region` WHO_Region varchar(100);
alter table covid_data change country Country varchar(100);
alter table covid_data modify Date date;
-- Show the first 10 rows of the dataset.
select * from covid_data
limit 10;

-- Count total records in the COVID table.
select count(*) as total_records from covid_data;

-- Show all unique countries.
select distinct Country 
from covid_data;

-- Count how many days of data are available.
select count(date) as Total_days_of_data 
from (select distinct date 
from covid_data) as Total_days;

-- Total confirmed cases in the world.
select sum(Confirmed) as Total_covid_patient
from covid_data;

-- Total deaths in the world.
select sum(deaths) as Total_deaths
from covid_data;

-- Total recovered cases in the world.
select sum(recovered) as Total_recovered_patient
from covid_data;

-- Total active cases in the world.
select sum(active) as Total_active_cases
from covid_data;

-- Case Fatality Rate (CFR = deaths ÷ confirmed × 100).
select (sum(deaths)/sum(confirmed))*100 as Case_fatality_rate
from covid_data;

-- Recovery Rate (recovered ÷ confirmed × 100).
select(sum(recovered)/sum(confirmed))*100 as Recovery_rate
from covid_data;

-- List top 10 countries with highest confirmed cases.
select country,sum(confirmed) as Total_confirmed_patient
from covid_data
group by country 
order by  Total_confirmed_patient desc
limit 10;

-- List top 10 countries with highest deaths.
select country,sum(deaths) as Total_deaths
from covid_data
group by country 
order by  Total_deaths desc
limit 10;

-- Countries with 0 deaths.
select country,Total_deaths
from(select country , sum(deaths) as Total_deaths
from covid_data 
group by country) as data
where Total_deaths =0;

-- Country-wise daily increase in cases.
select country,date,sum(new_cases) as Daily_cases
from covid_data
group by country,date;
-- Which country has the fastest growth rate?
-- Daily growth rate per country
select country,date,new_cases,active,
round((new_cases * 100.0 / lag(active) over (partition by country order by date)), 2) as daily_growth_rate
from covid_data
order by country, date;

select * from covid_data;

-- Highest single-day increase in confirmed cases (worldwide).
select date,dayname(date)as day,sum(new_cases) as total_new_cases
from covid_data
group by date
order by total_new_cases desc
limit 1;

-- Highest single-day increase in deaths (worldwide).
select date,dayname(date) as day,sum(new_deaths) as highest_deaths_day
from covid_data
group by date
order by highest_deaths_day desc
limit 1;

-- Total confirmed cases per day.
select date,dayname(date) as day,sum(confirmed) as day_wise_cases
from covid_data
group by date;

-- Total deaths per day.
select date,dayname(date) as day, sum(new_deaths) as day_wise_death
from covid_data
group by date;

-- Total recovered per day.
select date,dayname(date) as day, sum(new_recovered) as day_wise_recovered
from covid_data
group by date;

-- 7-day moving average of confirmed cases.-- 7-day moving average of confirmed cases worldwide
select date,sum(confirmed) as daily_confirmed,
round(avg(sum(confirmed)) over (order by date
rows between 6 preceding and current row), 2) as moving_avg_7day
from covid_data
group by date
order by date;

-- 7-day moving average of deaths.
select date,sum(deaths) as daily_deaths,
round(avg(sum(deaths))over (order by date
rows between 6 preceding and current row),2) as moving_avg_7day
from covid_data
group by date
order by date;

-- Daily growth rate of confirmed cases worldwide
select date,sum(confirmed) as total_confirmed,
round(
((sum(confirmed) - lag(sum(confirmed)) over (order by date)) * 100.0) 
/ lag(sum(confirmed)) over (order by date),2) as daily_growth_rate
from covid_data
group by date
order by date;

-- Day with maximum active cases.
select date,sum(active) as Total_active
from covid_data
group by date
order by total_active desc
limit 1;

-- Week-wise total new cases worldwide
select 
    year(date) as year,
    week(date, 1) as week_number,  -- week starting from Monday
    sum(new_cases) as weekly_cases
from covid_data
group by year(date), week(date, 1)
order by year, week_number;

-- Mortality rate trend per country.
select country ,date,
sum(deaths) as total_deaths ,
sum(confirmed) as total_confirmed,
(sum(deaths)/sum(confirmed))*100 as mortality_rate
from covid_data
group by country,date
order by country,date;

-- Compare India vs USA – daily cases.
select date,country,confirmed
from covid_data
where country in ('India','china');

-- Calculate % contribution of each country to global cases.
select country,sum(confirmed) as total_confirmed,
round((sum(confirmed)/(select sum(confirmed) from covid_data))* 100,2) as percentage_contributed
from covid_data
group by country
order by percentage_contributed desc;

-- Identify outlier days (spike in cases).
select date,new_cases,
lag(new_cases) over (order by date) as previous_day,
case
when new_cases > 2 *lag(new_cases) over (order by date)
then 'Spike'
else 'Normal'
end as Status
from covid_data
order by date;

-- Which country is safest?
select country,
sum(confirmed) as Total_cases,
sum(deaths) as Total_deaths,
round((sum(deaths)/sum(confirmed))*100,2) as mortality_cases
from covid_data
group by country
order by mortality_cases asc,total_cases asc
limit 1 ;

-- Which country is worst affected?
select country,
sum(confirmed) as Total_cases,
sum(deaths) as Total_deaths,
round((sum(deaths)/sum(confirmed))*100,2) as mortality_cases
from covid_data
group by country
order by total_deaths desc , total_Cases desc
limit 1;

