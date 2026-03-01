-- SQL Script to get all information about schema (tables and columns) in the public schema
-- This query retrieves comprehensive information about all tables and columns in Supabase

-- ===========================================
-- TABLES AND COLUMNS - COMPREHENSIVE VIEW
-- ===========================================

SELECT 
    t.table_schema AS schema_name,
    t.table_name,
    t.table_type,
    c.column_name,
    c.ordinal_position,
    c.data_type,
    c.character_maximum_length,
    c.numeric_precision,
    c.numeric_scale,
    c.is_nullable,
    c.column_default,
    c.udt_name AS underlying_type,
    CASE 
        WHEN pk.column_name IS NOT NULL THEN 'YES'
        ELSE 'NO'
    END AS is_primary_key,
    CASE 
        WHEN fk.column_name IS NOT NULL THEN 'YES'
        ELSE 'NO'
    END AS is_foreign_key,
    fk.foreign_table_name,
    fk.foreign_column_name,
    pg_catalog.col_description(
        (t.table_schema || '.' || t.table_name)::regclass::oid, 
        c.ordinal_position
    ) AS column_description
FROM 
    information_schema.tables t
    LEFT JOIN information_schema.columns c 
        ON t.table_schema = c.table_schema 
        AND t.table_name = c.table_name
    LEFT JOIN (
        -- Primary key columns
        SELECT 
            kcu.table_schema,
            kcu.table_name,
            kcu.column_name
        FROM 
            information_schema.table_constraints tc
            JOIN information_schema.key_column_usage kcu
                ON tc.constraint_name = kcu.constraint_name
                AND tc.table_schema = kcu.table_schema
        WHERE 
            tc.constraint_type = 'PRIMARY KEY'
    ) pk ON c.table_schema = pk.table_schema 
        AND c.table_name = pk.table_name 
        AND c.column_name = pk.column_name
    LEFT JOIN (
        -- Foreign key columns
        SELECT 
            kcu.table_schema,
            kcu.table_name,
            kcu.column_name,
            ccu.table_name AS foreign_table_name,
            ccu.column_name AS foreign_column_name
        FROM 
            information_schema.table_constraints tc
            JOIN information_schema.key_column_usage kcu
                ON tc.constraint_name = kcu.constraint_name
                AND tc.table_schema = kcu.table_schema
            JOIN information_schema.constraint_column_usage ccu
                ON tc.constraint_name = ccu.constraint_name
                AND tc.table_schema = ccu.table_schema
        WHERE 
            tc.constraint_type = 'FOREIGN KEY'
    ) fk ON c.table_schema = fk.table_schema 
        AND c.table_name = fk.table_name 
        AND c.column_name = fk.column_name
WHERE 
    t.table_schema = 'public'
ORDER BY 
    t.table_name, c.ordinal_position;


-- ===========================================
-- ALTERNATIVE: TABLES ONLY (NO COLUMNS)
-- ===========================================
-- Uncomment below to get just table information

/*
SELECT 
    schemaname AS schema_name,
    tablename AS table_name,
    tableowner AS owner,
    hasindexes AS has_indexes,
    hasrules AS has_rules,
    hastriggers AS has_triggers,
    rowsecurity AS rls_enabled,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS total_size,
    pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) AS table_size,
    pg_size_pretty(pg_indexes_size(schemaname||'.'||tablename)) AS indexes_size
FROM 
    pg_catalog.pg_tables
WHERE 
    schemaname = 'public'
ORDER BY 
    tablename;
*/


-- ===========================================
-- ALTERNATIVE: COLUMNS ONLY (GROUPED BY TABLE)
-- ===========================================
-- Uncomment below to see columns grouped by table

/*
SELECT 
    table_name,
    column_name,
    ordinal_position,
    data_type,
    CASE 
        WHEN character_maximum_length IS NOT NULL 
        THEN data_type || '(' || character_maximum_length || ')'
        WHEN numeric_precision IS NOT NULL 
        THEN data_type || '(' || numeric_precision || ',' || numeric_scale || ')'
        ELSE data_type
    END AS full_data_type,
    is_nullable,
    column_default
FROM 
    information_schema.columns
WHERE 
    table_schema = 'public'
ORDER BY 
    table_name, ordinal_position;
*/


-- ===========================================
-- ALTERNATIVE: TABLE STRUCTURE WITH CONSTRAINTS
-- ===========================================
-- Uncomment below to see tables with all their constraints

/*
SELECT 
    t.table_name,
    t.table_type,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column,
    rc.update_rule,
    rc.delete_rule
FROM 
    information_schema.tables t
    LEFT JOIN information_schema.table_constraints tc 
        ON t.table_schema = tc.table_schema 
        AND t.table_name = tc.table_name
    LEFT JOIN information_schema.key_column_usage kcu 
        ON tc.constraint_name = kcu.constraint_name
        AND tc.table_schema = kcu.table_schema
    LEFT JOIN information_schema.constraint_column_usage ccu 
        ON tc.constraint_name = ccu.constraint_name
        AND tc.table_schema = ccu.table_schema
    LEFT JOIN information_schema.referential_constraints rc
        ON tc.constraint_name = rc.constraint_name
        AND tc.table_schema = rc.constraint_schema
WHERE 
    t.table_schema = 'public'
ORDER BY 
    t.table_name, tc.constraint_type, kcu.column_name;
*/


-- ===========================================
-- ALTERNATIVE: DETAILED COLUMN INFORMATION
-- ===========================================
-- Uncomment below for very detailed column information

/*
SELECT 
    c.table_name,
    c.column_name,
    c.ordinal_position AS position,
    c.data_type,
    c.udt_name AS postgres_type,
    c.character_maximum_length AS max_length,
    c.numeric_precision,
    c.numeric_scale,
    c.datetime_precision,
    c.is_nullable,
    c.column_default,
    c.is_identity,
    c.identity_generation,
    c.is_generated,
    c.generation_expression,
    c.is_updatable,
    pg_catalog.col_description(
        (c.table_schema || '.' || c.table_name)::regclass::oid, 
        c.ordinal_position
    ) AS description
FROM 
    information_schema.columns c
WHERE 
    c.table_schema = 'public'
ORDER BY 
    c.table_name, c.ordinal_position;
*/


-- ===========================================
-- ALTERNATIVE: SIMPLE TABLE AND COLUMN LIST
-- ===========================================
-- Uncomment below for a simple overview

/*
SELECT 
    table_name,
    string_agg(
        column_name || ' (' || data_type || ')', 
        ', ' 
        ORDER BY ordinal_position
    ) AS columns
FROM 
    information_schema.columns
WHERE 
    table_schema = 'public'
GROUP BY 
    table_name
ORDER BY 
    table_name;
*/
