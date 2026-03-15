with cte as(select 
sessionid, 
max(itemsincart) as itemsincart,
max(purchased) as purchased
from ecommerce_journey
group by sessionid)

select itemsincart,
cast(round((sum(purchased)*100.0/count(*)),2)
as decimal(10,2)) as conversion_rate
from cte
group by itemsincart 
order by itemsincart
