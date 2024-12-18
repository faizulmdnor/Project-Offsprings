
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'offsprings')
BEGIN
	create database offsprings;
END

USE offsprings

CREATE TABLE Gender(
	Gender_id INT PRIMARY KEY,
	Gender VARCHAR(10)
);

CREATE TABLE Tahun(
	tahun_id INT PRIMARY KEY,
	tahun INT
);

CREATE TABLE Darjah(
	darjah_id INT PRIMARY KEY,
	[Darjah/Tingkatan] INT
);

CREATE TABLE Person_status(
	Status_id INT PRIMARY KEY,
	Status VARCHAR(15)
);

CREATE TABLE Kelas(
	kelas_id INT PRIMARY KEY,
	kelas_name VARCHAR(25)
);

ALTER TABLE Kelas
ADD darjah_id INT
	FOREIGN KEY (darjah_id) REFERENCES Darjah(darjah_id)


CREATE TABLE Sekolah(
	id_sekolah INT PRIMARY KEY,
	Nama_Sekolah VARCHAR(255)
);

ALTER TABLE Sekolah
ADD kelas_id INT,
	FOREIGN KEY (kelas_id) REFERENCES Kelas(kelas_id);



CREATE TABLE Person(
	id INT PRIMARY KEY IDENTITY(1000, 1),
	First_Name VARCHAR(15),
	Last_Name VARCHAR(15),
	Birth_Cert VARCHAR(15),
	ID_Number VARCHAR(14),
	Birth_Date DATE,
	Gender_id INT,
	Status_id INT,
	id_sekolah INT,
	FOREIGN KEY (Gender_id) REFERENCES Gender(Gender_id),
	FOREIGN KEY (Status_id) REFERENCES Person_status(Status_id),
	FOREIGN KEY (id_sekolah) REFERENCES Sekolah(id_sekolah)
);

ALTER TABLE Person
DROP CONSTRAINT FK_Person_id_sekolah; 

ALTER TABLE Person
DROP COLUMN id_sekolah;
    FOREIGN KEY (id_sekolah) REFERENCES Sekolah(id_sekolah);


SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'Sekolah' AND COLUMN_NAME LIKE '%kelas%';

ALTER TABLE Person
DROP CONSTRAINT FK__Person__id_sekol__6754599E;

ALTER TABLE Person
DROP COLUMN id_sekolah;

ALTER TABLE Sekolah
DROP CONSTRAINT FK__Sekolah__kelas_i__6A30C649

ALTER TABLE Sekolah
DROP COLUMN kelas_id

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'Kelas' AND COLUMN_NAME LIKE '%darjah%';

ALTER TABLE Kelas
DROP CONSTRAINT FK__Kelas__darjah_id__6D0D32F4

ALTER TABLE Kelas
DROP COLUMN darjah_id

CREATE TABLE Penempatan_Sekolah(
	ps_id INT PRIMARY KEY IDENTITY(21103, 13),
	person_id INT,
	sekolah_id INT,
	darjah_id INT,
	kelas_id INT,
	tahun_id INT,
	FOREIGN KEY (person_id) REFERENCES Person(id),
	FOREIGN KEY (sekolah_id) REFERENCES Sekolah(id_sekolah),
	FOREIGN KEY (darjah_id) REFERENCES Darjah(darjah_id),
	FOREIGN KEY (kelas_id) REFERENCES Kelas(kelas_id),
	FOREIGN KEY (tahun_id) REFERENCES Tahun(tahun_id),
);
