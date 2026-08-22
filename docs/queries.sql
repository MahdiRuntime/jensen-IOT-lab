-- 1. Första frågan = Totalt antal mätningar
-- Det räknar alla rader som finns i tabeller, oberoende från vilken sensor mätningen kommer ifrån.
SELECT COUNT(*) FROM measurements;

-- 2. Andra frågan = Medeltemperatur
-- Beräknar genomsnittstemperaturen över alla sparade mätningar.
-- Det räknar genomsnittstemperaturen över alla mätningar som har sparats i tabellen.
SELECT AVG(temperature) FROM measurements;

-- 3. Tredje frågan = Mätningar från de senaste 24 timmarna
-- Detta vissar bara mätningar som har sparats under de senaste 24 timmarna.
SELECT * FROM measurements
WHERE created_at >= NOW() - INTERVAL '24 hours';