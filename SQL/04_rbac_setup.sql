-- RBAC Setup for Logistics Company
-- This script creates roles for different departments in the logistics company to manage access control.
CREATE ROLE operations_team;
CREATE ROLE fleet_team;
CREATE ROLE finance_team;
CREATE ROLE warehouse_team;

-- Assign Users to Roles
-- Now each user belongs to only one department.
GRANT operations_team TO operations_user;
GRANT fleet_team TO fleet_user;
GRANT finance_team TO finance_user;
GRANT warehouse_team TO warehouse_user;

-- Connecting each role to the database
GRANT CONNECT ON DATABASE swiftride_logistics_db TO operations_team;
GRANT CONNECT ON DATABASE swiftride_logistics_db TO fleet_team;
GRANT CONNECT ON DATABASE swiftride_logistics_db TO finance_team;
GRANT CONNECT ON DATABASE swiftride_logistics_db TO warehouse_team;

-- Schema Access Grant 
-- USAGE means the user can enter or reference that schema.
GRANT USAGE ON SCHEMA operations TO operations_team;
GRANT USAGE ON SCHEMA fleet TO fleet_team;
GRANT USAGE ON SCHEMA finance TO finance_team;
GRANT USAGE ON SCHEMA warehouse TO warehouse_team;

-- Grant Table Access
GRANT SELECT ON ALL TABLES IN SCHEMA operations TO operations_team;
GRANT SELECT ON ALL TABLES IN SCHEMA fleet TO fleet_team;
GRANT SELECT ON ALL TABLES IN SCHEMA finance TO finance_team;
GRANT SELECT ON ALL TABLES IN SCHEMA warehouse TO warehouse_team;

-- All the above only grants read/view access 
-- give each department read/write access to its own tables:
GRANT INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA operations 
TO operations_team;

GRANT INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA fleet 
TO fleet_team;

GRANT INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA finance 
TO finance_team;

GRANT INSERT, UPDATE, DELETE 
ON ALL TABLES IN SCHEMA warehouse 
TO warehouse_team;
