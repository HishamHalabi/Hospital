Create database ayhaga12
use ayhaga12

CREATE TABLE Patient(
    PatientID VARCHAR(60) PRIMARY KEY,
    full_name VARCHAR(50),
    Gender VARCHAR(6),
    DOB DATE,
    Address VARCHAR(100),
    Age INT
);

CREATE TABLE Departments (
    DepartmentID varchar(60) PRIMARY KEY,
    Name VARCHAR(50),
    Location VARCHAR(50),
);

CREATE TABLE Doctors (
    DoctorID varchar(60) PRIMARY KEY,
    Name varchar(50),
    Specialization VARCHAR(50),
	Address varchar(50),
	DepartmentID varchar(60),
	foreign key(DepartmentID) references Departments(DepartmentID),
);


CREATE TABLE Nurses (
    NurselD varchar(60) PRIMARY KEY,
    Name VARCHAR(50),
	Gender VARCHAR(6),
	Address varchar(50),
	DepartmentID varchar(60),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Rooms (
    RoomID VARCHAR(60) PRIMARY KEY,
    Location VARCHAR(50),
	PatientID varchar(60) UNIQUE,
    Type VARCHAR(50),
	Status varchar(50),
	FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
);

Create table Nurse_Room (
	RoomID VARCHAR(60) FOREIGN KEY REFERENCES Rooms(RoomID),
	NurselD varchar(60) FOREIGN KEY REFERENCES Nurses(NurselD),
	CONSTRAINT PK_Nurse_Room PRIMARY KEY (NurselD,RoomID),
);

Create table Medicine(
	Med_ID varchar(60) PRIMARY KEY,
	Name Varchar(50),
	price INT,
	Quantity INT,
);

Create table Prescription(
	PrescriptionID varchar(60) PRIMARY KEY,
	DoctorID VARCHAR(60) FOREIGN KEY REFERENCES Doctors(DoctorID),
	PatientID varchar(60) FOREIGN KEY REFERENCES Patient(PatientID),
	
);

Alter table Prescription 
ADD Dosage varchar(100);



Create table Bill(
	Bill_ID varchar(60) PRIMARY KEY,
	PatientID varchar(60) FOREIGN KEY REFERENCES Patient(PatientID),
	room_chargers INT,
	doc_chargers INT,
	medicine_chargers INT,
);

create table Payment(
	payment_ID varchar(50) primary key,
	Bill_ID varchar(60) UNIQUE,
	FOREIGN KEY (Bill_ID) REFERENCES Bill(Bill_ID),
    Type VARCHAR(50),
	Status varchar(50),
);

CREATE TABLE Admissions (
    AdmissionID varchar(60) PRIMARY KEY,
    PatientID varchar(60),
    DoctorID varchar(60),
    DateAdmitted DATE,
    DateDischarged DATE,
    Reason VARCHAR(100),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Appointments (
    AppointmentID varchar(60) PRIMARY KEY,
    PatientID varchar(60),
    DoctorID varchar(60),
    Date DATE,
    Time TIME,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);


CREATE TABLE Surgeries (
    SurgeryID varchar(60) PRIMARY KEY,
    DoctorID varchar(60),
    PatientID varchar(60),
    Date DATE,
	Time TIME,
    Type VARCHAR(50),
    RoomID varchar(60),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

create table Patient_Phone(
	PatientID varchar(60) FOREIGN KEY REFERENCES Patient(PatientID),
	Phone varchar(11),
	CONSTRAINT PK_Patient_Phone PRIMARY KEY (PatientID,Phone),
);

create table Doctor_cont(
    DoctorID varchar(60),
	FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
	contact varchar(50),
	CONSTRAINT PK_Doctor_cont PRIMARY KEY (DoctorID,contact),
);

create table Nurse_cont(
    NurselD varchar(60),
	FOREIGN KEY (NurselD) REFERENCES Nurses(NurselD),
	contact varchar(50),
	CONSTRAINT PK_Nurse_cont PRIMARY KEY (NurselD,contact),
);

alter table Prescription drop constraint  FK__Prescript__Docto__37A5467C;
alter table Prescription drop column DoctorID;

create table Description(
Desc_ID varchar(60) primary key,
PatientID varchar(60) foreign key references Patient(PatientID),
DoctorID varchar(60) foreign key references Doctors(DoctorID),
surgeries BIT default 0,
description varchar(100),
desc_date DATE,
);

alter table prescription add
Desc_ID varchar(60)
foreign key references Description(Desc_ID);


create table pre_med
(
       MED_ID varchar(60) , 
	   Pre_ID    varchar(60) ,  

	   constraint fk1  foreign key (MED_ID) references Medicine (Med_ID) ,
	   constraint fk2  foreign key (pre_ID) references prescription(prescriptionID)
);


create table Nursesurgey 

(
      NurseID  varchar(60), 
	  surgeryID  varchar(60)

	  ,
	   constraint fk11  foreign key (NurseID) references nurses (NurselD) ,
	   constraint fk12  foreign key (surgeryID) references Surgeries(surgeryID)
);