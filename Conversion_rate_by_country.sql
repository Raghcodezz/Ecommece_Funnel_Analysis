select
country,
cast(round((sum(purchased)*100.0/count(*)),2)
as decimal(10,2)) as conversion_rate
from ecommerce_journey
group by country
order by cast(round((sum(purchased)*100.0/count(*)),2)
as decimal(10,2)) desc
