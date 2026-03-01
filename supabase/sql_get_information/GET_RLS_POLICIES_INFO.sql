-- SQL Script to get all information about RLS (Row Level Security) policies in the public schema
-- This query retrieves comprehensive information about all RLS policies in Supabase

SELECT 
    n.nspname AS schema_name,
    c.relname AS table_name,
    pol.polname AS policy_name,
    CASE pol.polcmd
        WHEN 'r' THEN 'SELECT'
        WHEN 'a' THEN 'INSERT'
        WHEN 'w' THEN 'UPDATE'
        WHEN 'd' THEN 'DELETE'
        WHEN '*' THEN 'ALL'
    END AS command,
    CASE 
        WHEN pol.polpermissive THEN 'PERMISSIVE'
        ELSE 'RESTRICTIVE'
    END AS policy_type,
    CASE 
        WHEN pol.polroles = '{0}' THEN 'PUBLIC'
        ELSE array_to_string(ARRAY(
            SELECT rolname 
            FROM pg_roles 
            WHERE oid = ANY(pol.polroles)
        ), ', ')
    END AS roles,
    pg_get_expr(pol.polqual, pol.polrelid) AS using_expression,
    pg_get_expr(pol.polwithcheck, pol.polrelid) AS check_expression,
    c.relrowsecurity AS table_rls_enabled,
    c.relforcerowsecurity AS table_rls_forced,
    pol.oid AS policy_oid,
    pg_catalog.obj_description(pol.oid, 'pg_policy') AS description
FROM 
    pg_catalog.pg_policy pol
    LEFT JOIN pg_catalog.pg_class c ON c.oid = pol.polrelid
    LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE 
    n.nspname = 'public'  -- Filter for public schema only
ORDER BY 
    c.relname, pol.polname;
