-- Membuat database untuk mengelola fenomena anomali absurd di Yayasan Pelestari Anomali Absurd (YPAA)
CREATE DATABASE IF NOT EXISTS `036_DIM_AnomaliUniverse`;
USE `036_DIM_AnomaliUniverse`;

-- **Struktur Database**
-- Membuat tabel-tabel untuk menyimpan data entitas anomali, kreator, konten, tag, dan interaksi.
-- Tabel menggunakan primary key, foreign key, dan tipe data yang sesuai untuk menjaga integritas data.

-- Tabel EntitasAnomali: Menyimpan informasi entitas anomali seperti nama, tipe, dan tingkat absurditas
CREATE TABLE EntitasAnomali (
    ID_Entitas INT PRIMARY KEY AUTO_INCREMENT,
    Nama_Entitas VARCHAR(100),
    Tipe_Entitas VARCHAR(50),
    Tingkat_Absurditas INT,
    Tanggal_Terdeteksi DATE,
    Sumber_Origin VARCHAR(255)
);

-- Tabel KreatorKontenAnomali: Menyimpan data kreator konten, termasuk username dan reputasi brainrot
CREATE TABLE KreatorKontenAnomali (
    ID_Kreator INT PRIMARY KEY AUTO_INCREMENT,
    Username_Kreator VARCHAR(100),
    Platform_Utama VARCHAR(50),
    Jumlah_Followers BIGINT,
    Reputasi_Brainrot VARCHAR(50)
);

-- Tabel KontenAnomali: Menyimpan detail konten seperti judul, views, dan potensi tripping, dengan foreign key ke EntitasAnomali dan KreatorKontenAnomali
CREATE TABLE KontenAnomali (
    ID_Konten INT PRIMARY KEY AUTO_INCREMENT,
    ID_Entitas INT,
    ID_Kreator INT,
    Judul_Konten VARCHAR(255),
    URL_Konten VARCHAR(255),
    Tipe_Media VARCHAR(50),
    Durasi_Detik INT NULL,
    Views BIGINT,
    Likes BIGINT,
    Shares BIGINT,
    Potensi_Tripping VARCHAR(50),
    Tanggal_Unggah DATE,
    FOREIGN KEY (ID_Entitas) REFERENCES EntitasAnomali(ID_Entitas),
    FOREIGN KEY (ID_Kreator) REFERENCES KreatorKontenAnomali(ID_Kreator)
);

-- Tabel TagAnomali: Menyimpan tag seperti 'TrippiTroppa' atau 'NPCVibes' untuk mengkategorikan konten
CREATE TABLE TagAnomali (
    ID_Tag INT PRIMARY KEY AUTO_INCREMENT,
    Nama_Tag VARCHAR(100)
);

-- Tabel KontenTag: Menyimpan relasi banyak-ke-banyak antara konten dan tag
CREATE TABLE KontenTag (
    ID_Konten INT,
    ID_Tag INT,
    PRIMARY KEY (ID_Konten, ID_Tag),
    FOREIGN KEY (ID_Konten) REFERENCES KontenAnomali(ID_Konten),
    FOREIGN KEY (ID_Tag) REFERENCES TagAnomali(ID_Tag)
);

-- Tabel LogInteraksiBrainrot: Mencatat interaksi penonton dengan konten, seperti durasi nonton dan efek yang dirasakan
CREATE TABLE LogInteraksiBrainrot (
    ID_Log INT AUTO_INCREMENT PRIMARY KEY,
    ID_Konten INT,
    Username_Penonton VARCHAR(100),
    Durasi_Nonton_Detik INT,
    Efek_Dirasakan TEXT,
    FOREIGN KEY (ID_Konten) REFERENCES KontenAnomali(ID_Konten)
);

-- **Data Awal**
-- Mengisi tabel-tabel dengan data awal yang disediakan oleh soal untuk simulasi pengelolaan anomali.
-- Data mencakup 6 entitas, 5 kreator, 5 konten, 8 tag, dan relasi konten-tag.

-- EntitasAnomali: 6 entitas anomali seperti 'Trippi Troppa Dancer' dan 'Filter Wajah Menangis Parah'
INSERT INTO EntitasAnomali (Nama_Entitas, Tipe_Entitas, Tingkat_Absurditas, Tanggal_Terdeteksi, Sumber_Origin)
VALUES
('Trippi Troppa Dancer', 'Makhluk Hidup', 8, '2023-11-01', 'Video TikTok India'),
('Bombardini Crocodilo Sound', 'Sound Viral', 9, '2024-01-15', 'Sound effect tak dikenal'),
('Tralalelo Tralala Song', 'Sound Viral', 7, '2023-09-10', 'Lagu anak-anak yang di-remix jadi aneh'),
('Capybara Hydrochaeris', 'Makhluk Hidup', 6, '2022-05-20', 'Berbagai meme capybara masbro'),
('Filter Wajah Menangis Parah', 'Fenomena Abstrak', 7, '2023-06-01', 'Filter Instagram/TikTok'),
('NPC Live Streamer', 'Makhluk Hidup', 9, '2023-08-15', 'Tren live streaming TikTok bertingkah seperti NPC');

-- KreatorKontenAnomali: 5 kreator seperti 'RajaTrippi69' dan 'LiveNPCMaster'
INSERT INTO KreatorKontenAnomali (Username_Kreator, Platform_Utama, Jumlah_Followers, Reputasi_Brainrot)
VALUES
('RajaTrippi69', 'TikTok', 1200000, 'Ahli'),
('DJBombardiniOfficial', 'YouTube', 500000, 'Menengah'),
('TralalaQueen', 'TikTok', 750000, 'Menengah'),
('CapybaraEnjoyer_007', 'Instagram', 250000, 'Pemula'),
('LiveNPCMaster', 'TikTok', 2000000, 'Legenda Anomali');

-- KontenAnomali: 5 konten seperti 'Trippi Troppa Challenge GONE WILD!' dan 'NPC Reacts to Gifts - ICE CREAM SO GOOD'
INSERT INTO KontenAnomali (ID_Entitas, ID_Kreator, Judul_Konten, URL_Konten, Tipe_Media, Durasi_Detik, Views, Likes, Shares, Potensi_Tripping, Tanggal_Unggah)
VALUES
(1, 1, 'Trippi Troppa Challenge GONE WILD!', 'tiktok.com/trippi001', 'Video', 30, 5000000, 300000, 150000, 'Tinggi', '2023-11-02'),
(2, 2, 'BOMBARDINI CROCODILOOO! (10 Hour Loop)', 'youtube.com/bombardini001', 'Audio', 36000, 10000000, 500000, 200000, 'CROCODILO!', '2024-01-16'),
(3, 3, 'Tralalelo Tralala Remix Full Bass Jedag Jedug', 'tiktok.com/tralala001', 'Audio', 60, 2000000, 150000, 70000, 'Sedang', '2023-09-11'),
(4, 4, 'Capybara chilling with orange', 'instagram.com/capy001', 'Gambar', NULL, 1000000, 100000, 40000, 'Rendah', '2022-05-21'),
(5, 5, 'NPC Reacts to Gifts - ICE CREAM SO GOOD', 'tiktok.com/npc001', 'Video', 180, 15000000, 800000, 300000, 'CROCODILO!', '2023-08-16');

-- TagAnomali: 8 tag seperti 'TrippiTroppa' dan 'NPCVibes'
INSERT INTO TagAnomali (Nama_Tag)
VALUES
('TrippiTroppa'),
('Bombardini'),
('Tralalelo'),
('CapybaraCore'),
('NPCVibes'),
('Absurd'),
('BrainrotLevelMax'),
('HumorGelap');

-- KontenTag: Relasi antara konten dan tag, misalnya konten ID 5 terkait dengan tag 'NPCVibes', 'Absurd', dan 'BrainrotLevelMax'
INSERT INTO KontenTag (ID_Konten, ID_Tag)
VALUES
(1, 1), (1, 6), (1, 7),
(2, 2), (2, 6), (2, 7), 
(2, 8), (3, 3), (3, 6),
(4, 4), (4, 6), (5, 5), 
(5, 6), (5, 7);

-- **Stored Procedures dan Functions**
-- Berikut adalah stored procedure dan function untuk mengelola dan menganalisis data anomali.
-- Menggunakan DELIMITER $$ untuk mendefinisikan blok dengan BEGIN...END.

DELIMITER $$

-- Stored Procedure: sp_RegistrasiEntitasBaru
-- Tujuan: Mendaftarkan entitas anomali baru dengan memeriksa duplikasi nama.
-- Input: Nama entitas, tipe, tingkat absurditas, dan sumber asal.
-- Output: Pesan 'SUKSES! Entitas "[nama]" telah ditambahkan.' jika baru, atau 'GAGAL! Entitas "[nama]" sudah terdaftar.' jika sudah ada.
CREATE PROCEDURE sp_RegistrasiEntitasBaru(
    IN p_nama_entitas VARCHAR(100),
    IN p_tipe_entitas VARCHAR(50),
    IN p_tingkat_absurditas INT,
    IN p_sumber_origin VARCHAR(255),
    OUT p_status_registrasi VARCHAR(255)
)
BEGIN
    DECLARE v_exist INT;
    SELECT COUNT(*) INTO v_exist FROM EntitasAnomali WHERE Nama_Entitas = p_nama_entitas;
    IF v_exist > 0 THEN
        SET p_status_registrasi = CONCAT('GAGAL! Entitas "', p_nama_entitas, '" sudah terdaftar.');
    ELSE
        INSERT INTO EntitasAnomali(Nama_Entitas, Tipe_Entitas, Tingkat_Absurditas, Tanggal_Terdeteksi, Sumber_Origin)
        VALUES(p_nama_entitas, p_tipe_entitas, p_tingkat_absurditas, CURDATE(), p_sumber_origin);
        SET p_status_registrasi = CONCAT('SUKSES! Entitas "', p_nama_entitas, '" telah ditambahkan.');
    END IF;
END $$

-- Function: fn_HitungSkorViralitasKonten
-- Tujuan: Menghitung skor viralitas konten berdasarkan rumus: (views / 10000) + (likes * 0.5) + (shares * 1).
-- Bonus poin: 'CROCODILO!' (+100), 'Tinggi' (+50), 'Sedang' (+20).
-- Input: ID_Konten.
-- Output: Skor viralitas (DECIMAL) atau 0 jika konten tidak ditemukan.
CREATE FUNCTION fn_HitungSkorViralitasKonten(p_id_konten INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE v_views BIGINT DEFAULT 0;
    DECLARE v_likes BIGINT DEFAULT 0;
    DECLARE v_shares BIGINT DEFAULT 0;
    DECLARE v_tripping VARCHAR(50);
    DECLARE v_skor DECIMAL(15,2);
    SELECT Views, Likes, Shares, Potensi_Tripping INTO v_views, v_likes, v_shares, v_tripping
    FROM KontenAnomali WHERE ID_Konten = p_id_konten;
    IF v_views IS NULL THEN
        RETURN 0;
    END IF;
    SET v_skor = (v_views / 10000) + (v_likes * 0.5) + (v_shares * 1);
    IF v_tripping = 'CROCODILO!' THEN
        SET v_skor = v_skor + 100;
    ELSEIF v_tripping = 'Tinggi' THEN
        SET v_skor = v_skor + 50;
    ELSEIF v_tripping = 'Sedang' THEN
        SET v_skor = v_skor + 20;
    END IF;
    RETURN v_skor;
END $$

-- Stored Procedure: sp_GetStatistikEntitasPalingPopuler
-- Tujuan: Menemukan entitas dengan total views tertinggi dari semua konten terkait.
-- Output: Nama entitas, total views, dan jumlah konten terkait. Jika tidak ada data, return 'Tidak ada data konten', 0, 0.
-- Berdasarkan data awal, output akan menunjukkan 'Filter Wajah Menangis Parah', 15000000, 1 karena konten ID 5 (views tertinggi) terkait dengan ID_Entitas=5.
CREATE PROCEDURE sp_GetStatistikEntitasPalingPopuler(
    OUT p_nama_entitas_populer VARCHAR(100),
    OUT p_total_views_entitas BIGINT,
    OUT p_jumlah_konten_terkait INT
)
BEGIN
    DECLARE v_id_entitas INT;
    SELECT ID_Entitas, SUM(Views) AS total_views, COUNT(*) AS jumlah_konten
    INTO v_id_entitas, p_total_views_entitas, p_jumlah_konten_terkait
    FROM KontenAnomali
    GROUP BY ID_Entitas
    ORDER BY total_views DESC
    LIMIT 1;
    IF v_id_entitas IS NULL THEN
        SET p_nama_entitas_populer = 'Tidak ada data konten';
        SET p_total_views_entitas = 0;
        SET p_jumlah_konten_terkait = 0;
    ELSE
        SELECT Nama_Entitas INTO p_nama_entitas_populer
        FROM EntitasAnomali
        WHERE ID_Entitas = v_id_entitas;
    END IF;
END $$

-- Stored Procedure: sp_LaporkanKontenBrainrotTeratasBulanan
-- Tujuan: Menampilkan 5 konten teratas berdasarkan skor viralitas untuk tahun dan bulan tertentu.
-- Output: Judul konten, skor viralitas, dan tanggal unggah.
-- Contoh untuk Agustus 2023: Menampilkan 1 konten ('NPC Reacts to Gifts - ICE CREAM SO GOOD', 701600.00, '2023-08-16').
CREATE PROCEDURE sp_LaporkanKontenBrainrotTeratasBulanan(
    IN p_tahun INT,
    IN p_bulan INT
)
BEGIN
    SELECT k.Judul_Konten, fn_HitungSkorViralitasKonten(k.ID_Konten) AS Skor_Viralitas, k.Tanggal_Unggah
    FROM KontenAnomali k
    WHERE YEAR(k.Tanggal_Unggah) = p_tahun AND MONTH(k.Tanggal_Unggah) = p_bulan
    ORDER BY Skor_Viralitas DESC
    LIMIT 5;
END $$

-- Function: fn_KlasifikasiAnomaliOtomatis
-- Tujuan: Mengklasifikasikan konten berdasarkan tag-nya di KontenTag.
-- Aturan: 
-- - Konten tidak ada: 'Konten Tidak Ditemukan'.
-- - Tag 'TrippiTroppa' dan 'NPCVibes': 'Kombinasi Trippi NPC'.
-- - Hanya 'TrippiTroppa': 'Dominan TrippiTroppa'.
-- - Hanya 'NPCVibes': 'Dominan NPCVibes'.
-- - Lebih dari 2 tag (bukan kombinasi di atas): 'Campuran Beragam Anomali'.
-- - Lainnya: 'Anomali Standar'.
-- Contoh: Konten ID 5 memiliki tag 'NPCVibes', 'Absurd', 'BrainrotLevelMax', sehingga diklasifikasikan sebagai 'Dominan NPCVibes'.
CREATE FUNCTION fn_KlasifikasiAnomaliOtomatis(p_id_konten INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_count_tag INT;
    DECLARE v_has_trippi INT;
    DECLARE v_has_npc INT;
    IF NOT EXISTS (SELECT 1 FROM KontenAnomali WHERE ID_Konten = p_id_konten) THEN
        RETURN 'Konten Tidak Ditemukan';
    END IF;
    SELECT COUNT(*) INTO v_count_tag
    FROM KontenTag ct JOIN TagAnomali t ON ct.ID_Tag = t.ID_Tag
    WHERE ct.ID_Konten = p_id_konten;
    SELECT COUNT(*) INTO v_has_trippi
    FROM KontenTag ct JOIN TagAnomali t ON ct.ID_Tag = t.ID_Tag
    WHERE ct.ID_Konten = p_id_konten AND t.Nama_Tag = 'TrippiTroppa';
    SELECT COUNT(*) INTO v_has_npc
    FROM KontenTag ct JOIN TagAnomali t ON ct.ID_Tag = t.ID_Tag
    WHERE ct.ID_Konten = p_id_konten AND t.Nama_Tag = 'NPCVibes';
    IF v_has_trippi > 0 AND v_has_npc > 0 THEN
        RETURN 'Kombinasi Trippi NPC';
    ELSEIF v_has_trippi > 0 AND v_has_npc = 0 THEN
        RETURN 'Dominan TrippiTroppa';
    ELSEIF v_has_npc > 0 AND v_has_trippi = 0 THEN
        RETURN 'Dominan NPCVibes';
    ELSEIF v_count_tag > 2 THEN
        RETURN 'Campuran Beragam Anomali';
    ELSE
        RETURN 'Anomali Standar';
    END IF;
END $$

DELIMITER ;

-- **Pengujian Stored Procedure dan Function**
-- Berikut adalah query untuk menguji semua stored procedure dan function.
-- Setiap query akan menunjukkan output yang sesuai dengan data awal.

-- Uji sp_RegistrasiEntitasBaru
-- Menguji pendaftaran entitas yang sudah ada ('Trippi Troppa Dancer') dan baru ('Meme Baru 2025').
SET @status = '';
CALL sp_RegistrasiEntitasBaru('Trippi Troppa Dancer', 'Makhluk Hidup', 8, 'Video TikTok India', @status);
SELECT @status; -- Output: 'GAGAL! Entitas "Trippi Troppa Dancer" sudah terdaftar.' karena entitas sudah ada di data awal.
CALL sp_RegistrasiEntitasBaru('Meme Baru 2025', 'Fenomena Abstrak', 7, 'Twitter Viral', @status);
SELECT @status; -- Output: 'SUKSES! Entitas "Meme Baru 2025" telah ditambahkan.' karena entitas baru.

-- Uji fn_HitungSkorViralitasKonten
-- Menampilkan skor viralitas untuk semua konten menggunakan rumus (views / 10000) + (likes * 0.5) + (shares * 1) + bonus.
SELECT ID_Konten, Judul_Konten, fn_HitungSkorViralitasKonten(ID_Konten) AS Skor_Viralitas
FROM KontenAnomali;
-- Output contoh:
-- ID 1: 300550.00 ((5000000/10000) + (300000*0.5) + (150000*1) + 50)
-- ID 2: 451100.00 ((10000000/10000) + (500000*0.5) + (200000*1) + 100)
-- ID 5: 701600.00 ((15000000/10000) + (800000*0.5) + (300000*1) + 100)

-- Uji sp_GetStatistikEntitasPalingPopuler
-- Menampilkan entitas dengan total views tertinggi.
SET @nama_entitas = '';
SET @total_views = 0;
SET @jumlah_konten = 0;
CALL sp_GetStatistikEntitasPalingPopuler(@nama_entitas, @total_views, @jumlah_konten);
SELECT @nama_entitas, @total_views, @jumlah_konten;
-- Output: 'Filter Wajah Menangis Parah', 15000000, 1
-- Penjelasan: Konten ID 5 memiliki views tertinggi (15000000) dan terkait dengan ID_Entitas=5 ('Filter Wajah Menangis Parah').

-- Uji sp_LaporkanKontenBrainrotTeratasBulanan
-- Menampilkan konten teratas untuk Agustus 2023 berdasarkan skor viralitas.
CALL sp_LaporkanKontenBrainrotTeratasBulanan(2023, 8);
-- Output: 'NPC Reacts to Gifts - ICE CREAM SO GOOD', 701600.00, '2023-08-16'
-- Penjelasan: Hanya konten ID 5 yang diunggah pada Agustus 2023, dengan skor viralitas 701600.00.

-- Uji fn_KlasifikasiAnomaliOtomatis
-- Mengklasifikasikan konten berdasarkan tag-nya.
SELECT ID_Konten, Judul_Konten, fn_KlasifikasiAnomaliOtomatis(ID_Konten) AS Klasifikasi
FROM KontenAnomali;
-- Output contoh:
-- ID 1: 'Dominan TrippiTroppa' (memiliki tag 'TrippiTroppa', 'Absurd', 'BrainrotLevelMax')
-- ID 2: 'Campuran Beragam Anomali' (memiliki 4 tag: 'Bombardini', 'Absurd', 'BrainrotLevelMax', 'HumorGelap')
-- ID 5: 'Dominan NPCVibes' (memiliki tag 'NPCVibes', 'Absurd', 'BrainrotLevelMax')