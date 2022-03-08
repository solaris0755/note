accept user_id char prompt 'Enter UserID : '

grant select on v_$session to &user_id;
grant select on v_$sql_plan_statistics_all to &user_id;
grant select on v_$sql to &user_id;
