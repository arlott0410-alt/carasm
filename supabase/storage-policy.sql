-- Create public bucket for car photos
INSERT INTO storage.buckets (id, name, public)
VALUES ('car-images', 'car-images', true)
ON CONFLICT (id) DO NOTHING;

-- Allow public read
DROP POLICY IF EXISTS "car_images_public_select" ON storage.objects;
CREATE POLICY "car_images_public_select"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'car-images');

-- Allow authenticated uploads
DROP POLICY IF EXISTS "car_images_auth_insert" ON storage.objects;
CREATE POLICY "car_images_auth_insert"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'car-images');

-- Allow authenticated updates
DROP POLICY IF EXISTS "car_images_auth_update" ON storage.objects;
CREATE POLICY "car_images_auth_update"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'car-images')
WITH CHECK (bucket_id = 'car-images');

-- Allow authenticated deletes
DROP POLICY IF EXISTS "car_images_auth_delete" ON storage.objects;
CREATE POLICY "car_images_auth_delete"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'car-images');
