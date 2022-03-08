-- accept tblspc_name char prompt 'Enter TableSpace Name : '

-- -- 테이블 스페이스 정보 확인
-- col tablespace_name for a20
-- col status for a10
-- col contents for a10
-- col segment_space_management for a10
-- col allocation_type for a10
-- col block_size for 999999
-- select tablespace_name, status, contents, segment_space_management, allocation_type, block_size
-- from dba_tablespaces where tablespace_name=upper('&tblspc_name')  ;

-- -- 데이터 파일 정보
-- col file_name for a50
-- col autoextensible for a10
-- select file_name, tablespace_name, bytes/1023/1023 as MB, autoextensible
-- from dba_data_files  where tablespace_name=upper('&tblspc_name') ;

-- -- 테이블 스페이스 정보 확인
SELECT U.TABLESPACE_NAME "GHSDTS"
         , U.BYTES / 1024000 "크기(MB)"
         , (U.BYTES - SUM(NVL(F.BYTES,0))) / 1024000 "사용됨(MB)"
         , (SUM(NVL(F.BYTES,0))) / 1024000 "남음(MB)"
         , TRUNC((SUM(NVL(F.BYTES,0)) / U.BYTES) * 100,2) "남은 %"
  FROM DBA_FREE_SPACE F, DBA_DATA_FILES U
 WHERE F.FILE_ID(+) = U.FILE_ID
 GROUP BY U.TABLESPACE_NAME, U.FILE_NAME, U.BYTES
 ORDER BY U.TABLESPACE_NAME;