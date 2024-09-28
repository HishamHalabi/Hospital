--show all patient
create procedure SP_selectAllPatient
as
select * from Patient
go;

exec SP_selectAllPatient;


--show patient by id
create procedure SP_selectPatientByID
@PatientID varchar(60)
as
select * from Patient 
where PatientID = @PatientID;

exec SP_selectPatientByID @PatientID = 'P001';


--add new patient
create procedure SP_insertIntoPatient 
@PatientID varchar(60),
@Name varchar(50),
@Gender varchar(6),
@date Date,
@address varchar(100),
@Age int,
@phone varchar(11)
as
insert into Patient(PatientID,full_name,Gender,DOB,Address,Age) 
values (@PatientID,@Name,@Gender,@date,@address,@Age);
insert Into Patient_Phone(PatientID,Phone) values(@PatientID,@phone);

exec SP_insertIntoPatient @PatientID='P004',@Name='Moamen Reda',@Gender='Male',@date='2004-11-03',
@address='3 hassen ben hythem,sadat city', @Age = 19,@phone='01063125460';


-- update age
create Procedure SP_UpdateAgeByID
@PatientID varchar(60),
@age int
as
update Patient Set
Age = @age where PatientID = @PatientID;

exec SP_UpdateAgeByID @PatientID = 'P004',@age = 20;


-- add phone to patient (phone multi valued)
create procedure SP_addPatientPhone
@PatientID varchar(60),
@phone varchar(11)
as
insert Into Patient_Phone(PatientID,Phone)
values (@PatientID,@phone);

exec SP_addPatientPhone @PatientID = 'P004',@phone='01228722987';


-- show all phones related to patient
create Procedure SP_showAllPatientPhone
@PatientID varchar(60)
as
select * from Patient_Phone
where PatientID = @PatientID;

exec SP_showAllPatientPhone @PatientID = 'P004';


------------------------------------------------------------------------------------------------------------

--Assign Nurse to Room
create procedure SP_assignNurseToRoom 
@RoomID varchar(60),
@NurseID varchar(60)
as
insert into Nurse_Room(RoomID,NurselD)
values(@RoomID,@NurseID);

--Cancel Assign
create procedure SP_cancelNurseFromRoom 
@RoomID varchar(60),
@NurseID varchar(60)
as
Delete From Nurse_Room
where RoomID = @RoomID AND NurselD = @NurseID;

------------------------------------------------------------------------------------------------------------

--Book a new appointment
Create procedure SP_BookNewAppointment
@Appo_ID varchar(60),
@PatientID varchar(60),
@DoctorID varchar(60),
@date Date,
@time Time
as
insert into Appointments(AppointmentID,PatientID,DoctorID,Date,Time)
values(@Appo_ID,@PatientID,@DoctorID,@date,@time);

--show all appointment in day
Create procedure SP_showAppointmentInDay
@day Date
as
select * from Appointments
where Date = @day;

--show all appointment by doctor 
create procedure SP_showAppointmentByDoctor
@DoctorID varchar(60)
as
select * from Appointments where
DoctorID = @DoctorID;


create procedure SP_changeAppointmentDate
@date Date,
@Appo_ID varchar(60)
as
update Appointments 
Set Date = @date
where AppointmentID = @Appo_ID;
--------------------------------------------------------------------------------------------------------

create procedure SP_showTotalPatient
as
select Count(*) as [Total Patient] from
Patient
go;

create procedure SP_totalBenfits
as
select sum(room_chargers) as [total room chargers],
sum(doc_chargers) as [total Doctors chargers],
sum(medicine_chargers) as [total medicine chargers]
from Bill
go;

------------------------------------------------------------------------------------