-- 단어의 첫단어만 뽑아내기
create or replace function str1127(p_str in varchar2)
return varchar2 
is v_str varchar2(100);
begin
    select listagg(txt,'') within group(order by lvl) 
    into v_str
    from (
        SELECT level lvl,substr(regexp_substr(A.TXT, '[^_]+', 1, LEVEL),1,1) TXT
           FROM (SELECT ''||p_str TXT FROM dual) A
        CONNECT BY LEVEL <= length(regexp_replace(A.TXT, '[^_]+',''))+1   
    );
    return v_str;
end;
/
-- select listagg(txt,'') within group(order by lvl) word
-- from (
--     SELECT level lvl,substr(regexp_substr(A.TXT, '[^_]+', 1, LEVEL),1,1) TXT
--        FROM (SELECT 'TB_MOBILE_BAG_LINE' TXT FROM dual) A
--     CONNECT BY LEVEL <= length(regexp_replace(A.TXT, '[^_]+',''))+1   
-- );

-- select str1127('TB_MOBILE_BAG_LINE') from dual;