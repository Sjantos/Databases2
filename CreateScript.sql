CREATE DATABASE warehouse;

USE warehouse;

CREATE TABLE warehouse.clients(
    ID_client MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    clientName VARCHAR(100) NOT NULL,
    nip INT(10) UNSIGNED NOT NULL,
    phoneNumber int(9) UNSIGNED NOT NULL,
    email VARCHAR(50),
    discount INT(3) NOT NULL,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL);

CREATE TABLE warehouse.positions(
    ID_position MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    positionName VARCHAR(25) NOT NULL);

CREATE TABLE warehouse.employees(
    ID_employee MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    lastName VARCHAR(25) NOT NULL,
	  firstName VARCHAR (25) NOT NULL,
	  login VARCHAR(128) NOT NULL,
	  password VARCHAR(128) NOT NULL,
	  phoneNumber INT(9) UNSIGNED NOT NULL,
	  email VARCHAR(50),
	  street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
	  ID_position MEDIUMINT UNSIGNED,
    FOREIGN KEY(ID_position) REFERENCES warehouse.positions(ID_position));

CREATE TABLE warehouse.providers(
    ID_provider MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    providerName VARCHAR(100) NOT NULL,
	  phoneNumber INT(9) UNSIGNED NOT NULL,
	  email VARCHAR(50),
	  street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL);

CREATE TABLE warehouse.packs(
    ID_pack MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    capacity INT(5) NOT NULL,
    material VARCHAR(25) NOT NULL);

CREATE TABLE warehouse.consolidatedPacks(
    ID_consolidatedPack MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    quantity MEDIUMINT NOT NULL,
    packType VARCHAR(50) NOT NULL,
	 dimensions VARCHAR(50));

CREATE TABLE warehouse.orderStates(
    ID_orderState MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    stateName VARCHAR(50) NOT NULL);

CREATE TABLE warehouse.drinks(
    ID_drink MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    drinkName VARCHAR(50) NOT NULL,
    providersPrice DECIMAL(6,2) NOT NULL,
  	withSugar BOOLEAN NOT NULL,
  	withAlcohol BOOLEAN NOT NULL,
    alcoholDose DECIMAL(4,2) NOT NULL,
    fizzy BOOLEAN NOT NULL,
	warehouseSector VARCHAR(25),
	stockAmount INT UNSIGNED NOT NULL,
    ID_pack MEDIUMINT UNSIGNED NOT NULL,
    ID_consolidatedPack MEDIUMINT UNSIGNED NOT NULL,
  	FOREIGN KEY(ID_pack) REFERENCEs warehouse.packs(ID_pack),
    FOREIGN KEY(ID_consolidatedPack) REFERENCES warehouse.consolidatedPacks(ID_consolidatedPack));

CREATE TABLE warehouse.clientOrders(
    ID_clientOrder MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fillingDate DATE NOT NULL,
    ID_orderState MEDIUMINT UNSIGNED NOT NULL,
    ID_client MEDIUMINT UNSIGNED NOT NULL,
    ID_employee MEDIUMINT UNSIGNED NOT NULL);

alter table warehouse.clientOrders add FOREIGN key (ID_orderState) REFERENCES warehouse.orderStates(ID_orderState);
alter table warehouse.clientOrders add FOREIGN key (ID_client) REFERENCES warehouse.clients(ID_client);
alter table warehouse.clientOrders add FOREIGN key (ID_employee) REFERENCES warehouse.employees(ID_employee);

CREATE TABLE warehouse.clientOrderedDrinks(
    ID_clientOrderedDrink MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_clientOrder MEDIUMINT UNSIGNED NOT NULL,
    ID_drink MEDIUMINT UNSIGNED NOT NULL,
    amount MEDIUMINT UNSIGNED NOT NULL,
    totalValue DECIMAL(10,2) NOT NULL);

alter table warehouse.clientOrderedDrinks add FOREIGN key (ID_clientOrder) REFERENCES warehouse.clientOrders(ID_clientOrder);
alter table warehouse.clientOrderedDrinks add FOREIGN key (ID_drink) REFERENCES warehouse.drinks(ID_drink);

CREATE TABLE warehouse.warehouseOrders(
    ID_warehouseOrder MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fillingDate DATE NOT NULL,
    automaticOrder BOOLEAN NOT NULL,
    ID_orderState MEDIUMINT UNSIGNED NOT NULL,
    ID_provider MEDIUMINT UNSIGNED NOT NULL,
    ID_employee MEDIUMINT UNSIGNED NOT NULL);

alter table warehouse.warehouseOrders add FOREIGN key (ID_orderState) REFERENCES warehouse.orderStates(ID_orderState);
alter table warehouse.warehouseOrders add FOREIGN key (ID_provider) REFERENCES warehouse.providers(ID_provider);
alter table warehouse.warehouseOrders add FOREIGN key (ID_employee) REFERENCES warehouse.employees(ID_employee);

CREATE TABLE warehouse.warehouseOrderedProducts(
    ID_warehouseOrderedProduct MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ID_warehouseOrder MEDIUMINT UNSIGNED NOT NULL,
	  ID_drink MEDIUMINT UNSIGNED NOT NULL,
	  amount MEDIUMINT UNSIGNED NOT NULL,
	  totalValue DECIMAL(10,2) NOT NULL);

alter table warehouse.warehouseOrderedProducts add FOREIGN key (ID_warehouseOrder) REFERENCES warehouse.warehouseOrders(ID_warehouseOrder);
alter table warehouse.warehouseOrderedProducts add FOREIGN key (ID_drink) REFERENCES warehouse.drinks(ID_drink);


ALTER TABLE warehouse.clients ADD INDEX (clientName);
ALTER TABLE warehouse.drinks ADD INDEX (drinkName);


INSERT INTO `warehouse`.`providers` (`ID_provider`, `providerName`, `phoneNumber`, `email`, `street`, `city`) VALUES (NULL, 'Dostawca numer 1', '111222333', NULL, 'Nowa 1', 'Nowgród 11-111');
INSERT INTO `warehouse`.`providers` (`ID_provider`, `providerName`, `phoneNumber`, `email`, `street`, `city`) VALUES (NULL, 'Dostawca numer 2', '123456789', NULL, 'Druga 2', 'Drugogród 22-222');


INSERT INTO `warehouse`.`clients` (`ID_client`, `clientName`, `nip`, `phoneNumber`, `email`, `discount`, `street`, `city`) VALUES (NULL, 'Kowalski Adam', '2455645874', '123123123', NULL, '0', 'Ulicowa 10', 'Miasto 66-666');
INSERT INTO `warehouse`.`clients` (`ID_client`, `clientName`, `nip`, `phoneNumber`, `email`, `discount`, `street`, `city`) VALUES (NULL, 'Kowalska Agta', '9877899878', '555666444', NULL, '10', 'Lipna 2', 'Lipki 22-200');
INSERT INTO `warehouse`.`clients` (`ID_client`, `clientName`, `nip`, `phoneNumber`, `email`, `discount`, `street`, `city`) VALUES (NULL, 'Cebulski Janusz', '7777777777', '741852963', NULL, '23', 'Długa 23', 'Starogród 12-657');


INSERT INTO `warehouse`.`packs` (`ID_pack`, `capacity`, `material`) VALUES (NULL, '500', 'karton');
INSERT INTO `warehouse`.`packs` (`ID_pack`, `capacity`, `material`) VALUES (NULL, '1500', 'plastik');
INSERT INTO `warehouse`.`packs` (`ID_pack`, `capacity`, `material`) VALUES (NULL, '2000', 'plastik');

INSERT INTO `warehouse`.`consolidatedPacks` (`ID_consolidatedPack`, `quantity`, `packType`, `dimensions`) VALUES (NULL, '250', 'zgrzewka', '1200x1000x1600');
INSERT INTO `warehouse`.`consolidatedPacks` (`ID_consolidatedPack`, `quantity`, `packType`, `dimensions`) VALUES (NULL, '400', 'karton', '1600x1600x1600');
INSERT INTO `warehouse`.`consolidatedPacks` (`ID_consolidatedPack`, `quantity`, `packType`, `dimensions`) VALUES (NULL, '100', 'zgrzewka', '800x800x1000');

INSERT INTO `warehouse`.`drinks` (`ID_drink`, `drinkName`, `providersPrice`, `withSugar`, `withAlcohol`, `alcoholDose`, `fizzy`, `ID_pack`, `ID_consolidatedPack`, `warehouseSector`, `stockAmount`) VALUES (NULL, 'Hortex jabłko mięta', '2,50', '0', '0', '0', '0', '1', '2', 'A2', '3200');
INSERT INTO `warehouse`.`drinks` (`ID_drink`, `drinkName`, `providersPrice`, `withSugar`, `withAlcohol`, `alcoholDose`, `fizzy`, `ID_pack`, `ID_consolidatedPack`, `warehouseSector`, `stockAmount`) VALUES (NULL, 'Polaris woda niegazowana', '0.99', '0', '0', '0', '0', '2', '1', 'C1', '5500');
INSERT INTO `warehouse`.`drinks` (`ID_drink`, `drinkName`, `providersPrice`, `withSugar`, `withAlcohol`, `alcoholDose`, `fizzy`, `ID_pack`, `ID_consolidatedPack`, `warehouseSector`, `stockAmount`) VALUES (NULL, 'Coca Cola', '3.90', '1', '0', '0', '1', '3', '3', 'D5', '10000');

INSERT INTO `warehouse`.`positions` (`ID_position`, `positionName`) VALUES (NULL, 'Administrator');
INSERT INTO `warehouse`.`positions` (`ID_position`, `positionName`) VALUES (NULL, 'Sprzedawca');
INSERT INTO `warehouse`.`positions` (`ID_position`, `positionName`) VALUES (NULL, 'Magazynier');

INSERT INTO `warehouse`.`employees` (`ID_employee`, `lastName`, `firstName`, `login`, `password`, `phoneNumber`, `email`, `street`, `city`, `ID_position`) VALUES (NULL, 'Nowak', 'Jan', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', '454565464', NULL, 'Menadżerska 5', 'Warszawa 30-300', '1');
INSERT INTO `warehouse`.`employees` (`ID_employee`, `lastName`, `firstName`, `login`, `password`, `phoneNumber`, `email`, `street`, `city`, `ID_position`) VALUES (NULL, 'Potocki', 'Adam', '5b42ee3081620cfc8da882a2ed4985a3c5cd56415da6ba8a3e644504030296742d7905c828bffd33c597cd54f2efd4e7984cf5bb6fe4a4f409a6d876e2d464a4', 'd44bd4b6bc03fdf28cda23877ee25e7a829ae8ece559965b20ada21f5457578c720eea1688efc282848b77cc1056b309fe2cf5006ccb8016c47a1d5702690c0d', '112223331', NULL, 'Bazarska 3', 'Sopot 20-300', '2');
INSERT INTO `warehouse`.`employees` (`ID_employee`, `lastName`, `firstName`, `login`, `password`, `phoneNumber`, `email`, `street`, `city`, `ID_position`) VALUES (NULL, 'Chudomski', 'Zbigniew', '8958123ae707ebca7eaaa0fb051801cb86ba13640e2bc5315c7e1dd9f846e29412148b6351427883f21551d394cbaf3ff2ec613b741e73eab1848fbf3d8c54fd', 'de43e2d46ff093ede0c14729814d07760bc1b5da59c76c39298d13ff8591228f293bc5003fca688e76d45010b5206aa9b72b84ef3a54e9b91ca57abec44abc03', '998889987', NULL, 'Porządkowa 17/1', 'Poznań 30-100', '3');

INSERT INTO `warehouse`.`orderStates` (`ID_orderState`, `stateName`) VALUES (NULL, 'Złożono');
INSERT INTO `warehouse`.`orderStates` (`ID_orderState`, `stateName`) VALUES (NULL, 'W realizacji');
INSERT INTO `warehouse`.`orderStates` (`ID_orderState`, `stateName`) VALUES (NULL, 'Zrealizowano');
INSERT INTO `warehouse`.`orderStates` (`ID_orderState`, `stateName`) VALUES (NULL, 'Anulowano');



DELIMITER //
CREATE PROCEDURE AddClient(
    IN clientName VARCHAR(100),
    IN nip INT(10) UNSIGNED,
    IN phoneNumber int(9) UNSIGNED,
    IN email VARCHAR(50),
    IN discount INT(3),
    IN street VARCHAR(50),
    IN city VARCHAR(50))
BEGIN
INSERT INTO `warehouse`.`clients` (`ID_client`, `clientName`, `nip`, `phoneNumber`, `email`, `discount`, `street`, `city`) VALUES (NULL, clientName, nip, phoneNumber, email, discount, street, city);
END //
DELIMITER ;
CALL AddClient('testowanazwa', 6666666666, 666666666, NULL, 0, 'testowaulica 6', 'testowemiasto 66-666');

DELIMITER //
CREATE PROCEDURE AddWorker(
    IN lastName VARCHAR(25),
	  IN firstName VARCHAR (25),
	  IN login VARCHAR(128),
	  IN password VARCHAR(128),
	  IN phoneNumber INT(9) UNSIGNED,
	  IN email VARCHAR(50),
	  IN street VARCHAR(50),
    IN city VARCHAR(50),
	  IN ID_position MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `warehouse`.`employees` (`ID_employee`, `lastName`, `firstName`, `login`, `password`, `phoneNumber`, `email`, `street`, `city`, `ID_position`) VALUES (NULL, lastName, firstName, login, password, phoneNumber, email, street, city, ID_position);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddProvider(
    IN providerName VARCHAR(100),
	  IN phoneNumber INT(9) UNSIGNED,
	  IN email VARCHAR(50),
	  IN street VARCHAR(50),
    IN city VARCHAR(50))
BEGIN
INSERT INTO `warehouse`.`providers` (`ID_provider`, `providerName`, `phoneNumber`, `email`, `street`, `city`) VALUES (NULL, providerName, phoneNumber, email, street, city);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddDrink(
    IN drinkName VARCHAR(50),
    IN providersPrice DECIMAL(6,2),
  	IN withSugar BOOLEAN,
  	IN withAlcohol BOOLEAN,
    IN alcoholDose DECIMAL(4,2),
    IN fizzy BOOLEAN,
	IN warehouseSector VARCHAR(25),
	IN stockAmount INT UNSIGNED,
    IN ID_pack MEDIUMINT UNSIGNED,
    IN ID_consolidatedPack MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `warehouse`.`drinks` (`ID_drink`, `drinkName`, `providersPrice`, `withSugar`, `withAlcohol`, `alcoholDose`, `fizzy`, `ID_pack`, `ID_consolidatedPack`, `warehouseSector`, `stockAmount`) VALUES (NULL, drinkName, providersPrice, withSugar, withAlcohol, alcoholDose, fizzy, ID_pack, ID_consolidatedPack, warehouseSector, stockAmount);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MakeClientOrder(
    IN fillingDate DATE,
    IN ID_orderState MEDIUMINT UNSIGNED,
    IN ID_client MEDIUMINT UNSIGNED,
    IN ID_employee MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `warehouse`.`clientOrders` (`ID_clientOrder`, `fillingDate`, `ID_orderState`, `ID_client`, `ID_employee`) VALUES (NULL, fillingDate, ID_orderState, ID_client, ID_employee);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MakeWarehouseOrder(
    IN fillingDate DATE,
    IN automaticOrder BOOLEAN,
    IN ID_orderState MEDIUMINT UNSIGNED,
    IN ID_provider MEDIUMINT UNSIGNED,
    IN ID_employee MEDIUMINT UNSIGNED)
BEGIN
INSERT INTO `warehouse`.`warehouseOrders` (`ID_warehouseOrder`, `fillingDate`, `automaticOrder`, `ID_orderState`, `ID_provider`, `ID_employee`) VALUES (NULL, fillingDate, automaticOrder, ID_orderState, ID_provider, ID_employee);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddOrderedWarehouseProduct(
		IN ID_warehouseOrder MEDIUMINT UNSIGNED,
		IN drinkID MEDIUMINT UNSIGNED,
		IN quantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT providersPrice FROM warehouse.drinks WHERE ID_drink = drinkID)*quantity;
INSERT INTO `warehouse`.`warehouseOrderedProducts` (`ID_warehouseOrderedProduct`, `ID_warehouseOrder`, `ID_drink`, `amount`, `totalValue`) VALUES (NULL, ID_warehouseOrder, drinkID, quantity, totalValue);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddOrderedClientProduct(
    IN ID_clientOrder MEDIUMINT UNSIGNED,
    IN drinkID MEDIUMINT UNSIGNED,
    IN quantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT providersPrice FROM warehouse.drinks WHERE ID_drink = drinkID)*quantity*1.23;
INSERT INTO `warehouse`.`clientOrderedDrinks` (`ID_clientOrderedDrink`, `ID_clientOrder`, `ID_drink`, `amount`, `totalValue`) VALUES (NULL, ID_clientOrder, drinkID, quantity, totalValue);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE DeleteDrink(IN id MEDIUMINT UNSIGNED)
BEGIN
DELETE FROM warehouse.drinks WHERE ID_drink = id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CancelClientOrder(IN id MEDIUMINT UNSIGNED)
BEGIN
DELETE FROM warehouse.clientOrderedDrinks WHERE ID_clientOrder = id;
UPDATE warehouse.clientOrders SET ID_orderState = 4 WHERE ID_clientOrder = id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE CancelWarehouseOrder(IN id MEDIUMINT UNSIGNED)
BEGIN
DELETE FROM warehouse.warehouseOrderedProducts WHERE ID_warehouseOrder = id;
UPDATE warehouse.warehouseOrders SET ID_orderState = 4 WHERE ID_warehouseOrder = id;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE ChangeProductQuantity(IN productID MEDIUMINT UNSIGNED, IN newQuantity INT UNSIGNED)
BEGIN
UPDATE warehouse.drinks SET stockAmount = newQuantity WHERE ID_drink = productID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EditProvider(
	IN PARAMproviderID MEDIUMINT UNSIGNED, 
	IN PARAMproviderName VARCHAR(100),
	IN PARAMphoneNumber INT(9) UNSIGNED,
	IN PARAMemail VARCHAR(50),
	IN PARAMstreet VARCHAR(50),
    IN PARAMcity VARCHAR(50))
BEGIN
UPDATE warehouse.providers SET providerName = PARAMproviderName, phoneNumber = PARAMphoneNumber, email = PARAMemail, street = PARAMstreet, city = PARAMcity WHERE ID_provider = PARAMproviderID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EditClient(
	IN PARAMclientID MEDIUMINT UNSIGNED,
	IN PARAMclientName VARCHAR(100),
    IN PARAMnip INT(10) UNSIGNED,
    IN PARAMphoneNumber int(9) UNSIGNED,
    IN PARAMemail VARCHAR(50),
    IN PARAMdiscount INT(3),
    IN PARAMstreet VARCHAR(50),
    IN PARAMcity VARCHAR(50))
BEGIN
UPDATE warehouse.clients SET clientName = PARAMclientName, nip = PARAMnip, phoneNumber = PARAMphoneNumber, email = PARAMemail, discount = PARAMdiscount, street = PARAMstreet, city = PARAMcity WHERE ID_client = PARAMclientID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EditWorker(
	IN PARAMemployeeID MEDIUMINT UNSIGNED,
	IN PARAMlastName VARCHAR(25),
	IN PARAMfirstName VARCHAR (25),
	IN PARAMlogin VARCHAR(128),
	IN PARAMpassword VARCHAR(128),
	IN PARAMphoneNumber INT(9) UNSIGNED,
	IN PARAMemail VARCHAR(50),
	IN PARAMstreet VARCHAR(50),
	IN PARAMcity VARCHAR(50),
	IN PARAMID_position MEDIUMINT UNSIGNED)
BEGIN
UPDATE warehouse.employees SET lastName = PARAMlastName, firstName = PARAMfirstName, login = PARAMlogin, password = PARAMpassword, phoneNumber = PARAMphoneNumber, email = PARAMemail, street = PARAMstreet, city = PARAMcity, ID_position = PARAMID_position WHERE ID_employee = PARAMemployeeID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EditOrderedWarehouseProduct(
	IN PARAMID_orderedWarehouseProduct MEDIUMINT UNSIGNED,
	IN PARAMID_warehouseOrder MEDIUMINT UNSIGNED,
	IN PARAMdrinkID MEDIUMINT UNSIGNED,
	IN PARAMquantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT providersPrice FROM warehouse.drinks WHERE ID_drink = drinkID)*quantity;
UPDATE warehouse.warehouseOrderedProducts SET ID_warehouseOrder = PARAMID_warehouseOrder, ID_drink = PARAMdrinkID, amount = PARAMquantity. totalValue = totalValue WHERE ID_warehouseOrderedProduct = PARAMID_orderedWarehouseProduct;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EditOrderedClientProduct(
	IN PARAMID_orderedClientProduct MEDIUMINT UNSIGNED,
    IN PARAMID_clientOrder MEDIUMINT UNSIGNED,
    IN PARAMdrinkID MEDIUMINT UNSIGNED,
    IN PARAMquantity MEDIUMINT UNSIGNED)
BEGIN
DECLARE totalValue DECIMAL(10,2);
SET totalValue = (SELECT providersPrice FROM warehouse.drinks WHERE ID_drink = drinkID)*quantity*1.23;
UPDATE warehouse.clientOrderedDrinks SET ID_clientOrder = PARAMID_clientOrder, ID_drink = PARAMdrinkID, amount = PARAMquantity, totalValue = totalValue WHERE ID_clientOrderedDrink = PARAMID_orderedClientProduct;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EditDrink(
	IN PARAMID_drink MEDIUMINT UNSIGNED,
    IN PARAMdrinkName VARCHAR(50),
    IN PARAMprovidersPrice DECIMAL(6,2),
  	IN PARAMwithSugar BOOLEAN,
  	IN PARAMwithAlcohol BOOLEAN,
    IN PARAMalcoholDose DECIMAL(4,2),
    IN PARAMfizzy BOOLEAN,
	IN PARAMwarehouseSector VARCHAR(25),
	IN PARAMstockAmount INT UNSIGNED,
    IN PARAMID_pack MEDIUMINT UNSIGNED,
    IN PARAMID_consolidatedPack MEDIUMINT UNSIGNED)
BEGIN
UPDATE warehouse.drinks SET drinkName = PARAMdrinkName, providersPrice = PARAMprovidersPrice, withSugar = PARAMwithSugar, withAlcohol = PARAMwithAlcohol, alcoholDose = PARAMalcoholDose, fizzy = PARAMfizzy, ID_pack = PARAMID_pack, ID_consolidatedPack = PARAMID_consolidatedPack, warehouseSector = PARAMwarehouseSector, stockAmount = PARAMstockAmount WHERE ID_drink = PARAMID_drink;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE FindAllOrdersInProgress()
BEGIN
SELECT *
FROM(SELECT * FROM warehouse.clientOrders WHERE ID_orderState = 2) AS T1
NATURAL JOIN(SELECT * FROM warehouse.warehouseOrders WHERE ID_orderState = 2) AS T2;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindWarehouseOrderByDate(IN searchDate DATE)
BEGIN
SELECT * FROM warehouse.warehouseOrderedProducts WHERE searchData = fillingDate;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindWarehouseOrderByProvider(IN provider VARCHAR(100))
BEGIN
SELECT * FROM warehouse.warehouseOrderedProducts
	JOIN warehouse.providers ON ID_provider
    WHERE warehouse.providers.providerName LIKE provider;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindWarehouseOrderByWorker(IN name VARCHAR(25))
BEGIN
SELECT * FROM warehouse.warehouseOrderedProducts
	JOIN warehouse.employees ON ID_employee
    WHERE warehouse.employees.lastName LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindDrink(IN name VARCHAR(50))
BEGIN
SELECT * FROM warehouse.warehouseOrderedProducts
    WHERE warehouse.drinks.drinkName LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindClientOrder(IN name VARCHAR(100))
BEGIN
SELECT * FROM warehouse.clientOrders
	JOIN warehouse.clients ON ID_client
    WHERE warehouse.clients.clientName LIKE name AND warehouse.clientOrders.ID_orderState = 2;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindProvider(IN name VARCHAR(100))
BEGIN
SELECT * FROM warehouse.providers
    WHERE providerName LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindClientByName(IN name VARCHAR(100))
BEGIN
SELECT * FROM warehouse.clients
    WHERE clientName LIKE name;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindClientByNIP(IN NIPnumber INT(10))
BEGIN
SELECT * FROM warehouse.clients
    WHERE nip = NIPnumber;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE FindWorkerByName(IN name VARCHAR(25))
BEGIN
SELECT * FROM warehouse.employees
    WHERE lastName LIKE name;
END //
DELIMITER ;




DELIMITER //
CREATE PROCEDURE FindDataForBill(IN id MEDIUMINT UNSIGNED)
BEGIN
DECLARE clientID MEDIUMINT UNSIGNED;
SET clientID = (SELECT ID_client FROM warehouse.clientOrders 
                       		WHERE id = ID_clientOrder);
                            
CREATE TEMPORARY TABLE tmp
(
    tmpID MEDIUMINT UNSIGNED NOT NULL,
    productName VARCHAR(50),
    quantity MEDIUMINT UNSIGNED,
    rowValue DECIMAL(10,2)
);
INSERT INTO tmp (tmpID, productName, quantity, rowValue)
	SELECT warehouse.drinks.ID_drink, warehouse.drinks.drinkName, warehouse.clientOrderedDrinks.amount, warehouse.clientOrderedDrinks.totalValue
    	FROM warehouse.clientOrderedDrinks JOIN warehouse.drinks ON warehouse.clientOrderedDrinks.ID_drink = warehouse.drinks.ID_drink
        WHERE id = warehouse.clientOrderedDrinks.ID_clientOrder;
                            

SELECT *
FROM		(SELECT fillingDate FROM warehouse.clientOrders 
     			WHERE id = ID_clientOrder) AS T1
                
NATURAL JOIN(SELECT clientName, nip, street, city FROM warehouse.clients
				WHERE (clientID) = ID_client) AS T2
                            
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
	SELECT warehouse.clientOrderedDrinks.ID_clientOrder, warehouse.drinks.drinkName, warehouse.clientOrderedDrinks.amount, warehouse.clientOrderedDrinks.totalValue
    	FROM warehouse.clientOrderedDrinks JOIN warehouse.drinks ON warehouse.clientOrderedDrinks.ID_drink = warehouse.drinks.ID_drink
        WHERE id = warehouse.clientOrderedDrinks.ID_clientOrder;

CREATE TEMPORARY TABLE tmpH
(
    tmpID MEDIUMINT UNSIGNED NOT NULL,
    productName VARCHAR(50),
    quantity MEDIUMINT UNSIGNED,
    rowValue DECIMAL(10,2)
);
		

INSERT INTO tmpH (tmpID, productName, quantity, rowValue)
	SELECT warehouse.warehouseOrderedProducts.ID_warehouseOrder, warehouse.drinks.drinkName, warehouse.warehouseOrderedProducts.amount, warehouse.warehouseOrderedProducts.totalValue
    	FROM warehouse.warehouseOrderedProducts JOIN warehouse.drinks ON warehouse.warehouseOrderedProducts.ID_drink = warehouse.drinks.ID_drink
        WHERE id = warehouse.warehouseOrderedProducts.ID_warehouseOrder;
                            

SELECT * FROM
	(	SELECT warehouse.clients.clientName, tmpK.productName, tmpK.quantity, tmpK.rowValue 
		FROM tmpK 	JOIN warehouse.clientOrders ON tmpK.tmpID = warehouse.clientOrders.ID_clientOrder
			  		JOIN warehouse.clients ON warehouse.clientOrders.ID_client = warehouse.clients.ID_client
		WHERE fillingDate BETWEEN startDate AND endDate
    ) AS T1
    NATURAL JOIN
    (
        SELECT "hurtownia", tmpH.productName, tmpH.quantity, tmpH.rowValue 
		FROM tmpH JOIN warehouse.warehouseOrders ON tmph.tmpID = warehouse.warehouseOrders.ID_warehouseOrder
		WHERE fillingDate BETWEEN startDate AND endDate
    ) AS T2;


		
END //
DELIMITER ;


