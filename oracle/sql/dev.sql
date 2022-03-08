create tablespace dev datafile 'c:\oraclexe\app\oracle\oradata\XE\DEV.DBF' size 5M extent management local uniform size 1M;
create user dev identified by dev profile default default tablespace dev account unlock;
grant resource, connect,unlimited tablespace to dev;