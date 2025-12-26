-- ============================================================
-- Native App Setup Script (generic) + Streamlit GUI
-- Runs when the app is installed
-- ============================================================

-- ------------------------------------------------------------
-- 1) Application roles
-- ------------------------------------------------------------
CREATE APPLICATION ROLE IF NOT EXISTS app_admin;
CREATE APPLICATION ROLE IF NOT EXISTS app_user;

-- Optional hierarchy: admin includes user
GRANT APPLICATION ROLE app_user TO APPLICATION ROLE app_admin;

-- ------------------------------------------------------------
-- 2) Schemas (keep whatever you like)
-- ------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS api;
CREATE SCHEMA IF NOT EXISTS data;
CREATE SCHEMA IF NOT EXISTS metadata;
CREATE SCHEMA IF NOT EXISTS ui;

-- ------------------------------------------------------------
-- 3) Basic usage grants
-- ------------------------------------------------------------
GRANT USAGE ON SCHEMA core     TO APPLICATION ROLE app_user;
GRANT USAGE ON SCHEMA api      TO APPLICATION ROLE app_user;
GRANT USAGE ON SCHEMA data     TO APPLICATION ROLE app_user;
GRANT USAGE ON SCHEMA metadata TO APPLICATION ROLE app_admin;
GRANT USAGE ON SCHEMA ui       TO APPLICATION ROLE app_user;

-- ------------------------------------------------------------
-- 4) Streamlit GUI (Native App Framework syntax)
-- IMPORTANT:
--   - Files must be packaged on the app’s stage in a folder like:
--       /code_artifacts/
--   - MAIN_FILE must be inside that folder
--   - environment.yml (optional) must be at the same level as MAIN_FILE
-- ------------------------------------------------------------
CREATE OR REPLACE STREAMLIT ui.app
  FROM '/runnable/streamlit'
  MAIN_FILE = '/streamlit_app.py';

-- Allow consumers to open the Streamlit app in Snowsight
GRANT USAGE ON STREAMLIT ui.app TO APPLICATION ROLE app_user;

-- ============================================================
-- End of setup.sql
-- ============================================================
