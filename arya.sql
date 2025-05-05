-- Membuat database bernama (KodeSoal)(NRP)_(KodeAsisten)
-- Ganti B036_DIM dengan nama sesuai format, misalnya B001_1234567_LEEN
CREATE DATABASE `B036_DIM`;

-- Menggunakan database yang baru dibuat
USE `B036_DIM`;

-- Membuat tabel sesuai ERD: User, Profile, Interest, Matches, Message, Subscription
-- Tabel USER untuk informasi dasar pengguna
CREATE TABLE `USER` (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL
);

-- Tabel PROFILE untuk detail profil pengguna
-- Gender dibatasi MALE atau FEMALE menggunakan ENUM
CREATE TABLE `PROFILE` (
    Profile_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender ENUM('MALE', 'FEMALE') NOT NULL,
    Birthdate DATE NOT NULL,
    Bio_Desc TEXT,
    Profile_Picture VARCHAR(50),
    Join_Date DATE NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES `USER`(User_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel INTEREST untuk minat pengguna
CREATE TABLE `INTEREST` (
    Interest_ID INT AUTO_INCREMENT PRIMARY KEY,
    Profile_ID INT NOT NULL,
    Interest_Name VARCHAR(100) NOT NULL,
    FOREIGN KEY (Profile_ID) REFERENCES `PROFILE`(Profile_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel MATCHES untuk kecocokan berdasarkan minat
CREATE TABLE `MATCHES` (
    Match_ID INT AUTO_INCREMENT PRIMARY KEY,
    Interest_ID INT NOT NULL,
    Match_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (Interest_ID) REFERENCES `INTEREST`(Interest_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel MESSAGE untuk pesan antar pengguna
CREATE TABLE `MESSAGE` (
    Message_ID INT AUTO_INCREMENT PRIMARY KEY,
    Match_ID INT NOT NULL,
    Message_Text TEXT NOT NULL,
    CONSTRAINT MESSAGE_ibfk_1 FOREIGN KEY (Match_ID) REFERENCES `MATCHES`(Match_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel SUBSCRIPTION untuk langganan pengguna
-- Plan_Name dibatasi FREE, PLUS, atau VIP menggunakan ENUM
CREATE TABLE `SUBSCRIPTION` (
    Subscription_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Plan_Name ENUM('FREE', 'PLUS', 'VIP') NOT NULL,
    Start_Date DATE NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES `USER`(User_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Point 4: Menampilkan data profil dengan format tanggal dd-mm-yyyy
-- Catatan: Tidak ada data karena belum diinsert, menghasilkan empty set
SELECT 
    First_Name, 
    Last_Name, 
    DATE_FORMAT(Birthdate, '%d-%m-%Y') AS Birthdate,
    DATE_FORMAT(Join_Date, '%d-%m-%Y') AS Join_Date
FROM `PROFILE`;

-- Menambahkan kolom Phone_Number pada tabel USER
ALTER TABLE `USER`
ADD Phone_Number VARCHAR(20);

-- Mengganti nama kolom Bio_Desc menjadi Profile_Bio pada tabel PROFILE
ALTER TABLE `PROFILE`
CHANGE Bio_Desc Profile_Bio TEXT;

-- Menghapus kolom Profile_Picture karena server penuh
ALTER TABLE `PROFILE`
DROP COLUMN Profile_Picture;

-- Mengganti nama tabel SUBSCRIPTION menjadi MEMBERSHIP
RENAME TABLE `SUBSCRIPTION` TO `MEMBERSHIP`;

-- Memasukkan data pengguna (Data Manusia Hopeless Romantic)
INSERT INTO `USER` (Email, Username, Password, Phone_Number) VALUES
('bananini@love.com', 'Chimpanzini Bananini', '123tower2', '08116765674'),
('assassino@cool.com', 'Capuccino Assassino', '1nya23nya5', '08116765675'),
('patapim@brr.com', 'Brr Patapim', 'warungkaneenak', '08116765676'),
('iamcamego@free.com', 'Frigo Camelo', 'duatambahdua', '08116765677'),
('trullyuno@ina.com', 'Trulimero Trulicina', 'masalupa', '08116765678'),
('ballerina@blink.com', 'Ballerina Cappucina', 'titikkoma', '08116765679');

INSERT INTO `PROFILE` (User_ID, First_Name, Last_Name, Gender, Birthdate, Profile_Bio, Join_Date) VALUES
(1, 'Chimpanzini', 'Bananini', 'FEMALE', '2004-02-01', 'Landasan pacu sore-sore ngabuburit', '2025-07-06'),
(2, 'Capuccino', 'Assassino', 'MALE', '2005-11-22', 'Kamu belum follow aja, aku udah follow back', '2003-01-02'),
(3, 'Brr', 'Patapim', 'MALE', '2004-07-07', 'Jika kamu adalah bunga, maka aku adalah sang lebah yang senantiasa membuatmu indah.', '2025-10-03'),
(4, 'Frigo', 'Camelo', 'FEMALE', '2005-03-18', 'Do you like raisins? How do you feel about a date?', '2010-06-17'),
(5, 'Trulimero', 'Trulicina', 'FEMALE', '2003-09-24', 'Kenapa jarum ujungnya lancip? Karena kalau ujungnya cuma temen itu ya kita', '2025-05-25'),
(6, 'Ballerina', 'Cappucina', 'MALE', '2005-01-05', 'ikan gule bumbu rica-rica, ailofyuful buat yang baca', '2025-09-08');

-- Menambahkan data contoh ke INTEREST dan MATCHES untuk kelengkapan
INSERT INTO `INTEREST` (Profile_ID, Interest_Name) VALUES
(1, 'Hiking'),
(1, 'Cooking'),
(2, 'Yoga'),
(2, 'Photography'),
(3, 'Traveling'),
(3, 'Coffee');

INSERT INTO `MATCHES` (Interest_ID) VALUES
(1),
(2),
(3);

INSERT INTO `MESSAGE` (Match_ID, Message_Text) VALUES
(1, 'dua tiga anak itik, hi cantik'),
(1, 'Selamat sore tuan putri'),
(2, 'Hi, aku kok ngerasa ga asing ya sama kamu? Kamu ibu dari anak-anakku ga sih?'),
(3, 'Apa bedanya aku sama kamu? Kamu suka apel, kalau aku sukanya kamu');

-- Menghapus kolom Interest_ID dari tabel MATCHES dan tabel INTEREST
ALTER TABLE `MATCHES`
DROP FOREIGN KEY `MATCHES_ibfk_1`;

ALTER TABLE `MATCHES`
DROP COLUMN Interest_ID;

-- Memverifikasi kolom yang tersisa di tabel MATCHES
SHOW COLUMNS FROM `MATCHES`;

DROP TABLE `INTEREST`;

-- Memverifikasi tabel yang tersisa
SHOW TABLES;

-- Mengubah password user Brr Patapim menjadi boomsyakalaka
UPDATE `USER`
SET Password = 'boomsyakalaka'
WHERE Username = 'Brr Patapim';

-- Menampilkan semua data USER untuk memverifikasi perubahan
SELECT * FROM `USER`;

-- Menghapus user dengan email assassino@cool.com
DELETE FROM `USER`
WHERE Email = 'assassino@cool.com';

-- Menampilkan semua data USER untuk memverifikasi penghapusan
SELECT * FROM `USER`;

-- Menampilkan semua user yang join di bulan April 2025
SELECT 
    u.User_ID, 
    u.Email, 
    u.Username, 
    DATE_FORMAT(p.Join_Date, '%d-%m-%Y') AS Join_Date
FROM `USER` u
JOIN `PROFILE` p ON u.User_ID = p.User_ID
WHERE p.Join_Date BETWEEN '2025-04-01' AND '2025-04-30';

-- Menampilkan First dan Last Name serta Birthdate dari user dengan Gender FEMALE
SELECT 
    p.First_Name, 
    p.Last_Name, 
    DATE_FORMAT(p.Birthdate, '%d-%m-%Y') AS Birthdate
FROM `PROFILE` p
WHERE p.Gender = 'FEMALE';

-- Menampilkan semua nama user dengan Gender laki-laki
SELECT 
    p.First_Name, 
    p.Last_Name
FROM `PROFILE` p
WHERE p.Gender = 'MALE';

-- Menampilkan nama-nama user yang bergabung kurang dari 1 tahun sebelum 25-12-2025
SELECT 
    p.First_Name, 
    p.Last_Name
FROM `PROFILE` p
WHERE p.Join_Date > '2024-12-25';

-- Menampilkan nama-nama user yang lahir di tahun 2005 (untuk Wutwutwut Bananini)
SELECT 
    p.First_Name, 
    p.Last_Name
FROM `PROFILE` p
WHERE YEAR(p.Birthdate) = 2005;

-- Menghapus semua isi tabel MESSAGE dan MATCHES tanpa menghapus strukturnya
DELETE FROM `MATCHES`;

-- Tambahan: Menampilkan Start_Date dari MEMBERSHIP dengan format dd-mm-yyyy
SELECT 
    Subscription_ID, 
    User_ID, 
    Plan_Name, 
    DATE_FORMAT(Start_Date, '%d-%m-%Y') AS Start_Date
FROM `MEMBERSHIP`;

-- Tambahan: Menampilkan Match_Time dari MATCHES dengan format dd-mm-yyyy
SELECT 
    Match_ID, 
    DATE_FORMAT(Match_Time, '%d-%m-%Y') AS Match_Time
FROM `MATCHES`;