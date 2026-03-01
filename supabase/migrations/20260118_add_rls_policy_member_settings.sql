-- Create RLS policy to allow all authenticated users to read member_allowed_apps from admin's settings
-- This allows members to know which apps they can view

-- Drop existing policy if exists
DROP POLICY IF EXISTS "Allow all authenticated users to read admin member_allowed_apps" ON user_settings;

-- Create policy to allow reading member_allowed_apps from admin user
CREATE POLICY "Allow all authenticated users to read admin member_allowed_apps"
ON user_settings
FOR SELECT
TO authenticated
USING (
  -- Allow reading user_settings where the user is an admin
  user_id IN (
    SELECT user_id 
    FROM user_roles 
    WHERE role = 'admin'
  )
);

-- Also make sure RLS is enabled on user_settings
ALTER TABLE user_settings ENABLE ROW LEVEL SECURITY;
