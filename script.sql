CREATE TABLE klienci(
    ID_klienta MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nazwaklienta VARCHAR(100) NOT NULL,
    nip INT(10) UNSIGNED NOT NULL,
    nrtelefonu int(9) UNSIGNED NOT NULL,
    email VARCHAR(50),
    rabat INT(3) NOT NULL,
    ulicanumer VARCHAR(50) NOT NULL,
    miastokod VARCHAR(50) NOT NULL);

CREATE TABLE stanowiska(
    ID_stanowisko MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nazwastanowiska VARCHAR(25) NOT NULL);

CREATE TABLE pracownicy(
    ID_pracownika MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nazwisko VARCHAR(25) NOT NULL,
	  imie VARCHAR (25) NOT NULL,
	  login VARCHAR(128) NOT NULL,
	  haslo VARCHAR(128) NOT NULL,
	  nrtelefonu INT(9) UNSIGNED NOT NULL,
	  email VARCHAR(50),
	  ulicanumer VARCHAR(50) NOT NULL,
    miastokod VARCHAR(50) NOT NULL,
	  ID_stanowisko MEDIUMINT UNSIGNED,
    FOREIGN KEY(ID_stanowisko) REFERENCES stanowiska(ID_stanowisko));

CREATE TABLE dostawcy(
    ID_dostawca MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nazwadostawcy VARCHAR(100) NOT NULL,
	  nrtelefonu INT(9) UNSIGNED NOT NULL,
	  email VARCHAR(50),
	  ulicanumer VARCHAR(50) NOT NULL,
    miastokod VARCHAR(50) NOT NULL);

CREATE TABLE opakowania(
    ID_opakowanie MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pojemnosc INT(5) NOT NULL,
    material VARCHAR(25) NOT NULL);

CREATE TABLE opakowaniazbiorcze(
    ID_opakowaniezbiorcze MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ilesztuk MEDIUMINT NOT NULL,
    rodzajopakowania VARCHAR(50) NOT NULL,
	 wymiary VARCHAR(50));

CREATE TABLE stanyzamowienia(
    ID_stanzamowienia MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nazwastanu VARCHAR(50) NOT NULL);

CREATE TABLE napoje(
    ID_napoju MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nazwanapoju VARCHAR(50) NOT NULL,
    cenadostawcy DECIMAL(6,2) NOT NULL,
  	zawieracukier BOOLEAN NOT NULL,
  	zalkoholem BOOLEAN NOT NULL,
    ilealkoholu DECIMAL(4,2) NOT NULL,
    gazowany BOOLEAN NOT NULL,
	sektormagazynu VARCHAR(25),
	stanmagazynu INT UNSIGNED NOT NULL,
    ID_opakowanie MEDIUMINT UNSIGNED NOT NULL,
    ID_opakowaniezbiorcze MEDIUMINT UNSIGNED NOT NULL,
  	FOREIGN KEY(ID_opakowanie) REFERENCEs opakowania(ID_opakowanie),
    FOREIGN KEY(ID_opakowaniezbiorcze) REFERENCES opakowaniazbiorcze(ID_opakowaniezbiorcze));

CREATE TABLE zamowieniaklientow(
    ID_zamowienieklienta MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    datazlozenia DATE NOT NULL,
    dataplatnosci DATE NOT NULL,
    ID_stanzamowienia MEDIUMINT UNSIGNED NOT NULL,
    ID_klienta MEDIUMINT UNSIGNED NOT NULL,
    ID_pracownika MEDIUMINT UNSIGNED NOT NULL);

alter table zamowieniaklientow add FOREIGN key (ID_stanzamowienia) REFERENCES stanyzamowienia(ID_stanzamowienia);
alter table zamowieniaklientow add FOREIGN key (ID_klienta) REFERENCES klienci(ID_klienta);
alter table zamowieniaklientow add FOREIGN key (ID_pracownika) REFERENCES pracownicy(ID_pracownika);

CREATE TABLE zamawianeproduktyklienta(
    ID_zamawianyproduktklienta MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_zamowienieklienta MEDIUMINT UNSIGNED NOT NULL,
    ID_napoju MEDIUMINT UNSIGNED NOT NULL,
    liczba MEDIUMINT UNSIGNED NOT NULL,
    kwota DECIMAL(10,2) NOT NULL);

alter table zamawianeproduktyklienta add FOREIGN key (ID_zamowienieklienta) REFERENCES zamowieniaklientow(ID_zamowienieklienta);
alter table zamawianeproduktyklienta add FOREIGN key (ID_napoju) REFERENCES napoje(ID_napoju);

CREATE TABLE zamowieniahurtowni(
    ID_zamowieniehurtowni MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    datazlozenia DATE NOT NULL,
    dataplatnosci DATE NOT NULL,
    zamowienieautomatyczne BOOLEAN NOT NULL,
    ID_stanzamowienia MEDIUMINT UNSIGNED NOT NULL,
    ID_dostawca MEDIUMINT UNSIGNED NOT NULL,
    ID_pracownika MEDIUMINT UNSIGNED NOT NULL);

alter table zamowieniahurtowni add FOREIGN key (ID_stanzamowienia) REFERENCES stanyzamowienia(ID_stanzamowienia);
alter table zamowieniahurtowni add FOREIGN key (ID_dostawca) REFERENCES dostawcy(ID_dostawca);
alter table zamowieniahurtowni add FOREIGN key (ID_pracownika) REFERENCES pracownicy(ID_pracownika);

CREATE TABLE zamawianeproduktyhurtowni(
    ID_zamawianyprodukthurtowni MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_zamowieniehurtowni MEDIUMINT UNSIGNED NOT NULL,
	  ID_napoju MEDIUMINT UNSIGNED NOT NULL,
	  liczba MEDIUMINT UNSIGNED NOT NULL,
	  kwota DECIMAL(10,2) NOT NULL);

alter table zamawianeproduktyhurtowni add FOREIGN key (ID_zamowieniehurtowni) REFERENCES zamowieniahurtowni(ID_zamowieniehurtowni);
alter table zamawianeproduktyhurtowni add FOREIGN key (ID_napoju) REFERENCES napoje(ID_napoju);


ALTER TABLE klienci ADD INDEX (nazwaklienta);
ALTER TABLE napoje ADD INDEX (nazwanapoju);


INSERT INTO `dostawcy` (`ID_dostawca`, `nazwadostawcy`, `nrtelefonu`, `email`, `ulicanumer`, `miastokod`) VALUES (NULL, 'Dostawca numer 1', '111222333', NULL, 'Nowa 1', 'Nowgród 11-111');
INSERT INTO `dostawcy` (`ID_dostawca`, `nazwadostawcy`, `nrtelefonu`, `email`, `ulicanumer`, `miastokod`) VALUES (NULL, 'Dostawca numer 2', '123456789', NULL, 'Druga 2', 'Drugogród 22-222');


INSERT INTO `klienci` (`ID_klienta`, `nazwaklienta`, `nip`, `nrtelefonu`, `email`, `rabat`, `ulicanumer`, `miastokod`) VALUES (NULL, 'Kowalski Adam', '2455645874', '123123123', NULL, '0', 'Ulicowa 10', 'Miasto 66-666');
INSERT INTO `klienci` (`ID_klienta`, `nazwaklienta`, `nip`, `nrtelefonu`, `email`, `rabat`, `ulicanumer`, `miastokod`) VALUES (NULL, 'Kowalska Agta', '9877899878', '555666444', NULL, '10', 'Lipna 2', 'Lipki 22-200');
INSERT INTO `klienci` (`ID_klienta`, `nazwaklienta`, `nip`, `nrtelefonu`, `email`, `rabat`, `ulicanumer`, `miastokod`) VALUES (NULL, 'Cebulski Janusz', '7777777777', '741852963', NULL, '23', 'Długa 23', 'Starogród 12-657');


INSERT INTO `opakowania` (`ID_opakowanie`, `pojemnosc`, `material`) VALUES (NULL, '500', 'karton');
INSERT INTO `opakowania` (`ID_opakowanie`, `pojemnosc`, `material`) VALUES (NULL, '1500', 'plastik');
INSERT INTO `opakowania` (`ID_opakowanie`, `pojemnosc`, `material`) VALUES (NULL, '2000', 'plastik');

INSERT INTO `opakowaniazbiorcze` (`ID_opakowaniezbiorcze`, `ilesztuk`, `rodzajopakowania`, `wymiary`) VALUES (NULL, '250', 'zgrzewka', '1200x1000x1600');
INSERT INTO `opakowaniazbiorcze` (`ID_opakowaniezbiorcze`, `ilesztuk`, `rodzajopakowania`, `wymiary`) VALUES (NULL, '400', 'karton', '1600x1600x1600');
INSERT INTO `opakowaniazbiorcze` (`ID_opakowaniezbiorcze`, `ilesztuk`, `rodzajopakowania`, `wymiary`) VALUES (NULL, '100', 'zgrzewka', '800x800x1000');

INSERT INTO `napoje` (`ID_napoju`, `nazwanapoju`, `cenadostawcy`, `zawieracukier`, `zalkoholem`, `ilealkoholu`, `gazowany`, `ID_opakowanie`, `ID_opakowaniezbiorcze`, `sektormagazynu`, `stanmagazynu`) VALUES (NULL, 'Hortex jabłko mięta', '2,50', '0', '0', '0', '0', '1', '2', 'A2', '3200');
INSERT INTO `napoje` (`ID_napoju`, `nazwanapoju`, `cenadostawcy`, `zawieracukier`, `zalkoholem`, `ilealkoholu`, `gazowany`, `ID_opakowanie`, `ID_opakowaniezbiorcze`, `sektormagazynu`, `stanmagazynu`) VALUES (NULL, 'Polaris woda niegazowana', '0.99', '0', '0', '0', '0', '2', '1', 'C1', '5500');
INSERT INTO `napoje` (`ID_napoju`, `nazwanapoju`, `cenadostawcy`, `zawieracukier`, `zalkoholem`, `ilealkoholu`, `gazowany`, `ID_opakowanie`, `ID_opakowaniezbiorcze`, `sektormagazynu`, `stanmagazynu`) VALUES (NULL, 'Coca Cola', '3.90', '1', '0', '0', '1', '3', '3', 'D5', '10000');

INSERT INTO `stanowiska` (`ID_stanowisko`, `nazwastanowiska`) VALUES (NULL, 'Administrator');
INSERT INTO `stanowiska` (`ID_stanowisko`, `nazwastanowiska`) VALUES (NULL, 'Sprzedawca');
INSERT INTO `stanowiska` (`ID_stanowisko`, `nazwastanowiska`) VALUES (NULL, 'Magazynier');

INSERT INTO `pracownicy` (`ID_pracownika`, `nazwisko`, `imie`, `login`, `haslo`, `nrtelefonu`, `email`, `ulicanumer`, `miastokod`, `ID_stanowisko`) VALUES (NULL, 'Nowak', 'Jan', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', '454565464', NULL, 'Menadżerska 5', 'Warszawa 30-300', '1');
INSERT INTO `pracownicy` (`ID_pracownika`, `nazwisko`, `imie`, `login`, `haslo`, `nrtelefonu`, `email`, `ulicanumer`, `miastokod`, `ID_stanowisko`) VALUES (NULL, 'Potocki', 'Adam', '5b42ee3081620cfc8da882a2ed4985a3c5cd56415da6ba8a3e644504030296742d7905c828bffd33c597cd54f2efd4e7984cf5bb6fe4a4f409a6d876e2d464a4', 'd44bd4b6bc03fdf28cda23877ee25e7a829ae8ece559965b20ada21f5457578c720eea1688efc282848b77cc1056b309fe2cf5006ccb8016c47a1d5702690c0d', '112223331', NULL, 'Bazarska 3', 'Sopot 20-300', '2');
INSERT INTO `pracownicy` (`ID_pracownika`, `nazwisko`, `imie`, `login`, `haslo`, `nrtelefonu`, `email`, `ulicanumer`, `miastokod`, `ID_stanowisko`) VALUES (NULL, 'Chudomski', 'Zbigniew', '8958123ae707ebca7eaaa0fb051801cb86ba13640e2bc5315c7e1dd9f846e29412148b6351427883f21551d394cbaf3ff2ec613b741e73eab1848fbf3d8c54fd', 'de43e2d46ff093ede0c14729814d07760bc1b5da59c76c39298d13ff8591228f293bc5003fca688e76d45010b5206aa9b72b84ef3a54e9b91ca57abec44abc03', '998889987', NULL, 'Porządkowa 17/1', 'Poznań 30-100', '3');

INSERT INTO `stanyzamowienia` (`ID_stanzamowienia`, `nazwastanu`) VALUES (NULL, 'Złożono');
INSERT INTO `stanyzamowienia` (`ID_stanzamowienia`, `nazwastanu`) VALUES (NULL, 'W realizacji');
INSERT INTO `stanyzamowienia` (`ID_stanzamowienia`, `nazwastanu`) VALUES (NULL, 'Zrealizowano');
INSERT INTO `stanyzamowienia` (`ID_stanzamowienia`, `nazwastanu`) VALUES (NULL, 'Anulowano');



DELIMITER //
CREATE PROCEDURE DodajKlienta(
    IN nazwaklienta VARCHAR(100),
    IN nip INT(10) UNSIGNED,
    IN nrtelefonu int(9) UNSIGNED,
    IN email VARCHAR(50),
    IN rabat INT(3),
    IN ulicanumer VARCHAR(50),
    IN miastokod VARCHAR(50))
BEGIN
INSERT INTO `klienci` (`ID_klienta`, `nazwaklienta`, `nip`, `nrtelefonu`, `email`, `rabat`, `ulicanumer`, `miastokod`) VALUES (NULL, nazwaklienta, nip, nrtelefonu, email, rabat, ulicanumer, miastokod);
END //
DELIMITER ;
CALL DodajKlienta('testowanazwa', 6666666666, 666666666, NULL, 0, 'testowaulica 6', 'testowemiasto 66-666');

DELIMITER //
CREATE PROCEDURE DodajPracownika(
    IN nazwisko VARCHAR(25),
	  IN imie VARCHAR (25),
	  IN login VARCHAR(128),
	  IN haslo VARCHAR(128),
	  IN nrtelefonu INT(9) UNSIGNED,
	  IN email VARCHAR(50),
	  IN ulicanumer VARCHAR(50),
    IN miastokod VARCHAR(50),
	  IN ID_stanowisko MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `pracownicy` (`ID_pracownika`, `nazwisko`, `imie`, `login`, `haslo`, `nrtelefonu`, `email`, `ulicanumer`, `miastokod`, `ID_stanowisko`) VALUES (NULL, nazwisko, imie, login, haslo, nrtelefonu, email, ulicanumer, miastokod, ID_stanowisko);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DodajDostawce(
    IN nazwadostawcy VARCHAR(100),
	  IN nrtelefonu INT(9) UNSIGNED,
	  IN email VARCHAR(50),
	  IN ulicanumer VARCHAR(50),
    IN miastokod VARCHAR(50))
BEGIN
INSERT INTO `dostawcy` (`ID_dostawca`, `nazwadostawcy`, `nrtelefonu`, `email`, `ulicanumer`, `miastokod`) VALUES (NULL, nazwadostawcy, nrtelefonu, email, ulicanumer, miastokod);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DodajNapoj(
    IN nazwanapoju VARCHAR(50),
    IN cenadostawcy DECIMAL(6,2),
  	IN zawieracukier BOOLEAN,
  	IN zalkoholem BOOLEAN,
    IN ilealkoholu DECIMAL(4,2),
    IN gazowany BOOLEAN,
	IN sektormagazynu VARCHAR(25),
	IN stanmagazynu INT UNSIGNED,
    IN ID_opakowanie MEDIUMINT UNSIGNED,
    IN ID_opakowaniezbiorcze MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `napoje` (`ID_napoju`, `nazwanapoju`, `cenadostawcy`, `zawieracukier`, `zalkoholem`, `ilealkoholu`, `gazowany`, `ID_opakowanie`, `ID_opakowaniezbiorcze`, `sektormagazynu`, `stanmagazynu`) VALUES (NULL, nazwanapoju, cenadostawcy, zawieracukier, zalkoholem, ilealkoholu, gazowany, ID_opakowanie, ID_opakowaniezbiorcze, sektormagazynu, stanmagazynu);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZlozZamowienieKlienta(
    IN datazlozenia DATE,
    IN dataplatnosci DATE,
    IN ID_stanzamowienia MEDIUMINT UNSIGNED,
    IN ID_klienta MEDIUMINT UNSIGNED,
    IN ID_pracownika MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `zamowieniaklientow` (`ID_zamowienieklienta`, `datazlozenia`, `dataplatnosci`, `ID_stanzamowienia`, `ID_klienta`, `ID_pracownika`) VALUES (NULL, datazlozenia, dataplatnosci, ID_stanzamowienia, ID_klienta, ID_pracownika);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZlozZamowienieHurtowni(
    IN datazlozenia DATE,
    IN dataplatnosci DATE,
    IN zamowienieautomatyczne BOOLEAN,
    IN ID_stanzamowienia MEDIUMINT UNSIGNED,
    IN ID_dostawca MEDIUMINT UNSIGNED,
    IN ID_pracownika MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `zamowieniahurtowni` (`ID_zamowienieklienta`, `datazlozenia`, `dataplatnosci`, `zamowienieautomatyczne`, `ID_stanzamowienia`, `ID_dostawca`, `ID_pracownika`) VALUES (NULL, datazlozenia, dataplatnosci, zamowienieautomatyczne, ID_stanzamowienia, ID_dostawca, ID_pracownika);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DodajZamawianyProduktHurtowni(
		IN ID_zamowieniehurtowni MEDIUMINT UNSIGNED,
		IN drinkID MEDIUMINT UNSIGNED,
		IN quantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT cenadostawcy FROM napoje WHERE ID_napoju = drinkID)*quantity;
INSERT INTO `zamawianeproduktyhurtowni` (`ID_zamawianyprodukthurtowni`, `ID_zamowieniehurtowni`, `ID_napoju`, `liczba`, `kwota`) VALUES (NULL, ID_zamowieniehurtowni, drinkID, quantity, totalValue);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE DodajZamawianyProduktKlienta(
    IN ID_zamowienieklienta MEDIUMINT UNSIGNED,
    IN drinkID MEDIUMINT UNSIGNED,
    IN quantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT cenadostawcy FROM napoje WHERE ID_napoju = drinkID)*quantity*1.23;
INSERT INTO `zamawianeproduktyklienta` (`ID_zamawianyproduktklienta`, `ID_zamowienieklienta`, `ID_napoju`, `liczba`, `kwota`) VALUES (NULL, ID_zamowienieklienta, drinkID, quantity, totalValue);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE UsunNapoj(IN id MEDIUMINT UNSIGNED)
BEGIN
DELETE FROM napoje WHERE ID_napoju = id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AnulujZamowienieKlienta(IN id MEDIUMINT UNSIGNED)
BEGIN
DELETE FROM zamawianeproduktyklienta WHERE ID_zamowienieklienta = id;
UPDATE zamowieniaklientow SET ID_stanzamowienia = 4 WHERE ID_zamowienieklienta = id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AnulujZamowienieHurtowni(IN id MEDIUMINT UNSIGNED)
BEGIN
DELETE FROM zamawianeproduktyhurtowni WHERE ID_zamowieniehurtowni = id;
UPDATE zamowieniahurtowni SET ID_stanzamowienia = 4 WHERE ID_zamowieniehurtowni = id;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE ZmienIloscProduktu(IN productID MEDIUMINT UNSIGNED, IN newQuantity INT UNSIGNED)
BEGIN
UPDATE napoje SET stanmagazynu = newQuantity WHERE ID_napoju = productID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EdytujDostawce(
	IN PARAMproviderID MEDIUMINT UNSIGNED, 
	IN PARAMnazwadostawcy VARCHAR(100),
	IN PARAMnrtelefonu INT(9) UNSIGNED,
	IN PARAMemail VARCHAR(50),
	IN PARAMulicanumer VARCHAR(50),
    IN PARAMmiastokod VARCHAR(50))
BEGIN
UPDATE dostawcy SET nazwadostawcy = PARAMnazwadostawcy, nrtelefonu = PARAMnrtelefonu, email = PARAMemail, ulicanumer = PARAMulicanumer, miastokod = PARAMmiastokod WHERE ID_dostawca = PARAMproviderID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EdytujKlienta(
	IN PARAMclientID MEDIUMINT UNSIGNED,
	IN PARAMclientName VARCHAR(100),
    IN PARAMnip INT(10) UNSIGNED,
    IN PARAMnrtelefonu int(9) UNSIGNED,
    IN PARAMemail VARCHAR(50),
    IN PARAMrabat INT(3),
    IN PARAMulicanumer VARCHAR(50),
    IN PARAMmiastokod VARCHAR(50))
BEGIN
UPDATE klienci SET nazwaklienta = PARAMclientName, nip = PARAMnip, nrtelefonu = PARAMnrtelefonu, email = PARAMemail, rabat = PARAMrabat, ulicanumer = PARAMulicanumer, miastokod = PARAMmiastokod WHERE ID_klienta = PARAMclientID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EdytujPracownika(
	IN PARAMemployeeID MEDIUMINT UNSIGNED,
	IN PARAMnazwisko VARCHAR(25),
	IN PARAMimie VARCHAR (25),
	IN PARAMlogin VARCHAR(128),
	IN PARAMhaslo VARCHAR(128),
	IN PARAMnrtelefonu INT(9) UNSIGNED,
	IN PARAMemail VARCHAR(50),
	IN PARAMulicanumer VARCHAR(50),
	IN PARAMmiastokod VARCHAR(50),
	IN PARAMID_stanowisko MEDIUMINT UNSIGNED)
BEGIN
UPDATE pracownicy SET nazwisko = PARAMnazwisko, imie = PARAMimie, login = PARAMlogin, haslo = PARAMhaslo, nrtelefonu = PARAMnrtelefonu, email = PARAMemail, ulicanumer = PARAMulicanumer, miastokod = PARAMmiastokod, ID_stanowisko = PARAMID_stanowisko WHERE ID_pracownika = PARAMemployeeID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EdytujZamawianyProduktHurtowni(
	IN PARAMID_zamawianyprodukthurtowni MEDIUMINT UNSIGNED,
	IN PARAMID_zamowieniehurtowni MEDIUMINT UNSIGNED,
	IN PARAMdrinkID MEDIUMINT UNSIGNED,
	IN PARAMquantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT cenadostawcy FROM napoje WHERE ID_napoju = drinkID)*quantity;
UPDATE zamawianeproduktyhurtowni SET ID_zamowieniehurtowni = PARAMID_zamowieniehurtowni, ID_napoju = PARAMdrinkID, liczba = PARAMquantity. kwota = totalValue WHERE ID_zamawianyprodukthurtowni = PARAMID_zamawianyprodukthurtowni;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EdytujZamawianyProduktKlienta(
	IN PARAMID_zamawianyproduktklienta MEDIUMINT UNSIGNED,
    IN PARAMID_zamowienieklienta MEDIUMINT UNSIGNED,
    IN PARAMdrinkID MEDIUMINT UNSIGNED,
    IN PARAMquantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT cenadostawcy FROM napoje WHERE ID_napoju = drinkID)*quantity*1.23;
UPDATE zamawianeproduktyklienta SET ID_zamowienieklienta = PARAMID_zamowienieklienta, ID_napoju = PARAMdrinkID, liczba = PARAMquantity, kwota = totalValue WHERE ID_zamawianyproduktklienta = PARAMID_zamawianyproduktklienta;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EdytujNapoj(
	IN PARAMID_napoju MEDIUMINT UNSIGNED,
    IN PARAMnazwanapoju VARCHAR(50),
    IN PARAMcenadostawcy DECIMAL(6,2),
  	IN PARAMzawieracukier BOOLEAN,
  	IN PARAMzalkoholem BOOLEAN,
    IN PARAMilealkoholu DECIMAL(4,2),
    IN PARAMgazowany BOOLEAN,
	IN PARAMsektormagazynu VARCHAR(25),
	IN PARAMstanmagazynu INT UNSIGNED,
    IN PARAMID_opakowanie MEDIUMINT UNSIGNED,
    IN PARAMID_opakowaniezbiorcze MEDIUMINT UNSIGNED)
BEGIN
UPDATE napoje SET nazwanapoju = PARAMnazwanapoju, cenadostawcy = PARAMcenadostawcy, zawieracukier = PARAMzawieracukier, zalkoholem = PARAMzalkoholem, ilealkoholu = PARAMilealkoholu, gazowany = PARAMgazowany, ID_opakowanie = PARAMID_opakowanie, ID_opakowaniezbiorcze = PARAMID_opakowaniezbiorcze, sektormagazynu = PARAMsektormagazynu, stanmagazynu = PARAMstanmagazynu WHERE ID_napoju = PARAMID_napoju;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE ZnajdzWszystkieZamowieniaWTrakcie()
BEGIN
SELECT *
FROM(SELECT * FROM zamowieniaklientow WHERE ID_stanzamowienia = 2) AS T1
NATURAL JOIN(SELECT * FROM zamowieniahurtowni WHERE ID_stanzamowienia = 2) AS T2;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzZamowienieHurtowniPoDacie(IN searchDate DATE)
BEGIN
SELECT * FROM zamawianeproduktyhurtowni WHERE searchData = datazlozenia;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzZamowienieHurtowniPoDostawcy(IN provider VARCHAR(100))
BEGIN
SELECT * FROM zamawianeproduktyhurtowni
	JOIN dostawcy ON ID_dostawca
    WHERE dostawcy.nazwadostawcy LIKE provider;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzZamowienieHurtowniPoPracowniku(IN name VARCHAR(25))
BEGIN
SELECT * FROM zamawianeproduktyhurtowni
	JOIN pracownicy ON ID_pracownika
    WHERE pracownicy.nazwisko LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzNapoj(IN name VARCHAR(50))
BEGIN
SELECT * FROM zamawianeproduktyhurtowni
    WHERE napoje.nazwanapoju LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzZamowienieKlienta(IN name VARCHAR(100))
BEGIN
SELECT * FROM zamowieniaklientow
	JOIN klienci ON ID_klienta
    WHERE klienci.nazwaklienta LIKE name AND zamowieniaklientow.ID_stanzamowienia = 2;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzDostawce(IN name VARCHAR(100))
BEGIN
SELECT * FROM dostawcy
    WHERE nazwadostawcy LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzKlientaPoNazwie(IN name VARCHAR(100))
BEGIN
SELECT * FROM klienci
    WHERE nazwaklienta LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzKlientaPoNIP(IN NIPnumber INT(10))
BEGIN
SELECT * FROM klienci
    WHERE nip = NIPnumber;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ZnajdzPracownikaPoNazwie(IN name VARCHAR(25))
BEGIN
SELECT * FROM pracownicy
    WHERE nazwisko LIKE name;
END //
DELIMITER ;




DELIMITER //
CREATE PROCEDURE FindDataForBill(IN id MEDIUMINT UNSIGNED)
BEGIN
DECLARE clientID MEDIUMINT UNSIGNED;
SET clientID = (SELECT ID_klienta FROM zamowieniaklientow 
                       		WHERE id = ID_zamowienieklienta);
                            
CREATE TEMPORARY TABLE tmp
(
    tmpID MEDIUMINT UNSIGNED NOT NULL,
    productName VARCHAR(50),
    quantity MEDIUMINT UNSIGNED,
    rowValue DECIMAL(10,2)
);
INSERT INTO tmp (tmpID, productName, quantity, rowValue)
	SELECT napoje.ID_napoju, napoje.nazwanapoju, zamawianeproduktyklienta.liczba, zamawianeproduktyklienta.kwota
    	FROM zamawianeproduktyklienta JOIN napoje ON zamawianeproduktyklienta.ID_napoju = napoje.ID_napoju
        WHERE id = zamawianeproduktyklienta.ID_zamowienieklienta;
                            

SELECT *
FROM		(SELECT datazlozenia, dataplatnosci FROM zamowieniaklientow 
     			WHERE id = ID_zamowienieklienta) AS T1
                
NATURAL JOIN(SELECT nazwaklienta, nip, ulicanumer, miastokod FROM klienci
				WHERE (clientID) = ID_klienta) AS T2
                            
NATURAL JOIN(SELECT productName, quantity, rowValue FROM tmp) AS T3;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE GenerateReport(startDate DATE, endDate DATE)
BEGIN

CREATE TEMPORARY TABLE tmpK
(
    tmpID MEDIUMINT UNSIGNED NOT NULL,
    productName VARCHAR(50),
    quantity MEDIUMINT UNSIGNED,
    rowValue DECIMAL(10,2)
);

INSERT INTO tmpK (tmpID, productName, quantity, rowValue)
	SELECT zamawianeproduktyklienta.ID_zamowienieklienta, napoje.nazwanapoju, zamawianeproduktyklienta.liczba, zamawianeproduktyklienta.kwota
    	FROM zamawianeproduktyklienta JOIN napoje ON zamawianeproduktyklienta.ID_napoju = napoje.ID_napoju
        WHERE id = zamawianeproduktyklienta.ID_zamowienieklienta;

CREATE TEMPORARY TABLE tmpH
(
    tmpID MEDIUMINT UNSIGNED NOT NULL,
    productName VARCHAR(50),
    quantity MEDIUMINT UNSIGNED,
    rowValue DECIMAL(10,2)
);
		

INSERT INTO tmpH (tmpID, productName, quantity, rowValue)
	SELECT zamawianeproduktyhurtowni.ID_zamowieniehurtowni, napoje.nazwanapoju, zamawianeproduktyhurtowni.liczba, zamawianeproduktyhurtowni.kwota
    	FROM zamawianeproduktyhurtowni JOIN napoje ON zamawianeproduktyhurtowni.ID_napoju = napoje.ID_napoju
        WHERE id = zamawianeproduktyhurtowni.ID_zamowieniehurtowni;
                            

SELECT * FROM
	(	SELECT klienci.nazwaklienta, tmpK.productName, tmpK.quantity, tmpK.rowValue 
		FROM tmpK 	JOIN zamowieniaklientow ON tmpK.tmpID = zamowieniaklientow.ID_zamowienieklienta
			  		JOIN klienci ON zamowieniaklientow.ID_klienta = klienci.ID_klienta
		WHERE datazlozenia BETWEEN startDate AND endDate
    ) AS T1
    NATURAL JOIN
    (
        SELECT "hurtownia", tmpH.productName, tmpH.quantity, tmpH.rowValue 
		FROM tmpH JOIN zamowieniahurtowni ON tmph.tmpID = zamowieniahurtowni.ID_zamowieniehurtowni
		WHERE datazlozenia BETWEEN startDate AND endDate
    ) AS T2;


		
END //
DELIMITER ;