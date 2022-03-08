col INDEX_NAME heading "TYPE : INDEX_NAME" for a42
col "UQ" for a2 
col column_name for a20
col ordinal heading "ORD" for 99
col descend heading "DESC" for a4
col column_exp for a30

set verify off
set echo off
set feedback off
set serveroutput on 
set pagesize 999
set linesize 200
break on index_name skip 1

prompt
accept tname prompt 'TABLE : '

select decode(i.index_type,
        'NORMAL','NORMAL',
        'BITMAP','BITMAP',
        'IOT - TOP', 'IOT   ',
        'FUNCTION-BASED NORMAL','FBI-NR',
        'FUNCTION-BASED BITMAP','FBI-BI',
        'DOMAIN','DOMAIN',
        'NORMAL/REV', 'NR/REV',
        '      ') || ' : ' || i.index_name || decode(partitioned,'YES', '(P)') index_name
    , decode(i.uniqueness, 'UNIQUE', 'Y', 'N') "UQ"
    , column_name, i.column_position ordinal, descend
    , e.column_expression column_exp
from (
select i.table_name, c.index_name, i.index_type
     , i.uniqueness
     , c.column_name
     , c.column_position
     , descend
     , partitioned
     , decode(t.constraint_type,'P', 'Y','N') ispk
     , decode(t.constraint_type,'U', 'Y','N') isuk
from user_ind_columns c, user_indexes i, user_constraints t 
where i.index_name = c.index_name
and i.table_name=upper('&tname')     
and t.table_name(+)=upper('&tname')
and t.constraint_type(+) = 'P'
and t.index_name(+) = i.index_name) i, user_ind_expressions e 
where e.table_name(+) = i.index_name 
and e.index_name(+) = i.index_name
and e.column_position(+) = i.column_position
order by decode(i.ispk, 'Y', 'A', 'B'), i.index_name, ordinal;
