col table_name for a15;
col column_id for 99;
col column_name for a20;
col data_type for a12;
col nullable for a10;
col constraint_type for a10;
col comments for a30;

SELECT
    x.table_name,
    x.column_id,
    x.column_name,
    x.data_type,
    x.data_length,
    x.nullable,
    y.constraint_type,
    x.comments
FROM
    (
        SELECT
            a.table_name,
            a.column_id,
            a.column_name,
            a.data_type,
            a.data_length,
            a.nullable,
            b.comments
        FROM
            cols a,
            user_col_comments b
        WHERE
            a.table_name = b.table_name
            AND a.column_name = b.column_name
            and a.table_name in ( select table_name from user_tables)
    ) x,
    (
        SELECT
            c.table_name,
            c.column_name,
            c.constraint_name,
            d.constraint_type
        FROM
            user_cons_columns c,
            user_constraints d
        WHERE
            c.table_name = d.table_name
            AND c.constraint_name = d.constraint_name
            and d.constraint_type in ('P','R')
    ) y
WHERE
    x.table_name = y.table_name (+)
    AND x.column_name = y.column_name (+)
ORDER BY
    1,
    2;
    