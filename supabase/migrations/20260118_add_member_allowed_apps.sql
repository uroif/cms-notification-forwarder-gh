-- Add member_allowed_apps column to user_settings table
-- This column stores the list of apps that members are allowed to view in debit_amount page
-- NULL or empty array means members can view all apps

ALTER TABLE user_settings
ADD COLUMN IF NOT EXISTS member_allowed_apps text[] DEFAULT NULL;

COMMENT ON COLUMN user_settings.member_allowed_apps IS 'Array of app names that members are allowed to view in debit amount list. NULL/empty = show all apps';
