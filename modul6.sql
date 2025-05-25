1. Tampilkan First_Name dan Last_Name dari Profile beserta Interest_Name mereka. Tampilkan juga user yang belum punya interest.
SELECT p.First_Name, p.Last_Name, i.Interest_Name
FROM profile p
LEFT JOIN interest i ON p.Profile_ID = i.Profile_ID;

2. Tampilkan Interest_Name beserta Match_ID dan Match_Time. Tampilkan juga interest yang belum dimatch-kan.
SELECT i.Interest_Name, m.Match_ID, m.Match_Time
FROM interest i
LEFT JOIN matches m ON i.Interest_ID = m.Interest_ID;

3. Tampilkan Email user (dari tabel User) beserta Plan_Name dan Start_Date membership. Tampilkan juga user yang belum punya membership.
SELECT u.Email, m.Plan_Name, m.Start_Date
FROM user u
LEFT JOIN membership m ON u.User_ID = m.User_ID;

4. Tampilkan Match_ID, Interest_Name, dan jumlah pesan yang terkirim pada setiap match.
SELECT m.Match_ID, i.Interest_Name, COUNT(msg.Message_ID) AS Jumlah_Pesan
FROM matches m
LEFT JOIN interest i ON m.Interest_ID = i.Interest_ID
LEFT JOIN message msg ON m.Match_ID = msg.Match_ID
GROUP BY m.Match_ID, i.Interest_Name;

5. Tampilkan First_Name, Last_Name dari Profile dan Email dari User.
SELECT p.First_Name, p.Last_Name, u.Email
FROM profile p
JOIN user u ON p.User_ID = u.User_ID;

6. Buat tabel LogTambahInterest
CREATE TABLE LogTambahInterest (
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Interest_ID INT,
  Profile_ID INT,
  Interest_Name VARCHAR(50),
  Waktu_Tambah DATETIME
);

7. Buatlah sebuah trigger yang akan menambahkan log ke dalam tabel LogTambahInterest setiap kali ada data baru yang dimasukkan ke dalam tabel Interest. Trigger ini harus mencatat Interest_ID, Profile_ID, Interest_Name, dan Waktu_Tambah dari setiap insert yang terjadi pada tabel Interest.
DELIMITER //
CREATE TRIGGER trg_insert_interest
AFTER INSERT ON interest
FOR EACH ROW
BEGIN
  INSERT INTO LogTambahInterest (Interest_ID, Profile_ID, Interest_Name, Waktu_Tambah)
  VALUES (NEW.Interest_ID, NEW.Profile_ID, NEW.Interest_Name, NOW());
END;
//
DELIMITER ;

8. Buat tabel LogPesanBaru
CREATE TABLE LogPesanBaru (
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Message_ID INT,
  Match_ID INT,
  Message_Text TEXT,
  Waktu_Kirim TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

9. Buatlah sebuah trigger yang akan menambahkan log ke dalam tabel LogPesanBaru setiap kali ada data baru yang dimasukkan ke dalam tabel Message. Trigger ini harus mencatat Message_ID, Match_ID, Message_Text, dan Waktu_Kirim dari setiap insert yang terjadi pada tabel Message.
DELIMITER //
CREATE TRIGGER trg_insert_message
AFTER INSERT ON message
FOR EACH ROW
BEGIN
  INSERT INTO LogPesanBaru (Message_ID, Match_ID, Message_Text)
  VALUES (NEW.Message_ID, NEW.Match_ID, NEW.Message_Text);
END;
//
DELIMITER ;

10. Buatlah sebuah trigger yang akan menambahkan log ke dalam tabel LogTambahInterest setiap kali ada data yang dihapus dari tabel Interest. Trigger ini harus mencatat Interest_ID, Profile_ID, Interest_Name, dan Waktu_Tambah yang berisi waktu penghapusan interest tersebut.
DELIMITER //
CREATE TRIGGER trg_delete_interest
AFTER DELETE ON interest
FOR EACH ROW
BEGIN
  INSERT INTO LogTambahInterest (Interest_ID, Profile_ID, Interest_Name, Waktu_Tambah)
  VALUES (OLD.Interest_ID, OLD.Profile_ID, OLD.Interest_Name, NOW());
END;
//
DELIMITER ;

11. Buatlah sebuah view yang menampilkan Match_ID, Match_Time, dan jumlah pesan yang terkirim dalam setiap match.
CREATE VIEW View_JumlahPesanPerMatch AS
SELECT m.Match_ID, m.Match_Time, COUNT(msg.Message_ID) AS Jumlah_Pesan
FROM matches m
LEFT JOIN message msg ON m.Match_ID = msg.Match_ID
GROUP BY m.Match_ID, m.Match_Time;

12. Buatlah sebuah view yang menampilkan nama interest (Interest_Name) dan jumlah match yang terkait dengan interest tersebut. 
CREATE VIEW View_JumlahMatchPerInterest AS
SELECT i.Interest_Name, COUNT(m.Match_ID) AS Jumlah_Match
FROM interest i
LEFT JOIN matches m ON i.Interest_ID = m.Interest_ID
GROUP BY i.Interest_Name;

13. Buatlah sebuah view yang menampilkan detail pesan, yaitu Message_ID, Message_Text, dan Match_Time dari setiap pesan yang terkirim.
CREATE VIEW View_DetailPesan AS
SELECT msg.Message_ID, msg.Message_Text, m.Match_Time
FROM message msg
JOIN matches m ON msg.Match_ID = m.Match_ID;

14. Buatlah sebuah view yang menampilkan semua interest yang belum dipasangkan dengan match manapun.
CREATE VIEW View_InterestBelumMatch AS
SELECT i.Interest_ID, i.Interest_Name
FROM interest i
LEFT JOIN matches m ON i.Interest_ID = m.Interest_ID
WHERE m.Match_ID IS NULL;

15. Buatlah sebuah view yang menampilkan Match_ID dan jumlah pesan yang terkirim pada setiap match yang sudah memiliki pesan terkirim.
CREATE VIEW View_MatchDenganPesan AS
SELECT m.Match_ID, COUNT(msg.Message_ID) AS Jumlah_Pesan
FROM matches m
JOIN message msg ON m.Match_ID = msg.Match_ID
GROUP BY m.Match_ID;

-> 🧪 UJI COBA TRIGGER: trg_insert_interest dan trg_delete_interest
-- Simpan ID profile yang sudah ada (misal: Profile_ID = 2)
INSERT INTO interest (Profile_ID, Interest_Name) VALUES (2, 'Futsal');
SELECT * FROM LogTambahInterest ORDER BY Log_ID DESC LIMIT 1;

DELETE FROM interest WHERE Interest_Name = 'Futsal' AND Profile_ID = 2;
SELECT * FROM LogTambahInterest ORDER BY Log_ID DESC LIMIT 1;

-> 🧪 UJI COBA TRIGGER: trg_insert_message
INSERT INTO message (Match_ID, Message_Text) VALUES (1, 'Trigger test message!');
SELECT * FROM LogPesanBaru ORDER BY Log_ID DESC LIMIT 1;

-> 👁️ UJI COBA VIEW – Cek apakah tampil sesuai logika
SELECT * FROM View_JumlahPesanPerMatch;
SELECT * FROM View_JumlahMatchPerInterest;
SELECT * FROM View_DetailPesan;

INSERT INTO interest (Profile_ID, Interest_Name) VALUES (2, 'Catur');
SELECT * FROM View_InterestBelumMatch;

SELECT * FROM View_MatchDenganPesan;

SELECT p.First_Name, p.Last_Name, i.Interest_Name
FROM profile p
LEFT JOIN interest i ON p.Profile_ID = i.Profile_ID;

SELECT i.Interest_Name, m.Match_ID, m.Match_Time
FROM interest i
LEFT JOIN matches m ON i.Interest_ID = m.Interest_ID;

SELECT u.Email, m.Plan_Name, m.Start_Date
FROM user u
LEFT JOIN membership m ON u.User_ID = m.User_ID;

SELECT m.Match_ID, i.Interest_Name, COUNT(msg.Message_ID) AS Jumlah_Pesan
FROM matches m
LEFT JOIN interest i ON m.Interest_ID = i.Interest_ID
LEFT JOIN message msg ON m.Match_ID = msg.Match_ID
GROUP BY m.Match_ID, i.Interest_Name;

SELECT p.First_Name, p.Last_Name, u.Email
FROM profile p
JOIN user u ON p.User_ID = u.User_ID;

CREATE TABLE LogTambahInterest (
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Interest_ID INT,
  Profile_ID INT,
  Interest_Name VARCHAR(50),
  Waktu_Tambah DATETIME
);

DELIMITER //
CREATE TRIGGER trg_insert_interest
AFTER INSERT ON interest
FOR EACH ROW
BEGIN
  INSERT INTO LogTambahInterest (Interest_ID, Profile_ID, Interest_Name, Waktu_Tambah)
  VALUES (NEW.Interest_ID, NEW.Profile_ID, NEW.Interest_Name, NOW());
END;
//
DELIMITER ;

CREATE TABLE LogPesanBaru (
  Log_ID INT AUTO_INCREMENT PRIMARY KEY,
  Message_ID INT,
  Match_ID INT,
  Message_Text TEXT,
  Waktu_Kirim TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //
CREATE TRIGGER trg_insert_message
AFTER INSERT ON message
FOR EACH ROW
BEGIN
  INSERT INTO LogPesanBaru (Message_ID, Match_ID, Message_Text)
  VALUES (NEW.Message_ID, NEW.Match_ID, NEW.Message_Text);
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_delete_interest
AFTER DELETE ON interest
FOR EACH ROW
BEGIN
  INSERT INTO LogTambahInterest (Interest_ID, Profile_ID, Interest_Name, Waktu_Tambah)
  VALUES (OLD.Interest_ID, OLD.Profile_ID, OLD.Interest_Name, NOW());
END;
//
DELIMITER ;

CREATE VIEW View_JumlahPesanPerMatch AS
SELECT m.Match_ID, m.Match_Time, COUNT(msg.Message_ID) AS Jumlah_Pesan
FROM matches m
LEFT JOIN message msg ON m.Match_ID = msg.Match_ID
GROUP BY m.Match_ID, m.Match_Time;

CREATE VIEW View_JumlahMatchPerInterest AS
SELECT i.Interest_Name, COUNT(m.Match_ID) AS Jumlah_Match
FROM interest i
LEFT JOIN matches m ON i.Interest_ID = m.Interest_ID
GROUP BY i.Interest_Name;

CREATE VIEW View_DetailPesan AS
SELECT msg.Message_ID, msg.Message_Text, m.Match_Time
FROM message msg
JOIN matches m ON msg.Match_ID = m.Match_ID;

CREATE VIEW View_InterestBelumMatch AS
SELECT i.Interest_ID, i.Interest_Name
FROM interest i
LEFT JOIN matches m ON i.Interest_ID = m.Interest_ID
WHERE m.Match_ID IS NULL;

CREATE VIEW View_MatchDenganPesan AS
SELECT m.Match_ID, COUNT(msg.Message_ID) AS Jumlah_Pesan
FROM matches m
JOIN message msg ON m.Match_ID = msg.Match_ID
GROUP BY m.Match_ID;