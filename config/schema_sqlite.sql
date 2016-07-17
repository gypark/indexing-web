--
-- File generated with SQLiteStudio v3.1.0 on 토 7 16 00:05:14 2016
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: entry
DROP TABLE IF EXISTS entry;
CREATE TABLE entry ("row" INT (4, 0) PRIMARY KEY, level INT (1, 0), eng_1 TEXT, eng_2 TEXT, eng_3 TEXT, eng_page TEXT, parent_row_id INT (4, 0) REFERENCES entry ("row") ON DELETE SET NULL ON UPDATE CASCADE, is_locked BOOLEAN DEFAULT (0), created_at DATETIME, updated_at DATETIME);

-- Table: entry_page
DROP TABLE IF EXISTS entry_page;
CREATE TABLE entry_page (entry_row_id INT (4, 0) REFERENCES entry ("row") ON DELETE CASCADE ON UPDATE CASCADE, page INT (4, 0), PRIMARY KEY (entry_row_id, page));

-- Table: translation
DROP TABLE IF EXISTS translation;
CREATE TABLE translation (id INTEGER PRIMARY KEY AUTOINCREMENT, entry_row_id INT (4, 0) REFERENCES entry ("row") ON DELETE SET NULL ON UPDATE CASCADE, kor_1 TEXT, kor_2 TEXT, kor_3 TEXT, kor_page TEXT, comment TEXT, user TEXT, created_at DATETIME);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
