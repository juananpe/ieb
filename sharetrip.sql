-- Erabiltzaileak taula (oinarrizko taula)
CREATE TABLE erabiltzaileak (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    izena TEXT NOT NULL,
    abizena TEXT NOT NULL,
    telefonoa TEXT,
    pasahitza TEXT NOT NULL,
    erabiltzaile_mota TEXT NOT NULL CHECK (erabiltzaile_mota IN ('GIDARIA', 'BIDAIARIA')),
    sortze_data DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Gidariak taula (erabiltzaile espezifikoa)
CREATE TABLE gidariak (
    id INTEGER PRIMARY KEY,
    gida_baimena TEXT NOT NULL,
    FOREIGN KEY (id) REFERENCES erabiltzaileak(id) ON DELETE CASCADE
);

-- Hiriak taula
CREATE TABLE hiriak (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    izena TEXT NOT NULL,
    probintzia TEXT NOT NULL,
    UNIQUE(izena, probintzia)
);

-- Bidaiak taula
CREATE TABLE bidaiak (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    gidari_id INTEGER NOT NULL,
    jatorri_id INTEGER NOT NULL,
    helmuga_id INTEGER NOT NULL,
    data DATETIME NOT NULL,
    irteera_ordua TIME NOT NULL,
    helmuga_ordua TIME,
    plaza_kopurua INTEGER NOT NULL,
    prezioa DECIMAL(10,2) NOT NULL,
    oharrak TEXT,
    sortze_data DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (gidari_id) REFERENCES gidariak(id),
    FOREIGN KEY (jatorri_id) REFERENCES hiriak(id),
    FOREIGN KEY (helmuga_id) REFERENCES hiriak(id)
);

-- Erreserbak taula
CREATE TABLE erreserbak (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    bidaia_id INTEGER NOT NULL,
    bidaiari_id INTEGER NOT NULL,
    plaza_kopurua INTEGER NOT NULL,
    egoera TEXT NOT NULL CHECK (egoera IN ('ESKATUTA', 'ONARTUTA', 'UKATUTA')),
    eskaera_data DATETIME DEFAULT CURRENT_TIMESTAMP,
    erantzun_data DATETIME,
    FOREIGN KEY (bidaia_id) REFERENCES bidaiak(id),
    FOREIGN KEY (bidaiari_id) REFERENCES erabiltzaileak(id)
);

-- Mezuak taula
CREATE TABLE mezuak (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    igorle_id INTEGER NOT NULL,
    hartzaile_id INTEGER NOT NULL,
    gaia TEXT NOT NULL,
    edukia TEXT NOT NULL,
    bidali_data DATETIME DEFAULT CURRENT_TIMESTAMP,
    irakurrita BOOLEAN DEFAULT 0,
    FOREIGN KEY (igorle_id) REFERENCES erabiltzaileak(id),
    FOREIGN KEY (hartzaile_id) REFERENCES erabiltzaileak(id)
);

-- Alertak taula
CREATE TABLE alertak (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    bidaiari_id INTEGER NOT NULL,
    jatorri_id INTEGER NOT NULL,
    helmuga_id INTEGER NOT NULL,
    bidaia_data DATE NOT NULL,
    plaza_kopurua INTEGER NOT NULL,
    aktiboa BOOLEAN DEFAULT 1,
    sortze_data DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bidaiari_id) REFERENCES erabiltzaileak(id),
    FOREIGN KEY (jatorri_id) REFERENCES hiriak(id),
    FOREIGN KEY (helmuga_id) REFERENCES hiriak(id)
);

-- Indizeak errendimenduarako
CREATE INDEX idx_bidaiak_data ON bidaiak(data);
CREATE INDEX idx_erreserbak_bidaia ON erreserbak(bidaia_id);
CREATE INDEX idx_mezuak_hartzailea ON mezuak(hartzaile_id);
CREATE INDEX idx_alertak_bidaiari ON alertak(bidaiari_id);