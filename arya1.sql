1. Karena sebelumnya tabel Interest dihapus, maka tabel Interest tambahkan kembali dengan atribut-atributnya yaitu Interest_ID (Primary Key), Profile_ID (Foreign Key), dan Interest_Name.
CREATE TABLE `interest` (
  `Interest_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Profile_ID` int(11) NOT NULL,
  `Interest_Name` varchar(100) NOT NULL,
  PRIMARY KEY (`Interest_ID`),
  FOREIGN KEY (`Profile_ID`) REFERENCES `profile`(`Profile_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

2. Pastikan atribut Interest_ID di tabel Match sebagai Foreign Key.
ALTER TABLE `matches`
ADD COLUMN `Interest_ID` int(11);

ALTER TABLE `matches`
ADD CONSTRAINT `matches_ibfk_interest`
FOREIGN KEY (`Interest_ID`) REFERENCES `interest`(`Interest_ID`)
ON DELETE SET NULL ON UPDATE CASCADE;

3. Karena tabel message dan matches sebelumnya di-truncate, maka kolom Match_ID di tabel Message tambah kembali menjadi Foreign Key.
ALTER TABLE `message`
ADD CONSTRAINT `fk_message_match`
FOREIGN KEY (`Match_ID`) REFERENCES `matches`(`Match_ID`)
ON DELETE CASCADE ON UPDATE CASCADE;

4. Tambahkan beberapa data pada database di link berikut ini.
-- Insert ke tabel Membership
INSERT INTO `membership` (`Subscription_ID`, `User_ID`, `Plan_Name`, `Start_Date`) VALUES
(1, 1, 'FREE', '2025-01-15'),
(2, 3, 'VIP', '2024-12-10'),
(3, 4, 'PLUS', '2025-02-20'),
(4, 5, 'VIP', '2025-03-01'),
(5, 6, 'FREE', '2025-04-01');

-- Insert ke tabel Interest
INSERT INTO `interest` (`Interest_ID`, `Profile_ID`, `Interest_Name`) VALUES
(1, 1, 'Hiking'),
(2, 1, 'Cooking'),
(3, 3, 'Traveling'),
(4, 3, 'Coffee');

-- Insert ke tabel Matches
INSERT INTO `matches` (`Match_ID`, `Interest_ID`, `Match_Time`) VALUES
(1, 1, '2025-04-01 19:00:00'),
(2, 2, '2025-04-02 20:30:00'),
(3, 3, '2025-04-05 15:00:00'),
(4, 4, '2025-04-10 12:45:00');

-- Insert ke tabel Message
INSERT INTO `message` (`Message_ID`, `Match_ID`, `Message_Text`) VALUES
(1, 1, 'Hai kamu! Suka es krim juga gak?'),
(2, 1, 'Kamu suka jalan-jalan atau mageran?'),
(3, 2, 'Aku suka sunrise di pantai, kamu gimana?'),
(4, 3, 'Gimana kalau kita ketemu di acara Basket ELITE?'),
(5, 4, 'Senyum kamu tuh kayak wifi, bikin konek mulu.');

------------------------------------------------------------------------
1. Kata orang, bio panjang menunjukkan seseorang yang ekspresif. Tapi kadang, panjangnya bio justru membuat Wutwutwut bingung. Tampilkan seluruh data dari tabel Profile, lalu urutkan berdasarkan panjang karakter dari Profile_Bio secara menurun (dari yang terpanjang ke yang terpendek).
SELECT * 
FROM `profile`
ORDER BY CHAR_LENGTH(`Profile_Bio`) DESC;

2. Orang bilang yang tua itu lebih bijaksana. Jadi Wutwutwut ingin tahu siapa saja user yang paling dulu lahir di aplikasi ini. Tampilkan tiga data  -      teratas dari Profile yang lahir paling awal. Urutkan berdasarkan tanggal lahir dari yang tertua ke termuda.
SELECT * 
FROM `profile`
ORDER BY `Birthdate` ASC
LIMIT 3;

3. Dalam dunia percintaan digital, pesan adalah awal dari semuanya. Tampilkan Match_ID beserta jumlah pesan (Message) yang terkirim pada setiap match lalu kelompokkan berdasarkan Match_ID. Hasil hitungannya beri alias Jumlah_Pesan.
SELECT 
    Match_ID, 
    COUNT(*) AS Jumlah_Pesan
FROM 
    message
GROUP BY 
    Match_ID;

4. Jumlah_Pesan.
Wutwutwut penasaran: seberapa panjang sih rata-rata bio para user di aplikasi ini? Hitung rata-rata panjang karakter dari kolom Profile_Bio. Gunakan alias Rata_Panjang_Bio untuk menamai kolom hasilnya. Pastikan hasilnya berupa angka desimal ya, bukan cinta yang menggantung.
SELECT 
    AVG(CHAR_LENGTH(Profile_Bio)) AS Rata_Panjang_Bio
FROM 
    profile;

5. User VIP itu katanya beda kelas. Mereka butuh perhatian ekstra — apalagi dari database! Tampilkan data dari tabel Membership yang hanya memiliki Plan_Name berisi 'VIP'. Sertakan pula tanggal mulai langganannya. Jangan lupakan user yang royal!
SELECT 
    Subscription_ID, 
    User_ID, 
    Plan_Name, 
    Start_Date
FROM 
    membership
WHERE 
    Plan_Name = 'VIP';

6. Tampilkan seluruh data dari tabel Profile yang bio-nya memuat kata “mabar”, tanpa membedakan huruf kapital ataupun huruf kecil. Biar gak kelewatan pejuang Mobile Legends atau Minecraft lover!
SELECT *
FROM profile
WHERE LOWER(Profile_Bio) LIKE '%mabar%';

7. Kadang cinta datang di waktu yang pas — termasuk waktu langganan plan! Tampilkan seluruh data dari tabel Membership yang memulai langganannya antara 1 Februari 2025 hingga 31 Maret 2025. Urutkan berdasarkan tanggal mulai langganan dari yang paling awal.
SELECT *
FROM membership
WHERE Start_Date BETWEEN '2025-02-01' AND '2025-03-31'
ORDER BY Start_Date ASC;

8. Karena cinta tak memandang gender, kita buatkan label karakteristiknya yuk! Tampilkan First_Name, Gender, dan buat satu kolom baru bernama Label_Karakteristik. Jika Gender bernilai 'MALE', tampilkan 'Kuat tapi rapuh'. Jika 'FEMALE', tampilkan 'Lembut namun tegas'.
SELECT 
    First_Name,
    Gender,
    CASE 
        WHEN Gender = 'MALE' THEN 'Kuat tapi rapuh'
        WHEN Gender = 'FEMALE' THEN 'Lembut namun tegas'
        ELSE 'Tidak ditentukan'
    END AS Label_Karakteristik
FROM 
    profile;

9. Wutwutwut ingin tahu jam berapa user biasanya cocok-mencocokkan hati. Tampilkan Match_ID, Interest_ID, dan jam dari Match_Time (dalam format HH:MM) saja. Gunakan fungsi waktu untuk mengambil bagian jam dan menitnya saja, ya!
SELECT 
    Match_ID,
    Interest_ID,
    TIME_FORMAT(Match_Time, '%H:%i') AS Match_Hour
FROM 
    matches;

10. Cinta itu harus diperjuangkan. Kadang lewat pesan yang nggak berhenti. Tampilkan Match_ID yang memiliki jumlah pesan terbanyak di tabel Message. Hanya tampilkan satu data teratas saja.
SELECT 
    Match_ID,
    COUNT(*) AS Jumlah_Pesan
FROM 
    message
GROUP BY 
    Match_ID
ORDER BY 
    Jumlah_Pesan DESC
LIMIT 1;

11. Aplikasi ini punya berbagai plan, dari FREE sampai VIP. Tapi sebenarnya berapa banyak sih user per plan? Tampilkan jumlah user yang menggunakan masing-masing Plan_Name di tabel Membership.
SELECT 
    Plan_Name,
    COUNT(*) AS Jumlah_User
FROM 
    membership
GROUP BY 
    Plan_Name;

12. Kadang, hanya dari nama saja, bisa tumbuh rasa penasaran. Tampilkan semua data dari Profile yang memiliki nama belakang (Last_Name) mengandung “ani” (huruf besar atau kecil).
SELECT *
FROM profile
WHERE LOWER(Last_Name) LIKE '%ani%';