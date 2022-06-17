col SEGMENT_TYPE for a20;
col SEGMENT_NAME for a20;
col TABLESPACE_NAME for a20;
col BYTES for 999999999

SELECT SEGMENT_TYPE
         , SEGMENT_NAME
         , TABLESPACE_NAME
         , BYTES
  FROM USER_SEGMENTS
WHERE SEGMENT_TYPE = 'TABLE'
ORDER BY SEGMENT_TYPE,SEGMENT_NAME;