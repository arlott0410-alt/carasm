-- Remove unused car detail columns (run in Supabase SQL editor before/after deploying the updated app).
ALTER TABLE cars DROP COLUMN IF EXISTS model;
ALTER TABLE cars DROP COLUMN IF EXISTS mileage;
ALTER TABLE cars DROP COLUMN IF EXISTS color;
