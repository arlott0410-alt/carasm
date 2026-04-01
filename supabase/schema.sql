-- Core tables
CREATE TABLE IF NOT EXISTS cars (
  id            BIGSERIAL PRIMARY KEY,
  brand         TEXT NOT NULL,
  model         TEXT NOT NULL,
  year          INTEGER NOT NULL,
  mileage       INTEGER DEFAULT 0,
  transmission  TEXT DEFAULT 'Auto',
  color         TEXT,
  price         BIGINT NOT NULL,
  currency      TEXT DEFAULT 'LAK'
                CHECK (currency IN ('LAK','THB','USD')),
  status        TEXT DEFAULT 'available'
                CHECK (status IN ('available','reserved','sold')),
  desc_lo       TEXT,
  desc_en       TEXT,
  photos        TEXT[] DEFAULT '{}',
  created_at    TIMESTAMPTZ DEFAULT NOW(),
  updated_at    TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS settings (
  key        TEXT PRIMARY KEY,
  value      TEXT NOT NULL DEFAULT '',
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Keep updated_at fresh
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS cars_set_updated_at ON cars;
CREATE TRIGGER cars_set_updated_at
BEFORE UPDATE ON cars
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

DROP TRIGGER IF EXISTS settings_set_updated_at ON settings;
CREATE TRIGGER settings_set_updated_at
BEFORE UPDATE ON settings
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Default settings values
INSERT INTO settings (key, value) VALUES
  ('shop_name', 'ASM ອາມສັ່ງມາ'),
  ('tagline_lo', 'ລົດມືສອງຄຸນນະພາບ ວຽງຈັນ'),
  ('tagline_en', 'Quality used cars in Vientiane with transparent prices.'),
  ('wa_number', '85695043892'),
  ('phone', '+856 95 043 892'),
  ('location_lo', 'ນະຄອນຫຼວງວຽງຈັນ, ລາວ'),
  ('location_en', 'Vientiane Capital, Laos'),
  ('facebook_url', ''),
  ('hours_lo', 'ຈັນ-ອາທິດ 08:00-18:00'),
  ('hours_en', 'Mon-Sun 08:00-18:00')
ON CONFLICT (key) DO NOTHING;

-- RLS
ALTER TABLE cars ENABLE ROW LEVEL SECURITY;
ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "cars_select_public" ON cars;
CREATE POLICY "cars_select_public"
ON cars FOR SELECT
TO public
USING (true);

DROP POLICY IF EXISTS "cars_insert_auth" ON cars;
CREATE POLICY "cars_insert_auth"
ON cars FOR INSERT
TO authenticated
WITH CHECK (true);

DROP POLICY IF EXISTS "cars_update_auth" ON cars;
CREATE POLICY "cars_update_auth"
ON cars FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

DROP POLICY IF EXISTS "cars_delete_auth" ON cars;
CREATE POLICY "cars_delete_auth"
ON cars FOR DELETE
TO authenticated
USING (true);

DROP POLICY IF EXISTS "settings_select_public" ON settings;
CREATE POLICY "settings_select_public"
ON settings FOR SELECT
TO public
USING (true);

DROP POLICY IF EXISTS "settings_all_auth" ON settings;
CREATE POLICY "settings_all_auth"
ON settings FOR ALL
TO authenticated
USING (true)
WITH CHECK (true);
