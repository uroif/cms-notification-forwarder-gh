-- SQL Script to get all information about triggers in the public schema
-- This query retrieves comprehensive information about all triggers in Supabase

SELECT 
    n.nspname AS schema_name,
    t.tgname AS trigger_name,
    c.relname AS table_name,
    CASE t.tgtype & 1
        WHEN 1 THEN 'ROW'
        ELSE 'STATEMENT'
    END AS trigger_level,
    CASE 
        WHEN t.tgtype & 2 = 2 THEN 'BEFORE'
        WHEN t.tgtype & 64 = 64 THEN 'INSTEAD OF'
        ELSE 'AFTER'
    END AS trigger_timing,
    CONCAT_WS(', ',
        CASE WHEN t.tgtype & 4 = 4 THEN 'INSERT' END,
        CASE WHEN t.tgtype & 8 = 8 THEN 'DELETE' END,
        CASE WHEN t.tgtype & 16 = 16 THEN 'UPDATE' END,
        CASE WHEN t.tgtype & 32 = 32 THEN 'TRUNCATE' END
    ) AS trigger_events,
    p.proname AS trigger_function,
    pg_get_triggerdef(t.oid) AS trigger_definition,
    t.tgenabled AS enabled_status,
    CASE t.tgenabled
        WHEN 'O' THEN 'ENABLED'
        WHEN 'D' THEN 'DISABLED'
        WHEN 'R' THEN 'REPLICA'
        WHEN 'A' THEN 'ALWAYS'
    END AS enabled_status_text,
    t.tgisinternal AS is_internal,
    t.tgdeferrable AS is_deferrable,
    t.tginitdeferred AS is_initially_deferred,
    pg_catalog.obj_description(t.oid, 'pg_trigger') AS description,
    t.oid AS trigger_oid,
    CASE 
        WHEN t.tgconstraint != 0 THEN 'CONSTRAINT TRIGGER'
        ELSE 'REGULAR TRIGGER'
    END AS trigger_category
FROM 
    pg_catalog.pg_trigger t
    LEFT JOIN pg_catalog.pg_class c ON c.oid = t.tgrelid
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
    LEFT JOIN pg_catalog.pg_proc p ON p.oid = t.tgfoid
WHERE 
    n.nspname = 'public'  -- Filter for public schema only
    AND NOT t.tgisinternal  -- Exclude internal triggers
ORDER BY 
    c.relname, t.tgname;


-- Alternative: Simplified version with just essential information
-- Uncomment below if you prefer a simpler output

/*
SELECT 
    c.relname AS table_name,
    t.tgname AS trigger_name,
    CASE 
        WHEN t.tgtype & 2 = 2 THEN 'BEFORE'
        WHEN t.tgtype & 64 = 64 THEN 'INSTEAD OF'
        ELSE 'AFTER'
    END AS timing,
    CONCAT_WS(', ',
        CASE WHEN t.tgtype & 4 = 4 THEN 'INSERT' END,
        CASE WHEN t.tgtype & 8 = 8 THEN 'DELETE' END,
        CASE WHEN t.tgtype & 16 = 16 THEN 'UPDATE' END,
        CASE WHEN t.tgtype & 32 = 32 THEN 'TRUNCATE' END
    ) AS events,
    p.proname AS function_name,
    pg_get_triggerdef(t.oid) AS full_definition
FROM 
    pg_catalog.pg_trigger t
    LEFT JOIN pg_catalog.pg_class c ON c.oid = t.tgrelid
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
    LEFT JOIN pg_catalog.pg_proc p ON p.oid = t.tgfoid
WHERE 
    n.nspname = 'public'
    AND NOT t.tgisinternal
ORDER BY 
    c.relname, t.tgname;
*/


-- Get triggers with their function source code
-- Uncomment below to see triggers alongside their function implementations

/*
SELECT 
    c.relname AS table_name,
    t.tgname AS trigger_name,
    CASE 
        WHEN t.tgtype & 2 = 2 THEN 'BEFORE'
        WHEN t.tgtype & 64 = 64 THEN 'INSTEAD OF'
        ELSE 'AFTER'
    END AS timing,
    CONCAT_WS(', ',
        CASE WHEN t.tgtype & 4 = 4 THEN 'INSERT' END,
        CASE WHEN t.tgtype & 8 = 8 THEN 'DELETE' END,
        CASE WHEN t.tgtype & 16 = 16 THEN 'UPDATE' END,
        CASE WHEN t.tgtype & 32 = 32 THEN 'TRUNCATE' END
    ) AS events,
    p.proname AS function_name,
    pg_get_functiondef(p.oid) AS function_source_code,
    pg_get_triggerdef(t.oid) AS trigger_definition
FROM 
    pg_catalog.pg_trigger t
    LEFT JOIN pg_catalog.pg_class c ON c.oid = t.tgrelid
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
    LEFT JOIN pg_catalog.pg_proc p ON p.oid = t.tgfoid
WHERE 
    n.nspname = 'public'
    AND NOT t.tgisinternal
ORDER BY 
    c.relname, t.tgname;
*/


-- Get just trigger names by table
-- Uncomment below for a quick overview

/*
SELECT 
    c.relname AS table_name,
    t.tgname AS trigger_name,
    CASE t.tgenabled
        WHEN 'O' THEN 'ENABLED'
        WHEN 'D' THEN 'DISABLED'
        WHEN 'R' THEN 'REPLICA'
        WHEN 'A' THEN 'ALWAYS'
    END AS status
FROM 
    pg_catalog.pg_trigger t
    LEFT JOIN pg_catalog.pg_class c ON c.oid = t.tgrelid
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE 
    n.nspname = 'public'
    AND NOT t.tgisinternal
ORDER BY 
    c.relname, t.tgname;
*/
