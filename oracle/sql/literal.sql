select *
from (
  select parsing_schema_name, sql_id, sql_text, executions
       , sum(executions) over (partition by force_matching_signature ) executions_sum
       , row_number() over (partition by force_matching_signature order by sql_id desc) rnum
       , count(*) over (partition by force_matching_signature ) cnt
       , force_matching_signature
  from   gv$sqlarea s
  where  force_matching_signature != 0
)
where  cnt > 5
order by cnt desc, sql_text
;