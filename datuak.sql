-- Hiriak txertatu
INSERT INTO hiriak (izena, probintzia) VALUES
('Donostia', 'Gipuzkoa'),
('Bilbo', 'Bizkaia'),
('Gasteiz', 'Araba'),
('Iruña', 'Nafarroa'),
('Baiona', 'Lapurdi'),
('Eibar', 'Gipuzkoa'),
('Durango', 'Bizkaia'),
('Zarautz', 'Gipuzkoa');

-- Erabiltzaileak txertatu (GIDARI eta BIDAIARI nahasian)
INSERT INTO erabiltzaileak (email, izena, abizena, telefonoa, pasahitza, erabiltzaile_mota) VALUES
('mikel@email.com', 'Mikel', 'Agirre', '666111222', 'pass123', 'GIDARIA'),
('ane@email.com', 'Ane', 'Etxeberria', '666333444', 'pass123', 'GIDARIA'),
('jon@email.com', 'Jon', 'Lopez', '666555666', 'pass123', 'GIDARIA'),
('miren@email.com', 'Miren', 'Gonzalez', '666777888', 'pass123', 'BIDAIARIA'),
('peru@email.com', 'Peru', 'Martinez', '666999000', 'pass123', 'BIDAIARIA'),
('amaia@email.com', 'Amaia', 'Urrutia', '666111333', 'pass123', 'BIDAIARIA'),
('iker@email.com', 'Iker', 'Zubeldia', '666222444', 'pass123', 'BIDAIARIA'),
('leire@email.com', 'Leire', 'Alkorta', '666333555', 'pass123', 'GIDARIA');

-- Gidariak txertatu
INSERT INTO gidariak (id, gida_baimena) 
SELECT id, 'B-' || CAST(ABS(RANDOM()) % 100000 AS TEXT)
FROM erabiltzaileak 
WHERE erabiltzaile_mota = 'GIDARIA';

-- Bidaiak txertatu
INSERT INTO bidaiak (gidari_id, jatorri_id, helmuga_id, data, irteera_ordua, helmuga_ordua, plaza_kopurua, prezioa, oharrak) 
SELECT 
    g.id,
    h1.id,
    h2.id,
    date('now', '+' || CAST(ABS(RANDOM()) % 30 AS TEXT) || ' days'),
    time('08:00:00', '+' || CAST(ABS(RANDOM()) % 720 AS TEXT) || ' minutes'),
    time('09:00:00', '+' || CAST(ABS(RANDOM()) % 720 AS TEXT) || ' minutes'),
    2 + (ABS(RANDOM()) % 3),
    5.00 + (ABS(RANDOM()) % 20),
    'Bidaia normala'
FROM gidariak g
CROSS JOIN hiriak h1
CROSS JOIN hiriak h2
WHERE h1.id != h2.id
LIMIT 20;

-- Erreserbak txertatu
INSERT INTO erreserbak (bidaia_id, bidaiari_id, plaza_kopurua, egoera)
SELECT 
    b.id,
    e.id,
    1 + (ABS(RANDOM()) % 2),
    CASE (ABS(RANDOM()) % 3)
        WHEN 0 THEN 'ESKATUTA'
        WHEN 1 THEN 'ONARTUTA'
        ELSE 'UKATUTA'
    END
FROM bidaiak b
CROSS JOIN erabiltzaileak e
WHERE e.erabiltzaile_mota = 'BIDAIARIA'
LIMIT 15;

-- Mezuak txertatu
INSERT INTO mezuak (igorle_id, hartzaile_id, gaia, edukia)
SELECT 
    e1.id,
    e2.id,
    'Bidaiaren inguruan',
    'Kaixo, bidaiaren inguruko informazio gehiago nahi nuke.'
FROM erabiltzaileak e1
CROSS JOIN erabiltzaileak e2
WHERE e1.id != e2.id
LIMIT 10;

-- Alertak txertatu
INSERT INTO alertak (bidaiari_id, jatorri_id, helmuga_id, bidaia_data, plaza_kopurua)
SELECT 
    e.id,
    h1.id,
    h2.id,
    date('now', '+' || CAST(ABS(RANDOM()) % 30 AS TEXT) || ' days'),
    1 + (ABS(RANDOM()) % 2)
FROM erabiltzaileak e
CROSS JOIN hiriak h1
CROSS JOIN hiriak h2
WHERE e.erabiltzaile_mota = 'BIDAIARIA'
AND h1.id != h2.id
LIMIT 8;