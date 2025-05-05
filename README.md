-- Poin 1: Membuat database dengan nama B036_DIM
-- Asumsi: Nama ini sesuai dengan format (KodeSoal)(NRP)_(KodeAsisten)
CREATE DATABASE `B036_DIM`;

-- Menggunakan database yang baru dibuat
USE `B036_DIM`;

-- Poin 2 dan 3: Membuat tabel-tabel sesuai ERD
-- Tabel USER untuk menyimpan informasi dasar pengguna
CREATE TABLE `USER` (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL
);

-- Tabel PROFILE untuk menyimpan detail profil pengguna
-- Gender dibatasi hanya MALE atau FEMALE menggunakan ENUM
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
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel INTEREST untuk menyimpan minat pengguna
CREATE TABLE `INTEREST` (
    Interest_ID INT AUTO_INCREMENT PRIMARY KEY,
    Profile_ID INT NOT NULL,
    Interest_Name VARCHAR(100) NOT NULL,
    FOREIGN KEY (Profile_ID) REFERENCES Profile(Profile_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel MATCHES untuk mencatat kecocokan berdasarkan minat
CREATE TABLE `MATCHES` (
    Match_ID INT AUTO_INCREMENT PRIMARY KEY,
    Interest_ID INT NOT NULL,
    Match_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (Interest_ID) REFERENCES Interest(Interest_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel MESSAGE untuk menyimpan pesan antar pengguna
CREATE TABLE `MESSAGE` (
    Message_ID INT AUTO_INCREMENT PRIMARY KEY,
    Match_ID INT NOT NULL,
    Message_Text TEXT NOT NULL,
    CONSTRAINT MESSAGE_ibfk_1 FOREIGN KEY (Match_ID) REFERENCES Matches(Match_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabel SUBSCRIPTION untuk mencatat langganan pengguna
-- Plan_Name dibatasi hanya FREE, PLUS, atau VIP menggunakan ENUM
CREATE TABLE `SUBSCRIPTION` (
    Subscription_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Plan_Name ENUM('FREE', 'PLUS', 'VIP') NOT NULL,
    Start_Date DATE NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES User(User_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Poin 4: Menampilkan data profil dengan format tanggal dd-mm-yyyy
-- Menggunakan DATE_FORMAT untuk Birthdate dan Join_Date
SELECT 
    First_Name, 
    Last_Name, 
    DATE_FORMAT(Birthdate, '%d-%m-%Y') AS Birthdate,
    DATE_FORMAT(Join_Date, '%d-%m-%Y') AS Join_Date
FROM Profile;

-- Poin 5: Menambahkan kolom Phone_Number ke tabel USER
ALTER TABLE `USER`
ADD Phone_Number VARCHAR(20);

-- Memverifikasi perubahan kolom di tabel USER
SHOW COLUMNS FROM `USER`;

-- Poin 6: Mengganti nama kolom Bio_Desc menjadi Profile_Bio di tabel PROFILE
ALTER TABLE `PROFILE`
CHANGE Bio_Desc Profile_Bio TEXT;

-- Memverifikasi perubahan kolom di tabel PROFILE
SHOW COLUMNS FROM `PROFILE`;

-- Poin 7: Menghapus kolom Profile_Picture dari tabel PROFILE karena server penuh
ALTER TABLE `PROFILE`
DROP COLUMN Profile_Picture;

-- Memverifikasi kolom yang tersisa di tabel PROFILE
SHOW COLUMNS FROM `PROFILE`;

-- Poin 8: Mengganti nama tabel SUBSCRIPTION menjadi MEMBERSHIP
RENAME TABLE `SUBSCRIPTION` TO `MEMBERSHIP`;

-- Menampilkan daftar tabel untuk memverifikasi perubahan nama
SHOW TABLES;

-- Poin 9: Memasukkan data pengguna ke tabel USER
INSERT INTO USER (Email, Username, Password, Phone_Number) VALUES
('bananini@love.com', 'Chimpanzini Bananini', '123tower2', '08116765674'),
('assassino@cool.com', 'Capuccino Assassino', '1nya23nya5', '08116765675'),
('patapim@brr.com', 'Brr Patapim', 'warungkaneenak', '08116765676'),
('iamcamego@free.com', 'Frigo Camelo', 'duatambahdua', '08116765677'),
('trullyuno@ina.com', 'Trulimero Trulicina', 'masalupa', '08116765678'),
('ballerina@blink.com', 'Ballerina Cappucina', 'titikkoma', '08116765679');

-- Memasukkan data profil ke tabel PROFILE
INSERT INTO PROFILE (User_ID, First_Name, Last_Name, Gender, Birthdate, Profile_Bio, Join_Date) VALUES
(1, 'Chimpanzini', 'Bananini', 'Female', '2004-02-01', 'Landasan pacu sore-sore ngabuburit', '2025-07-06'),
(2, 'Capuccino', 'Assassino', 'Male', '2005-11-22', 'Kamu belum follow aja, aku udah follow back', '2003-01-02'),
(3, 'Brr', 'Patapim', 'Male', '2004-07-07', 'Jika kamu adalah bunga, maka aku adalah sang lebah yang senantiasa membuatmu indah.', '2025-10-03'),
(4, 'Frigo', 'Camelo', 'Female', '2005-03-18', 'Do you like raisins? How do you feel about a date?', '2010-06-17'),
(5, 'Trulimero', 'Trulicina', 'Female', '2003-09-24', 'Kenapa jarum ujungnya lancip? Karena kalau ujungnya cuma temen itu ya kita', '2025-05-25'),
(6, 'Ballerina', 'Cappucina', 'Male', '2005-01-05', 'ikan gule bumbu rica-rica, ailofyuful buat yang baca', '2025-09-08');

-- Memasukkan data minat ke tabel INTEREST
INSERT INTO INTEREST (Profile_ID, Interest_Name) VALUES
(1, 'Hiking'),
(1, 'Cooking'),
(2, 'Yoga'),
(2, 'Photography'),
(3, 'Traveling'),
(3, 'Coffee');

-- Memasukkan data kecocokan ke tabel MATCHES
INSERT INTO Matches (Interest_ID) VALUES
(1),
(2),
(3);

-- Memasukkan data pesan ke tabel MESSAGE
INSERT INTO MESSAGE (Match_ID, Message_Text) VALUES
(1, 'dua tiga anak itik, hi cantik'),
(1, 'Selamat sore tuan putri'),
(2, 'Hi, aku kok ngerasa ga asing ya sama kamu? Kamu ibu dari anak-anakku ga sih?'),
(3, 'Apa bedanya aku sama kamu? Kamu suka apel, kalau aku sukanya kamu');

-- Poin 10: Menghapus kolom Interest_ID dari tabel MATCHES dan tabel INTEREST
ALTER TABLE `MATCHES`
DROP COLUMN Interest_ID;

-- Memverifikasi kolom yang tersisa di tabel MATCHES
SHOW COLUMNS FROM `MATCHES`;

-- Menghapus tabel INTEREST karena terlalu banyak pengguna sok asik
DROP TABLE Interest;

-- Memverifikasi tabel yang tersisa
SHOW TABLES;

-- Poin 11: Mengubah kata sandi pengguna Brr Patapim menjadi boomsyakalaka
UPDATE USER
SET Password = 'boomsyakalaka'
WHERE Username = 'Brr Patapim';

-- Menampilkan semua data USER untuk memverifikasi perubahan
SELECT * FROM `USER`;

-- Poin 12: Menghapus pengguna dengan email assassino@cool.com
DELETE FROM USER
WHERE Email = 'assassino@cool.com';

-- Menampilkan semua data USER untuk memverifikasi penghapusan
SELECT * FROM `USER`;

-- Poin 13: Menampilkan pengguna yang bergabung pada April 2025
-- Menggunakan DATE_FORMAT untuk Join_Date agar sesuai format dd-mm-yyyy
SELECT 
    u.User_ID, 
    u.Email, 
    u.Username, 
    DATE_FORMAT(p.Join_Date, '%d-%m-%Y') AS Join_Date
FROM User u
JOIN Profile p ON u.User_ID = p.User_ID
WHERE p.Join_Date BETWEEN '2025-04-01' AND '2025-04-30';

-- Poin 14: Menampilkan nama dan tanggal lahir pengguna wanita
-- Menggunakan DATE_FORMAT untuk Birthdate agar sesuai format dd-mm-yyyy
SELECT 
    p.First_Name, 
    p.Last_Name, 
    DATE_FORMAT(p.Birthdate, '%d-%m-%Y') AS Birthdate
FROM Profile p
WHERE p.Gender = 'FEMALE';

-- Poin 15: Menampilkan nama pengguna pria
SELECT 
    p.First_Name, 
    p.Last_Name
FROM Profile p
WHERE p.Gender = 'MALE';

-- Poin 16: Menampilkan nama pengguna yang bergabung setelah 25-12-2024
-- Artinya kurang dari 1 tahun sebelum 25-12-2025
SELECT 
    p.First_Name, 
    p.Last_Name
FROM Profile p
WHERE p.Join_Date > '2024-12-25';

-- Poin 17: Menampilkan nama pengguna yang lahir pada tahun 2005
-- Berdasarkan kelahiran Wutwutwut Bananini (06-07-2005)
SELECT 
    First_Name, 
    Last_Name
FROM Profile
WHERE YEAR(Birthdate) = 2005;

-- Poin 18: Menghapus semua isi tabel MESSAGE dan MATCHES tanpa menghapus strukturnya
-- Menggunakan DELETE dengan ON DELETE CASCADE
DELETE FROM MATCHES;

-- Poin 19: Menampilkan nama pengguna yang lahir pada tahun 2005 sebagai calon pasangan Wutwutwut Bananini
-- Wutwutwut Bananini lahir 06-07-2005 dan prefer berpasangan dengan yang lahir di tahun sama
SELECT 
    First_Name, 
    Last_Name
FROM Profile
WHERE YEAR(Birthdate) = 2005;

-- Tambahan: Menampilkan Start_Date dari tabel MEMBERSHIP dengan format dd-mm-yyyy
-- Untuk memenuhi syarat format tanggal pada semua atribut tanggal
SELECT 
    Subscription_ID, 
    User_ID, 
    Plan_Name, 
    DATE_FORMAT(Start_Date, '%d-%m-%Y') AS Start_Date
FROM MEMBERSHIP;

-- Tambahan: Menampilkan Match_Time dari tabel MATCHES dengan format dd-mm-yyyy
-- Untuk memenuhi syarat format tanggal (meskipun tabel kosong setelah DELETE)
SELECT 
    Match_ID, 
    DATE_FORMAT(Match_Time, '%d-%m-%Y') AS Match_Time
FROM MATCHES;
