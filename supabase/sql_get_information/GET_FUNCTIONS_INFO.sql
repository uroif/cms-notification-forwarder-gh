-- SQL Script to get all information about functions in the public schema
-- This query retrieves comprehensive information about all functions in Supabase

SELECT 
    n.nspname AS schema_name,
    p.proname AS function_name,
    pg_get_function_arguments(p.oid) AS function_arguments,
    pg_get_function_result(p.oid) AS return_type,
    CASE p.prokind
        WHEN 'f' THEN 'FUNCTION'
        WHEN 'p' THEN 'PROCEDURE'
        WHEN 'a' THEN 'AGGREGATE'
        WHEN 'w' THEN 'WINDOW'
    END AS function_type,
    CASE p.provolatile
        WHEN 'i' THEN 'IMMUTABLE'
        WHEN 's' THEN 'STABLE'
        WHEN 'v' THEN 'VOLATILE'
    END AS volatility,
    CASE p.proparallel
        WHEN 's' THEN 'SAFE'
        WHEN 'r' THEN 'RESTRICTED'
        WHEN 'u' THEN 'UNSAFE'
    END AS parallel_safety,
    pg_get_functiondef(p.oid) AS function_definition,
    p.prosecdef AS security_definer,
    p.proleakproof AS leak_proof,
    p.proisstrict AS is_strict,
    p.proretset AS returns_set,
    l.lanname AS language,
    p.procost AS estimated_cost,
    p.prorows AS estimated_rows,
    pg_catalog.obj_description(p.oid, 'pg_proc') AS description,
    p.oid AS function_oid,
    pg_get_userbyid(p.proowner) AS owner
FROM 
    pg_catalog.pg_proc p
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
    LEFT JOIN pg_catalog.pg_language l ON l.oid = p.prolang
WHERE 
    n.nspname = 'public'  -- Filter for public schema only
ORDER BY 
    p.proname;
