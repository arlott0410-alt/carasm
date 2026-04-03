-- Run once on existing projects created before the `currency` column existed.
-- Without this column, the app query can fail and the inventory may look empty.

ALTER TABLE cars
ADD COLUMN IF NOT EXISTS currency TEXT DEFAULT 'LAK';
