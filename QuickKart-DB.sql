﻿create database QuickCartDB


create table Product
(
ProductID int identity primary key,
ProductName varchar(50),
ProductPrice numeric(10),
Vendor varchar(50),
Discount int,
ProductImage varchar(1000)
)

insert into Product values('Sony Camera',20000,'Sony India',10,'https://ctb35komal.blob.core.windows.net/productimages/Point_and_shoot_cameras.jpg')
insert into Product values('Samsung TV',34000,'Samsung India',20,'https://ctb35komal.blob.core.windows.net/productimages/TV.jpg')
insert into Product values('Apple watch',30000,'Apple India',12,'https://ctb35komal.blob.core.windows.net/productimages/watch.jpg')
insert into Product values('TMC Protien',4000,'TMC India',15,'https://ctb35komal.blob.core.windows.net/productimages/supplement.jpg')
insert into Product values('US Polo Shirt',2500,'US Polo India',17,'https://ctb35komal.blob.core.windows.net/productimages/shirt.jpg')
insert into Product values('Aviator Eye glass',1000,'Aviator India',20,'https://ctb35komal.blob.core.windows.net/productimages/eye_wear.jpg')
insert into Product values('Spyker Jeans',2000,'Spyker India',50,'https://ctb35komal.blob.core.windows.net/productimages/jeans.jpg')
insert into Product values('Jumpsuit',500,'Rst India',20,'https://ctb35komal.blob.core.windows.net/productimages/jumpsuit.jpg')

----------------------------------------------------------------------------------------

create table Subscribers
(
subscriberID int identity primary key,
emailID varchar(100) unique

)

--This procedure will add the subscriber, so these subscribers will get special offers!
go
create proc usp_AddSubscriber
(
@emailID varchar(100)
)
as
begin
	declare @subscriberEmail varchar(100)
	begin try
	select @subscriberEmail=emailID from Subscribers where emailID=@emailID
	if(@subscriberEmail is null)
	begin
		insert into Subscribers values (@emailID)
		return 1
	end
	else
		return 0
	end try
	begin catch
		return -1
	end catch
end


declare @res int
exec @res=usp_AddSubscriber 'siddharthd1@cloudthat.com'
select @res

Go 

select * from Subscribers

--------------------------------------------------------------------------------------------

create table Customers
(
customerID int identity(1000,1) primary key,
emailID   varchar(50) unique,
FirstName varchar(50),
LastName  varchar(50),
Pincode   numeric(6),
[password] varchar(50),
userType char(1)
)

insert into Customers values('siddharthd@cloudthat.com','Siddharth','Dwivedi',231216,'Kmail@1234','c')
-----------------------------------------------------------------------------------------------

create table Vendors
(
vendorID   int   identity primary key,
vendorName varchar(200),
vendorEmailID  varchar(200),
vendorPassword varchar(200),
customerType char(1) default 'v'
)

insert into vendors(vendorName,vendorEmailID,vendorPassword) values('Reebok','Rebok@quickcart.com','Kmail@1234')
insert into vendors values('Adidas','Adidas@quickcart.com','Kmail@1234')
insert into vendors values('Apple','Apple@quickcart.com','Kmail@1234')
insert into vendors values('Oneplus','Oneplus@quickcart.com','Kmail@1234')


GO

--This function will perform login validation
alter function ufn_ValidateLogin
( 
@userEmailID varchar(50),
@userPassword varchar(50),
@customerType varchar(2)
)
returns int
as
begin
	if(@customerType='c')
	begin
		if exists(select 1 from Customers where emailID=@userEmailID and [password]=@userPassword)
		return 1 --Pos
	end
	else if(@customerType='v')
	begin
		if exists(select 1 from Vendors where vendorEmailID=@userEmailID and vendorPassword=@userPassword)
		return 2 --Pos
	end
	else
		return 3 --Neg
	return -1 --Super Neg
end

GO

select [dbo].ufn_ValidateLogin('siddharthd@cloudthat.com','Kmail@1234','c')

go




