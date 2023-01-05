-- Example of extrancing Windowing JSON Data
select movie_title, w,
json_extract_scalar(w, '$.window') as w_window,
date(from_unixtime(cast(substr(json_extract_scalar(w, '$.startDate'), 1, 10) as bigint)) at time zone 'America/Los_Angeles') as w_start_date,
date(from_unixtime(cast(substr(json_extract_scalar(w, '$.endDate'), 1, 10) as bigint)) at time zone 'America/Los_Angeles') as w_end_date,
json_extract_scalar(w, '$.endType') as w_end_type,
json_extract_scalar(w, '$.definition') as w_definition
from production_anon_ma_analytics_summary.titles_hourly_deanon
cross join unnest(cast(json_extract(avail_windows, '$') as array(json))) as t(w)
where asset_id in (
   '94fc3b5a-1862-4110-8a8e-a708dd519b17',
   'f0f56219-0802-45ed-9451-1c14a9eaecdf'
)


-- Example to parse JSON map price_frequencies containing something like {"9.99":21,"14.99":5,"13.99":2} where the key is a price.

with d as (
  select guid, title, purchase_format, retailer, regular_price, price,
  case 
  when price > regular_price then 'higher'
  when price = regular_price then 'same'
  else 'lower'
  end as price_vs_regular,
  price_frequencies,
  cast(json_extract(price_frequencies, '$') as map(double, int)) as price_frequencies_map
  from production_anon_ma_analytics_offers.daily_prices_enriched_deanon
  where dt = '2022-04-04' 
  and guid in (
    'bcde51be-71d8-4e3d-99fe-15f307c87ea8'
  )
)
select guid, title, purchase_format, retailer, price, regular_price, 
price_frequencies, key as freq_price, element_at(price_frequencies_map, key) AS freq_count
from d
cross join unnest (map_keys(price_frequencies_map)) as price_frequency(key)
where price_vs_regular = 'higher'
