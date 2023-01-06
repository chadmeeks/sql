-- https://prestodb.io/docs/current/functions/datetime.html

-- Date and Time Operators
SELECT current_date, current_date + interval '2' day;
SELECT current_timestamp, current_timestamp + interval '2' day;
SELECT localtimestamp, localtimestamp + interval '2' day;

-- Date and Time Functions

-- NOTE: The following SQL-standard functions do not use parenthesis:
-- current_date
-- current_time
-- current_timestamp
-- localtime
-- localtimestamp

SELECT current_date, current_time, current_timestamp, NOW(), localtimestamp;

SELECT current_timezone();

SELECT CAST(now() as DATE);
SELECT date(now()); -- This is an alias for CAST(x AS DATE)

SELECT localtime; -- time without timezone
SELECT localtimestamp; -- timestamp without timezone

-- Converting strings and unix timestamps
SELECT from_iso8601_date('2015-02-14'); -- convert iso8601 string into date
SELECT to_iso8601(current_timestamp); -- convert date, timestamp, or timestamp with timezone to varchar iso8601 format

SELECT from_unixtime(1672955101); -- convert epoch milliseconds to timestamp
SELECT to_unixtime(localtimestamp); -- convert timestamp to a unix epoch timestamp 

-- date_trunc(unit,x) -> returns x truncated to the unit
SELECT date_trunc('year', current_date) as truncated_year, date_trunc('month', current_date) as truncated_month;

-- Interval Functions
SELECT date_add('day', 2, current_timestamp);
SELECT date_add('day', 2, current_date);

SELECT current_date, current_date - interval '2' day;
SELECT date_diff('day', current_date, current_date - interval '2' day);

SELECT localtimestamp, localtimestamp - interval '2' day;
SELECT date_diff('day', localtimestamp, localtimestamp - interval '2' day);

-- Extract

SELECT extract(YEAR FROM localtimestamp);


-- MA Timestamp
SELECT title, retailer_transaction_timestamp_utc, localtimestamp as local_timestamp FROM "production_anon_ma_analytics_tables"."transactions" 
LIMIT 10;


SELECT retailer_transaction_timestamp_utc, localtimestamp FROM "production_anon_ma_analytics_tables"."transactions"
LIMIT 10;

-- Date Diff

SELECT title, retailer_transaction_timestamp_utc, localtimestamp as local_time_stamp, date_diff('day', retailer_transaction_timestamp_utc, localtimestamp) as days_diff FROM "production_ma_analytics_tables"."transactions"
LIMIT 10;

SELECT title, retailer_transaction_timestamp_utc, localtimestamp as local_time_stamp, date_diff('day', retailer_transaction_timestamp_utc, localtimestamp) as days_diff FROM "production_ma_analytics_tables"."transactions"
WHERE date_diff('day', retailer_transaction_timestamp_utc, localtimestamp) < 1000
LIMIT 10;

-- Extract

SELECT title, retailer_transaction_timestamp_utc, extract(YEAR FROM retailer_transaction_timestamp_utc) FROM "production_anon_ma_analytics_tables"."transactions"
LIMIT 1000;

SELECT title, retailer_transaction_timestamp_utc FROM "production_anon_ma_analytics_tables"."transactions"
WHERE extract(YEAR FROM retailer_transaction_timestamp_utc) = 2021
LIMIT 10;

SELECT distinct(extract(YEAR FROM retailer_transaction_timestamp_utc)), count(*) FROM "production_anon_ma_analytics_tables"."transactions"
GROUP BY 1
ORDER BY 1 DESC
