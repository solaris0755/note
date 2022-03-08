col event for a30;
col multiblock_read_count for a30;
select e.event
, e.total_waits " ÃÑ´ë±âÈ½¼ö"
, round(e.time_waited_micro/1000000) "ÃÑ´ë±â½Ã°£(s)"
, round(e.time_waited_micro/e.total_waits/1000,2) "Æò±Õ´ë±â½Ã°£(ms)"
,(case when event='db file scattered read' then p.value end) multiblock_read_count
from v$system_event e, v$parameter p
where e.event in ('db file scattered read', 'db file sequential read')
and p.name ='db_file_multiblock_read_count'
order by e.event desc;
