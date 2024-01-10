CREATE DATABASE Company_Tracking;

CREATE TABLE Drivers (
	DID int NOT NULL,
	DName varchar(255),
	DAddress varchar(255),
	DPhoneNum varchar(255),
	PRIMARY KEY (DID)
);

INSERT INTO Drivers (DID, DName, DAddress, DPhoneNum)
values
(1,'Dave Watson','32 Wood Road','07856 456875'),
(2,'Jeff Wood','89 High Street','07565 358964'),
(3,'Ellie Norman','74 Orchard Street','07562 456982'),
(4,'Richard Baker','5 Orchid Close','07854 123845'),
(5,'Lewis Taylor','25 Dorchester Way','07796 115486'),
(6,'Charles Higham','5b Forest Lane','07852 369555'),
(7,'George Ingham','23 Back Hill','07412 868989'),
(8,'Karen Smith','45 Kings Avenue','07654 465795'),
(9,'Susan Northern','10 Willow Close','07050 357159'),
(10,'Steven Williams','5 Ouse Road','07268 475213');

CREATE TABLE Vehicles (
	VID int NOT NULL,
	VMake varchar(255),
	VModel varchar(255),
	VRegistration varchar(255),
	PRIMARY KEY(VID)
);

INSERT INTO Vehicles (VID, VMake, VModel, VRegistration)
values
(1,'Ford','Transit','AE05 HFR'),
(2,'Renault','Trafic','BC12 JUR'),
(3,'Ford','Trandsit','AK57 OCR'),
(4,'Vauxhall','Combo','AD59 PGY'),
(5,'Vauxhall','Vivaro','MA12 ADF');

CREATE TABLE Shift_Days (
	SDID int NOT NULL,
	SDDay varchar(255),
	SDMorning BOOLEAN,
	SDAfternoon BOOLEAN,
	PRIMARY KEY(SDID)
);

INSERT INTO Shift_Days(SDID, SDDay, SDMorning, SDAfternoon)
values
(1,'Monday',1,0),
(2,'Monday',0,1),
(3,'Tuesday',1,0),
(4,'Tuesday',0,1),
(5,'Wednesday',1,0),
(6,'Wednesday',0,1),
(7,'Thursday',1,0),
(8,'Thursday',0,1),
(9,'Friday',1,0),
(10,'Friday',0,1);

CREATE TABLE Shifts (
	SDID int NOT NULL,
	DID int NOT NULL,
	VID int NOT NULL,
	FOREIGN KEY(SDID) REFERENCES Shift_Days(SDID),	
	FOREIGN KEY(DID) REFERENCES Drivers(DID),
	FOREIGN KEY(VID) REFERENCES Vehicles(VID)
);

INSERT INTO Shifts (SDID, DID, VID)
values 
(1,10,5),
(1,9,3),
(1,8,1),
(1,7,2),
(2,6,1),
(2,5,5),
(2,4,4),
(2,3,3),
(3,2,2),
(3,1,4),
(3,10,3),
(3,9,1),
(4,8,1),
(4,7,2),
(4,6,4),
(4,5,5),
(5,4,3),
(5,3,4),
(5,2,5),
(5,1,1),
(6,10,2),
(6,9,3),
(6,8,1),
(6,7,5),
(7,6,2),
(7,5,3),
(7,4,1),
(7,3,4),
(8,2,5),
(8,1,3),
(8,10,1),
(8,9,4),
(9,8,1),
(9,7,2),
(9,6,3),
(9,5,5),
(10,4,5),
(10,3,4),
(10,2,3),
(10,1,2);

CREATE TABLE Tracking (
	TID int NOT NULL,
	TNearestTown varchar(255),
	TLongitude varchar(255),
	TLatitude varchar(255),
	DID int NOT NULL,
	FOREIGN KEY (DID) REFERENCES Drivers (DID),
	PRIMARY KEY (TID)	
);

INSERT INTO Tracking (TID, TNearestTown, TLongitude, TLatitude, DID)
values
(1,'Waddington','-0.5397222222222222','53.1723611',10),
(2,'Swinderby','-0.7091944444444443','53.1519444',9),
(3,'North Hykeham','-0.618638888888889','53.2025833',8),
(4,'Lincoln','-0.526888888888889','53.2433889',7), 
(5,'Market Rasen','-0.38063888888888886','53.3668333',3), 
(6,'Skellingthorpe','-0.6065277777777778','53.2307778',2);

CREATE TABLE Parcels (
	DID int NOT NULL,
	DParcelsDelivered int NOT NULL,
	FOREIGN KEY (DID) REFERENCES Drivers (DID),
	PRIMARY KEY (DID)
);

INSERT INTO Parcels (DID, DParcelsDelivered)
values
(1,20),
(2,18),
(3,25),
(4,24),
(5,26),
(6,21),
(7,21),
(8,24),
(9,20),
(10,23);

/*
SELECT tracking.TNearestTown, shifts.DID, shifts.VID
FROM tracking, shifts
WHERE 
tracking.DID = shifts.DID
AND 
shifts.SDID = 1


SELECT parcels.DID, parcels.DParcelsDelivered 
FROM parcels 
WHERE DID = 1 


SELECT drivers.DName, drivers.DAddress, drivers.DPhoneNum 
FROM drivers 


SELECT drivers.DName, drivers.DAddress, drivers.DPhoneNum
FROM drivers, shifts
WHERE 
shifts.SDID = 1 AND shifts.DID = drivers.DID
OR
shifts.SDID = 3 AND shifts.DID = drivers.DID
OR
shifts.SDID = 5 AND shifts.DID = drivers.DID
OR
shifts.SDID = 7 AND shifts.DID = drivers.DID
OR
shifts.SDID = 9 AND shifts.DID = drivers.DID

SELECT drivers.DName, drivers.DAddress, drivers.DPhoneNum
FROM drivers, shifts
WHERE 
shifts.SDID = 1 AND shifts.DID = drivers.DID
*/

DELIMITER //

CREATE PROCEDURE showdrivers()
BEGIN
	SELECT drivers.DName, drivers.DAddress, drivers.DPhoneNum 
		FROM drivers;
END //

CREATE PROCEDURE showshifts(IN shiftIndex int)
BEGIN
	SELECT drivers.DName, drivers.DAddress, drivers.DPhoneNum
		FROM drivers, shifts
		WHERE 
		shifts.SDID = shiftIndex AND shifts.DID = drivers.DID;
END //

DELIMITER ;

call showdrivers;
call showshifts(1);


