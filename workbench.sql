-- Currently Linked to Google
SELECT core_id, linked_retailers_current FROM "production_anon_ma_analytics_summary"."enriched_users_lifetime" AS users
WHERE linked_retailers_current LIKE '%GOO%'
limit 100;

-- EST and Redemption Transactions Past 6 Months
SELECT core_id, transaction_id, retailer_name, transaction_type, retailer_transaction_date_pt FROM "production_anon_ma_analytics_summary"."attributed_enriched_keychest_transactions_lifetime" AS transactions
WHERE transaction_type IN ('redemption', 'est')
AND CAST(retailer_transaction_date_pt AS DATE) >= DATE_ADD('month', -6, current_date)
limit 100;

-- All Transactions from Users Currently Link to Google for the Past 6 Months
SELECT users.core_id, users.linked_retailers_current, transactions.transaction_id, transactions.retailer_name, transactions.transaction_type, transactions.retailer_transaction_date_pt
FROM "production_anon_ma_analytics_summary"."enriched_users_lifetime" AS users
JOIN "production_anon_ma_analytics_summary"."attributed_enriched_keychest_transactions_lifetime" AS transactions
ON users.core_id = transactions.core_id
WHERE users.linked_retailers_current LIKE '%GOO%'
AND transactions.transaction_type IN ('redemption', 'est')
AND CAST(transactions.retailer_transaction_date_pt AS DATE) >= DATE_ADD('month', -6, current_date)
limit 100;

SELECT count(*)
FROM "production_anon_ma_analytics_summary"."enriched_users_lifetime" AS users
JOIN "production_anon_ma_analytics_summary"."attributed_enriched_keychest_transactions_lifetime" AS transactions
ON users.core_id = transactions.core_id
WHERE users.linked_retailers_current LIKE '%GOO%'
AND transactions.transaction_type IN ('redemption', 'est')
AND CAST(transactions.retailer_transaction_date_pt AS DATE) >= DATE_ADD('month', -6, current_date)
limit 100;

-- Chad Approach
SELECT count(*) FROM "production_anon_ma_analytics_summary"."enriched_users_lifetime"
WHERE linked_retailers_current LIKE '%GOO%'
AND core_id NOT IN (
  SELECT DISTINCT core_id FROM "production_anon_ma_analytics_summary"."attributed_enriched_keychest_transactions_lifetime"
  WHERE transaction_type IN ('redemption', 'est')
  -- AND retailer_name = 'GOO'
  AND CAST(retailer_transaction_date_pt AS DATE) >= DATE_ADD('month', -6, current_date)
);


-- Hubert Approach
select count(distinct core_id) core_ids
from production_anon_ma_analytics_tables.links
where currently_linked
and retailer_name = 'GOO'
and core_id not in (
  select distinct core_id
  from production_anon_ma_analytics_tables.transactions
  where retailer_name = 'GOO'
  and retailer_transaction_date_pt >= cast(date_add('month', -6, current_date) as varchar)
  and transaction_type in ('est', 'redemption')
);

-- Links Table
SELECT * FROM production_anon_ma_analytics_tables.links LIMIT 100;

-- Some Date Functions
SELECT CAST('2022-12-06' AS DATE);
SELECT DATE_ADD('day', -60, current_date);
