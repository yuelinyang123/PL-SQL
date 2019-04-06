drop view balance_not_paid_customer;
drop view deliver_management;
drop trigger customer_pay_balance;
drop trigger valid_new_contract;
drop trigger new_item_check;
drop sequence cust_sequence;
drop sequence deliver_person;
drop sequence deliver_service_sequence;
drop sequence deliver_route_sequence;
drop sequence item_sequence;
drop sequence contract_sequence;
drop sequence evaluate_sequence;
drop sequence client_sequence;
drop sequence lead_sequence;
drop sequence evaluate_item_sequence;
drop sequence employee_sequence;
drop sequence bill_sequence;
drop table customer cascade CONSTRAINTS;
drop table employee cascade CONSTRAINTS;
drop table deliver_person cascade constraints;
drop table deliver_service cascade constraints;
drop table deliver_route cascade constraints;
drop table item cascade constraints;
drop table contract cascade constraints;
drop table contract_detail cascade constraints;
drop table bill cascade constraints;
drop table deliver_item cascade constraints;
drop table monthly_fee cascade constraints;
drop table evaluation cascade constraints;
drop table potential_client cascade constraints;
drop table lead cascade constraints;
drop table pickup_item cascade constraints;
drop table service_denormal;
drop package billing;
drop procedure call_package;
drop procedure bill;
drop procedure bill_detail;
drop procedure total_bill;
drop function total_charge;
drop function total_discount;
drop function late_fee;




PROMPT
PROMPT Creating sequence employee_sequence
CREATE SEQUENCE employee_sequence
START WITH 1000 INCREMENT BY 1;
PROMPT Creatinig table employee
CREATE TABLE employee(
Employee_ID 	INTEGER 			NOT NULL,
Position		VARCHAR2(50),
F_Name			VARCHAR2(50)	NOT NULL,
L_Name          VARCHAR2(50)	NOT NULL,
Phone 		    VARCHAR2(20),
Fax				VARCHAR2(20),
Email			VARCHAR2(30),
Street			VARCHAR2(50),
City			VARCHAR2(30),
State			VARCHAR2(30),
Zip 			VARCHAR2(30),
Gender			VARCHAR2(10),
Race			VARCHAR2(30),
age  			INTEGER,
Tax_payer_ID    INTEGER,
Date_hired		DATE
);

CREATE SEQUENCE cust_sequence
START WITH 2000 INCREMENT BY 1;
CREATE TABLE customer(
	customer_id		INTEGER			NOT NULL,
	customer_name	VARCHAR2(30)	NOT NULL,
	contact_fname	VARCHAR2(30)	NOT NULL,
	contact_lname	VARCHAR2(30)	NOT NULL,
	account_id		INTEGER,
	phone			VARCHAR2(30),
	deliver_route_id		INTEGER,
	company_size			INTEGER,
	refer_by				INTEGER,
	transaction_date        DATE,
	current_balance 		NUMERIC(15, 2),	
    status                  VARCHAR2(30),
    refer_date              DATE
);

PROMPT
PROMPT Creating table deliver_person
CREATE TABLE deliver_person(
Employee_ID 		INTEGER 			NOT NULL,
Employee_ID1		INTEGER 			,
CDL					VARCHAR2(30)
);

CREATE SEQUENCE deliver_service_sequence
START WITH 3000 INCREMENT BY 1;
PROMPT
PROMPT Creating Table DELIVER_SERVICE
CREATE TABLE deliver_service(
	service_id	        INTEGER		NOT NULL,
	deliver_route_id	INTEGER		NOT NULL,
	vehicle				VARCHAR2(30),
	time_arrived		DATE,
	time_departed		DATE,
	employee_id			INTEGER,
	customer_id 		INTEGER,
	location_address 			VARCHAR2(30),
	customer_comment	VARCHAR2(300),
	driver_comment		VARCHAR2(300)
);

PROMPT Creating sequence deliver_route_sequence
CREATE SEQUENCE deliver_route_sequence
START WITH 4000 INCREMENT BY 1;
PROMPT
PROMPT Creating Table DELIVER_ROUTE
CREATE TABLE deliver_route(
	deliver_route_id		INTEGER		NOT NULL,
	distance				NUMERIC(10, 1)
);

CREATE SEQUENCE item_sequence
START WITH 5000 INCREMENT BY 1;
PROMPT Creatinig table item
CREATE TABLE item(
Item_ID 		INTEGER 		NOT NULL,
Name			VARCHAR2(50)	NOT NULL,
Price			NUMBER(10,2),	
Description		VARCHAR2(50),
Quantity		INTEGER
);

PROMPT Creating sequence contract_sequence
CREATE SEQUENCE contract_sequence
START WITH 6000 INCREMENT BY 1;
PROMPT
PROMPT Creating Table CONTRACT
CREATE TABLE contract(
	contract_id     INTEGER 		NOT NULL,
	contact_fname	VARCHAR(30)		NOT NULL,
	contact_lname	VARCHAR(30)		NOT NULL,
	customer_id		INTEGER			NOT NULL,
	employee_id		INTEGER,
	method_of_payment	VARCHAR2(30),
	contract_date			DATE,
	service_start_date	DATE,
	est_monthly_cost	NUMERIC(15, 2)
);

PROMPT Creating Table CONTRACT_DETAIL
CREATE TABLE contract_detail(
	contract_id		INTEGER		NOT NULL,
	room			VARCHAR2(30)	NOT NULL,
	location_address		VARCHAR2(30),
	item_id			INTEGER,
	est_frequency	NUMERIC, 
	deposit			NUMERIC(15, 2),
	initial_charge	NUMERIC(15, 2)
);

PROMPT
PROMPT Creating sequence cust_sequence
CREATE SEQUENCE bill_sequence
START WITH 7000 INCREMENT BY 1;
PROMPT Creating Table bill
CREATE TABLE bill(
	bill_id		        INTEGER		    NOT NULL,
	customer_id	        INTEGER  	    NOT NULL,
	start_date      	DATE    	    NOT NULL,
	end_date      	    DATE    	    NOT NULL,
	employee_id			INTEGER          NOT NULL,
	date_due 			DATE
);

PROMPT Creating Table DELIVER_ITEM
CREATE TABLE deliver_item(
	service_id		INTEGER		NOT NULL,
	item_id			INTEGER,
	quantity		INTEGER
);


PROMPT Creating Table PICKEDUP_ITEM
CREATE TABLE pickup_item(
	service_id	INTEGER		NOT NULL,
	item_id		INTEGER,
	partial		NUMERIC,
	empty		NUMERIC,
	full_bottle		NUMERIC
);



PROMPT Creating Table monthly_fee
CREATE TABLE monthly_fee(
	bill_id		    		INTEGER		NOT NULL,
	location_address		VARCHAR2(30),
	Fee 					NUMERIC(15, 2)
);

PROMPT
PROMPT Creating sequence evaluate_sequence
CREATE SEQUENCE evaluate_sequence
START WITH 8000 INCREMENT BY 1;
PROMPT Creating Table EVALUATION
CREATE TABLE evaluation(
	evluation_id		INTEGER		NOT NULL,
	employee_id			INTEGER,
	employee_id1		INTEGER,
	evaluate_comment	VARCHAR2(300),
	total_evaluate		NUMERIC, 
	eval_date			DATE
)
;

PROMPT Creating sequence client_sequence
CREATE SEQUENCE client_sequence
START WITH 9000 INCREMENT BY 1;
PROMPT
PROMPT Creating Table POTENTIAL_CLIENT
CREATE TABLE potential_client(
	client_id			INTEGER			NOT NULL,
	contact_name		VARCHAR2(30)	NOT NULL,
	person_fname		VARCHAR2(30)	NOT NULL,
	person_lname		VARCHAR2(30)	NOT NULL,
	phone				VARCHAR2(30),
	type_of_client		VARCHAR2(30)
);

PROMPT
PROMPT Creating sequence lead_sequence
CREATE SEQUENCE lead_sequence
START WITH 11000 INCREMENT BY 1;
PROMPT Creating Table LEAD

CREATE TABLE lead(
	lead_id			INTEGER		NOT NULL,
	employee_id		INTEGER,
	customer_id		INTEGER,
	client_id		INTEGER,
	lead_comment	VARCHAR2(300)

);


PROMPT Adding PRIMARY Constraint To CUSTOMER Table
ALTER TABLE customer ADD (
		CONSTRAINT cust_PK1
		PRIMARY KEY (customer_id)
);

PROMPT Adding PRIMARY Constraint To EMPLOYEE Table
ALTER TABLE employee ADD (
		CONSTRAINT employ_PK1
		PRIMARY KEY (employee_id)
);

ALTER TABLE deliver_service ADD (
		CONSTRAINT deliverservice_PK1
		PRIMARY KEY (service_id)
);

ALTER TABLE deliver_person ADD (
		CONSTRAINT deliverperson_PK1
		PRIMARY KEY (employee_id)
);

PROMPT Adding PRIMARY Constraint To DELIVER_ROUTE Table
ALTER TABLE deliver_route ADD (
      CONSTRAINT deliver_route_PK1
      PRIMARY KEY (deliver_route_id)
);


ALTER TABLE item ADD (
    CONSTRAINT item_PK1
    PRIMARY KEY (item_id)
);

PROMPT Adding PRIMARY Constraint To CONTRACT Table
ALTER TABLE contract ADD (
      CONSTRAINT contract_PK1
      PRIMARY KEY (contract_id)
);

ALTER TABLE contract_detail ADD (
      CONSTRAINT contract_detail_PK1
      PRIMARY KEY (contract_id, location_address)
);

ALTER TABLE deliver_item ADD (
      CONSTRAINT deliver_item_PK1
      PRIMARY KEY (service_id, item_id)
);

ALTER TABLE pickup_item ADD (
      CONSTRAINT pickup_item_PK1
      PRIMARY KEY (service_id, item_id)
);

PROMPT Adding PRIMARY Constraint To bill TABLE
ALTER TABLE bill ADD (
		CONSTRAINT bill_PK1
		PRIMARY KEY (bill_id)
);

PROMPT Adding Primary Constraint(location, ill_id) To monthly_fee TABLE
ALTER TABLE monthly_fee ADD (
      CONSTRAINT monthly_fee_PK1
      PRIMARY KEY (location_address, bill_id)
);


PROMPT Adding PRIMARY Constraint To Evaluation Table
ALTER TABLE evaluation ADD (
		CONSTRAINT evaluation_PK1
		PRIMARY KEY (evluation_id)
)
;

PROMPT Adding PRIMARY Constraint To Lead Table
ALTER TABLE lead ADD (
		CONSTRAINT lead_PK1
		PRIMARY KEY (lead_id)
)
;

PROMPT Adding PRIMARY Constraint To POTENTIAL_CLIENT Table
ALTER TABLE potential_client ADD (
      CONSTRAINT client_id_PK1
      PRIMARY KEY (client_id)
)
;

PROMPT Adding FOREIGN Constraint To CUSTOMER Table referring DELIVERY_ROUTE
ALTER TABLE customer ADD (
      CONSTRAINT cust_FK1
      FOREIGN KEY (deliver_route_id)
      REFERENCES  DELIVER_ROUTE (deliver_route_id)
	on delete cascade
);

PROMPT Adding FOREIGN Constraint To deliver_person Table referring employee
ALTER TABLE deliver_person ADD (
      CONSTRAINT deliverperson_FK1
      FOREIGN KEY (Employee_ID)
      REFERENCES  employee (Employee_ID)
	on delete cascade
);

PROMPT Adding FOREIGN Constraint To deliver_person Table referring employee
ALTER TABLE deliver_person ADD (
      CONSTRAINT deliverperson_FK2
      FOREIGN KEY (Employee_ID1)
      REFERENCES  DELIVER_PERSON (Employee_ID)
	on delete cascade
);


ALTER TABLE deliver_service ADD (
      CONSTRAINT deliverservice_FK1
      FOREIGN KEY (deliver_route_id)
      REFERENCES  DELIVER_ROUTE (deliver_route_id)
	on delete cascade
);

ALTER TABLE deliver_service ADD (
      CONSTRAINT deliverservice_FK2
      FOREIGN KEY (employee_id)
      REFERENCES  DELIVER_PERSON (employee_id)
	on delete cascade
);

ALTER TABLE deliver_service ADD (
      CONSTRAINT deliverservice_FK3
      FOREIGN KEY (customer_id)
      REFERENCES  CUSTOMER (customer_id)
	on delete cascade
);

ALTER TABLE contract ADD (
      CONSTRAINT contract_FK1
      FOREIGN KEY (customer_id)
      REFERENCES  CUSTOMER (customer_id)
	on delete cascade
);

ALTER TABLE contract ADD (
      CONSTRAINT contract_FK2
      FOREIGN KEY (employee_id)
      REFERENCES  EMPLOYEE (employee_id)
	on delete cascade
);


ALTER TABLE contract_detail ADD (
      CONSTRAINT sale_contract_FK1
      FOREIGN KEY (contract_id)
      REFERENCES  CONTRACT (contract_id)
	on delete cascade
);



ALTER TABLE deliver_item ADD (
      CONSTRAINT deliver_item_FK1
      FOREIGN KEY (service_id)
      REFERENCES  DELIVER_SERVICE (service_id)
	on delete cascade
);

ALTER TABLE deliver_item ADD (
      CONSTRAINT deliver_item_FK2
      FOREIGN KEY (item_id)
      REFERENCES  ITEM (item_id)
	on delete cascade
);


ALTER TABLE pickup_item ADD (
      CONSTRAINT pickup_item_FK1
      FOREIGN KEY (service_id)
      REFERENCES  DELIVER_SERVICE (service_id)
	on delete cascade
);

ALTER TABLE pickup_item ADD (
      CONSTRAINT pickup_item_FK2
      FOREIGN KEY (item_id)
      REFERENCES  ITEM (item_id)
	on delete cascade
);


PROMPT Adding Foreign Constraint(customer_id) To bill TABLE
ALTER TABLE bill ADD (
		CONSTRAINT bill_FK1
        FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        on delete cascade
);

PROMPT Adding Foreign Constraint(employee_id) To bill TABLE
ALTER TABLE bill ADD (
		CONSTRAINT bill_FK2
        FOREIGN KEY (employee_id)
        REFERENCES employee (employee_id)
        on delete cascade
);


PROMPT Adding Foreign Constraint(bill_id) To monthly_fee TABLE
ALTER TABLE monthly_fee ADD (
		CONSTRAINT monthly_fee_FK1
        FOREIGN KEY (bill_id)
        REFERENCES bill (bill_id)
        on delete cascade
);


PROMPT Adding Foreign Constraint(employee_id) To Evaluation TABLE
ALTER TABLE evaluation ADD (
		CONSTRAINT evaluation_FK1
        FOREIGN KEY (employee_id)
        REFERENCES deliver_person (employee_id)
        on delete cascade
);

PROMPT Adding Foreign Constraint(employee_id1) To Evaluation TABLE
ALTER TABLE evaluation ADD (
		CONSTRAINT evaluation_FK2
        FOREIGN KEY (employee_id1)
        REFERENCES deliver_person (employee_id)
        on delete cascade
);




PROMPT Adding Foreign Constraint(evluation_id) To lead TABLE
ALTER TABLE lead ADD (
		CONSTRAINT lead_FK1
        FOREIGN KEY (client_id)
        REFERENCES potential_client (client_id)
        on delete cascade
);

PROMPT Adding Foreign Constraint(evluation_id) To lead TABLE
ALTER TABLE lead ADD (
		CONSTRAINT lead_FK2
        FOREIGN KEY (employee_id)
        REFERENCES DELIVER_PERSON (employee_id)
        on delete cascade
);

PROMPT Adding Foreign Constraint(customer_id) To lead TABLE
ALTER TABLE lead ADD (
		CONSTRAINT evaluation_FK3
        FOREIGN KEY (customer_id)
        REFERENCES customer (customer_id)
        on delete cascade
);


PROMPT Adding Foreign Constraint(lead_id) To POTENTIAL_CLIENT TABLE
ALTER TABLE lead ADD (
		CONSTRAINT client_id_FK1
        FOREIGN KEY (lead_id)
        REFERENCES lead (lead_id)
        on delete cascade
);


REM insert into deliver route table
 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 1000);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 2000);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 3000);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 1000);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 1300);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 1400);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 2800);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 500);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 7500);

 INSERT INTO deliver_route VALUES(deliver_route_sequence.NEXTVAL, 1200);




INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'TSMC',
 'Paul', 'Richarson', 444499993737, '4121234567', 4004, 1500, NULL, to_date('18-FEB-2019 13:25', 'dd-mon-yyyy HH24:MI'), 7159.6375, 'ACTIVE',NULL);

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'MTK',
 'Jamie', 'Lannister', 111111111111, '4122345678', 4001, 5000, 2000, to_date('01-FEB-2019 12:01', 'dd-mon-yyyy HH24:MI'), 7089.392, 'ACTIVE','01-JAN-2019');

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'Cisco',
 'James', 'Paul', 222222222222, '412456724', 4005, 2510, 2001, to_date('11-FEB-2019 09:30', 'dd-mon-yyyy HH24:MI'), 7248.501, 'ACTIVE','01-JAN-2019');

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'Nokia',
 'Chris', 'Chen', 333333333333, '412712432', 4000, 1120, 2001, to_date('08-FEB-2019 14:24', 'dd-mon-yyyy HH24:MI'), 7397.552, 'ACTIVE','01-JAN-2019');

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'Verizon',
 'David', 'Lee', 444444444444, '4127645322', 4002, 5040, NULL, to_date('22-FEB-2019 15:00', 'dd-mon-yyyy HH24:MI'), 7720.692, 'ACTIVE',NULL);

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'Lyft',
 'Paul', 'George', 555555555555, '4126534251', 4007, 900, 2001, to_date('18-FEB-2019 10:47', 'dd-mon-yyyy HH24:MI'), 1101.137, 'ACTIVE','01-JAN-2019');

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'Wayfair',
 'Van', 'Tatum', 111122223333, '4126544635', 4003, 200, 2003, to_date('14-FEB-2019 12:00', 'dd-mon-yyyy HH24:MI'), 1227.504, 'ACTIVE','01-JAN-2019');

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'Offerup',
 'Paul', 'Richarson', 222233331111, '4127864523', 4006, 290, 2001, to_date('25-FEB-2019 15:08', 'dd-mon-yyyy HH24:MI'), 1132.916, 'ACTIVE','01-JAN-2019');

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'ASML',
 'Olive', 'Jordan', 555566663333, '4126745324', 4008, 600, 2003, to_date('17-FEB-2018 14:20', 'dd-mon-yyyy HH24:MI'), 1163.411, 'NON-ACTIVE','01-JAN-2019');

INSERT INTO customer VALUES(cust_sequence.NEXTVAL, 'Snow',
 'Richard', 'Chou', 444499998888, '4124568767', 4009, 205, 2001, to_date('21-FEB-2019 18:00', 'dd-mon-yyyy HH24:MI'), 1104.8285, 'ACTIVE','01-JAN-2019');


INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery manager', 'Liam', 'Noah', '4129876111', '0012131234501', 'Noah@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Male', 'European', 40, 100, to_date('01-JAN-2010', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery manager', 'William', 'James', '4129876112', '0012131234502', 'James@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Male', 'European', 50, 101, to_date('01-JAN-2010', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery person', 'Logan', 'Ben', '4129876113', '0012131234503', 'Ben@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Male', 'American', 35, 102, to_date('01-JAN-2011', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery person', 'Mason', 'Elijah', '4129876114', '0012131234504', 'Elijah@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Male', 'American', 25, 103, to_date('01-JAN-2011', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery person', 'Oliver', 'Jacob', '4129876115', '0012131234505', 'Jacob@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Male', 'Asian', 35, 104, to_date('01-JAN-2012', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery manager', 'Emma', 'Via', '4129876116', '0012131234506', 'Via@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'Asian', 50, 105, to_date('01-JAN-2010', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery person', 'Ava', 'Isa', '4129876117', '0012131234507', 'Isa@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'American', 30, 106, to_date('01-JAN-2012', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery person', 'Sophia', 'Mia', '4129876118', '0012131234508', 'Mia@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'American', 40, 107, to_date('01-JAN-2013', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery person', 'Charlott', 'Amelia', '4129876119', '0012131234509', 'Amelia@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'Asian', 50, 108, to_date('01-JAN-2014', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'delivery person', 'Eve', 'Abigai', '4129876120', '0012131234510', 'Abigai@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'European', 45, 109, to_date('01-JAN-2010', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'accountant', 'Sam', 'Mocca', '4121236118', '0012187634508', 'Mocca@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'American', 40, 107, to_date('25-JAN-2013', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'accountant', 'Chloe', 'Amy', '4129899919', '0012131239909', 'Amy@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'Asian', 50, 108, to_date('01-JUN-2012', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'accountant', 'Eva', 'Berry', '4129879920', '0018761234510', 'Berry@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'European', 45, 109, to_date('01-DEC-2010', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'sales person', 'Jamie', 'Chen', '4126526116', '0012131236199', 'JChen@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'Asian', 50, 105, to_date('01-NOV-2010', 'dd-mon-yyyy'));

INSERT INTO employee VALUES(employee_sequence.NEXTVAL, 'sales person', 'Cindy', 'Mello', '4125576117', '0012131904511', 'Mello@darkwater.gmail', 'Forbes', 'Pittsburgh', 'PA', '15000', 'Female', 'American', 30, 106, to_date('01-OCT-2012', 'dd-mon-yyyy'));

REM item_id is for manager 5000-5004
INSERT INTO item VALUES(item_sequence.NEXTVAL, 'Small Cup', 1.00, ' small cups stored', 10000 );

INSERT INTO item VALUES(item_sequence.NEXTVAL, 'Medium Cup', 2.00, 'medium cups stored', 10000 );

INSERT INTO item VALUES(item_sequence.NEXTVAL, 'Big Cup', 3.00, 'big cups stored', 10000 );

INSERT INTO item VALUES(item_sequence.NEXTVAL, 'Small Bottles of Water', 3.00, 'small bottles of water stored', 10000 );

INSERT INTO item VALUES(item_sequence.NEXTVAL, 'Straw', 0.50, 'straw stored', 20000 );

REM employee starts with 1000
REM employee1 is for manager 0, 1, 5
INSERT INTO deliver_person VALUES(1001, NULL,'IEEEStd1033');
INSERT INTO deliver_person VALUES(1000, NULL,'IEEEStd1044');
INSERT INTO deliver_person VALUES(1005, NULL,'IEEEStd1055');
INSERT INTO deliver_person VALUES(1003, 1000,'IEEEStd1071');
INSERT INTO deliver_person VALUES(1006, 1001,'IEEEStd1072');
INSERT INTO deliver_person VALUES(1007, 1001,'IEEEStd1073');
INSERT INTO deliver_person VALUES(1008, 1005,'IEEEStd1074');
INSERT INTO deliver_person VALUES(1002, 1000,'IEEEStd1075');
INSERT INTO deliver_person VALUES(1004, 1000,'IEEEStd1076');
INSERT INTO deliver_person VALUES(1009, 1005,'IEEEStd1077');









REM insert into deliver_service table
REM insert into deliver_service id starts with 3000
REM insert into deliver_route id starts with 4000
INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4000, 'CMU-0034', to_date('01-JAN-2019 09:45', 'dd-mon-yyyy HH24:MI'), to_date('01-FEB-2019 10:05', 'dd-mon-yyyy HH24:MI'), 1002, 2000, '230 N Craig Street', 'Very good', 'Very happy');
INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4000, 'CMU-0034', to_date('01-JAN-2019 09:45', 'dd-mon-yyyy HH24:MI'), to_date('01-FEB-2019 10:05', 'dd-mon-yyyy HH24:MI'), 1002, 2000, '231 N Craig Street', 'Very good', 'Very happy');


INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4001, 'CMU-0138', to_date('01-JAN-2019 13:10', 'dd-mon-yyyy HH24:MI'), to_date('01-FEB-2019 13:35', 'dd-mon-yyyy HH24:MI'), 1002, 2001, '5506 Fifth Avenue', 'Very good', 'Very happy');
INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4001, 'CMU-0138', to_date('01-JAN-2019 13:10', 'dd-mon-yyyy HH24:MI'), to_date('01-FEB-2019 13:35', 'dd-mon-yyyy HH24:MI'), 1002, 2001, '5507 Fifth Avenue', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4002, 'CMU-3409', to_date('10-JAN-2019 14:15', 'dd-mon-yyyy HH24:MI'), to_date('10-FEB-2019 15:00', 'dd-mon-yyyy HH24:MI'), 1003, 2002, '102 S Craig Street', 'Very good', 'Very happy');
INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4002, 'CMU-3409', to_date('10-JAN-2019 14:15', 'dd-mon-yyyy HH24:MI'), to_date('10-FEB-2019 15:00', 'dd-mon-yyyy HH24:MI'), 1003, 2002, '103 S Craig Street', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4003, 'PIT-1234', to_date('12-JAN-2019 12:15', 'dd-mon-yyyy HH24:MI'), to_date('12-FEB-2019 12:55', 'dd-mon-yyyy HH24:MI'), 1004, 2003, '5507 Fourth Avenue', 'Very good', 'Very happy');
INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4003, 'PIT-1234', to_date('12-JAN-2019 12:15', 'dd-mon-yyyy HH24:MI'), to_date('12-FEB-2019 12:55', 'dd-mon-yyyy HH24:MI'), 1004, 2003, '5508 Fourth Avenue', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4004, 'PIT-0033', to_date('12-JAN-2019 14:15', 'dd-mon-yyyy HH24:MI'), to_date('12-FEB-2019 15:00', 'dd-mon-yyyy HH24:MI'), 1003, 2004, '1110 Center Avenue', 'Very good', 'Very happy');
INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4004, 'PIT-0033', to_date('12-JAN-2019 14:15', 'dd-mon-yyyy HH24:MI'), to_date('12-FEB-2019 15:00', 'dd-mon-yyyy HH24:MI'), 1003, 2004, '1111 Center Avenue', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4005, 'PIT-0159', to_date('15-JAN-2019 14:15', 'dd-mon-yyyy HH24:MI'), to_date('15-FEB-2019 15:00', 'dd-mon-yyyy HH24:MI'), 1007, 2005, '266 Forbe Street', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4006, 'PIT-3678', to_date('18-JAN-2019 11:15', 'dd-mon-yyyy HH24:MI'), to_date('18-FEB-2019 12:00', 'dd-mon-yyyy HH24:MI'), 1007, 2006, '285 Frew Street', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4007, 'CMU-3104', to_date('19-JAN-2019 10:15', 'dd-mon-yyyy HH24:MI'), to_date('19-FEB-2019 11:00', 'dd-mon-yyyy HH24:MI'), 1008, 2007, '237 Tech Street', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4008, 'CMU-7893', to_date('20-JAN-2019 14:15', 'dd-mon-yyyy HH24:MI'), to_date('20-FEB-2019 15:00', 'dd-mon-yyyy HH24:MI'), 1009, 2008, '239 Bayard Street', 'Very good', 'Very happy');

INSERT INTO deliver_service VALUES(deliver_service_sequence.NEXTVAL, 4009, 'PIT-5567', to_date('22-JAN-2019 13:15', 'dd-mon-yyyy HH24:MI'), to_date('22-FEB-2019 14:00', 'dd-mon-yyyy HH24:MI'), 1008, 2009, '342 Baum Street', 'Very good', 'Very happy');





REM insert into delivery item table
REM item_id starts with 5000-5004, service_id starts 3000
INSERT INTO deliver_item VALUES(3000, 5002, 250);
INSERT INTO deliver_item VALUES(3000, 5004, 150);
INSERT INTO deliver_item VALUES(3001, 5000, 100);
INSERT INTO deliver_item VALUES(3002, 5001, 250);
INSERT INTO deliver_item VALUES(3002, 5003, 100);
INSERT INTO deliver_item VALUES(3003, 5000, 120);
INSERT INTO deliver_item VALUES(3004, 5002, 130);
INSERT INTO deliver_item VALUES(3004, 5001, 150);
INSERT INTO deliver_item VALUES(3005, 5001, 100);
INSERT INTO deliver_item VALUES(3006, 5000, 240);
INSERT INTO deliver_item VALUES(3006, 5002, 140);
INSERT INTO deliver_item VALUES(3007, 5001, 300);
INSERT INTO deliver_item VALUES(3008, 5002, 200);
INSERT INTO deliver_item VALUES(3008, 5003, 300);
INSERT INTO deliver_item VALUES(3009, 5000, 120);
INSERT INTO deliver_item VALUES(3010, 5000, 30);
INSERT INTO deliver_item VALUES(3011, 5001, 80);
INSERT INTO deliver_item VALUES(3012, 5002, 20);
INSERT INTO deliver_item VALUES(3013, 5003, 30);
INSERT INTO deliver_item VALUES(3014, 5004, 70);


REM insert into pickup item table
REM service_id starts 3000, item_id starts 5000
INSERT INTO pickup_item VALUES(3001, 5003, 10, 10, 10);
INSERT INTO pickup_item VALUES(3002, 5001, 12, 20, 9);
INSERT INTO pickup_item VALUES(3003, 5002, 30, 13, 8);
INSERT INTO pickup_item VALUES(3002, 5000, 12, 60, 15);
INSERT INTO pickup_item VALUES(3000, 5000, 11, 43, 22);
INSERT INTO pickup_item VALUES(3003, 5000, 13, 50, 34);
INSERT INTO pickup_item VALUES(3003, 5001, 10, 10, 32);
INSERT INTO pickup_item VALUES(3001, 5000, 18, 14, 17);
INSERT INTO pickup_item VALUES(3000, 5004, 9, 8, 12);
INSERT INTO pickup_item VALUES(3004, 5002, 10, 3, 10);



REM insert into table bill
REM employee starts with 1000, customer starts with 2000JAN
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2000, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1010, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2001, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1011, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2002, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1012, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2003, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1011, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2004, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1010, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2005, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1011, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2006, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1012, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2007, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1011, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2008, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1010, to_date('28-FEB-2019', 'dd-mon-yyyy'));
INSERT INTO bill VALUES(bill_sequence.NEXTVAL, 2009, to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('31-JAN-2019', 'dd-mon-yyyy'), 1011, to_date('28-FEB-2019', 'dd-mon-yyyy'));

REM insert into table monthly_fee
REM bill starts with 7000
INSERT INTO monthly_fee VALUES(7000, '230 N Craig Street', 2000);
INSERT INTO monthly_fee VALUES(7000, '231 N Craig Street', 2000);
INSERT INTO monthly_fee VALUES(7001, '5506 Fifth Avenue', 2000);
INSERT INTO monthly_fee VALUES(7001, '5507 Fifth Avenue', 2000);
INSERT INTO monthly_fee VALUES(7002, '102 S Craig Street', 2000);
INSERT INTO monthly_fee VALUES(7002, '103 S Craig Street', 2000);
INSERT INTO monthly_fee VALUES(7003, '5507 Fourth Avenue', 2000);
INSERT INTO monthly_fee VALUES(7003, '5508 Fourth Avenue', 2000);
INSERT INTO monthly_fee VALUES(7004, '1110 Center Avenue', 2000);
INSERT INTO monthly_fee VALUES(7004, '1111 Center Avenue', 2000);

INSERT INTO monthly_fee VALUES(7005, '266 Forbe Street', 1000);
INSERT INTO monthly_fee VALUES(7006, '285 Frew Street', 1000);
INSERT INTO monthly_fee VALUES(7007, '237 Tech Street', 1000);
INSERT INTO monthly_fee VALUES(7008, '239 Bayard Street', 1000);
INSERT INTO monthly_fee VALUES(7009, '342 Baum Street', 1000);


REM insert into table sale_contract
INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Jennifer', 'Liu', 2000, 1013, 'credit_card', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 1300);
 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Jessica', 'Chen', 2001, 1014, 'credit_card', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2015', 'dd-mon-yyyy'), 2000);

 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Tam', 'Tu',2002, 1013, 'credit_card', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 1200);

 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Claire', 'Lin', 2003, 1013, 'cash', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 1500);

 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Daniel', 'Hu', 2004, 1014, 'credit_card', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 3000);

 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Ella', 'Chen', 2005, 1013, 'cash', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 2000);

 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Mickey', 'Mouse', 2006, 1013, 'credit_card', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 1200);

 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Jhon', 'Snow', 2007, 1014, 'cash', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 2000);
 
 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Bess', 'Liu', 2008, 1014, 'credit_card', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 2000);

 INSERT INTO contract VALUES(contract_sequence.NEXTVAL, 'Lynn', 'Chang', 2009, 1013, 'credit_card', to_date('01-JAN-2019', 'dd-mon-yyyy'), to_date('01-JAN-2019', 'dd-mon-yyyy'), 2000);



 REM insert into table contract_detail
 INSERT INTO contract_detail VALUES(6000, 'room1', '230 N Craig Street', 3000, 20, 1200, 200);
 INSERT INTO contract_detail VALUES(6000, 'room1', '231 N Craig Street', 3001, 20, 1200, 200);

 INSERT INTO contract_detail VALUES(6001, 'room2', '5506 Fifth Avenue', 3002, 35, 700, 200);
 INSERT INTO contract_detail VALUES(6001, 'room2', '5507 Fifth Avenue', 3003, 35, 700, 200);

 INSERT INTO contract_detail VALUES(6002, 'room3', '102 S Craig Street', 3004, 8, 500, 200);
 INSERT INTO contract_detail VALUES(6002, 'room3', '103 S Craig Street', 3005, 8, 500, 200);

 INSERT INTO contract_detail VALUES(6003, 'room4', '5507 Fourth Avenue', 3006, 20, 1200, 200);
 INSERT INTO contract_detail VALUES(6003, 'room4', '5508 Fourth Avenue', 3007, 20, 1200, 200);

 INSERT INTO contract_detail VALUES(6004, 'room5', '1110 Center Avenue', 3008, 35, 1600, 200);
 INSERT INTO contract_detail VALUES(6004, 'room5', '1111 Center Avenue', 3009, 35, 1600, 200);

 INSERT INTO contract_detail VALUES(6005, 'room6', '266 Forbe Street', 3010, 20, 1200, 200);

 INSERT INTO contract_detail VALUES(6006, 'room7', '285 Frew Street', 3011, 35, 700, 200);

 INSERT INTO contract_detail VALUES(6007, 'room8', '237 Tech Street', 3012, 15, 500, 200);

 INSERT INTO contract_detail VALUES(6008, 'room9', '239 Bayard Street', 3013, 20, 1200, 200);

 INSERT INTO contract_detail VALUES(6009, 'room10', '342 Baum Street', 3014, 35, 1600, 200);


REM insert into table evaluation
INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1002,
 1000, 'You have done a great job!', 100, to_date('20-DEC-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1009,
 1005, 'Good for you!', 90, to_date('15-NOV-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1007,
 1001, 'Good!', 80, to_date('18-OCT-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1006,
 1001, 'Try harded!', 70, to_date('16-JAN-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1003,
 1000, 'Try your best!', 75, to_date('20-OCT-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1006, 
 1001, 'You have done a good job!', 85, to_date('18-DEC-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1007,
 1001, 'Cool!', 90, to_date('18-DEC-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1008,
 1005, 'Be careful!', 40, to_date('15-NOV-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1004,
 1000, 'Please work harder!', 50, to_date('20-DEC-2018', 'dd-mon-yyyy'));

 INSERT INTO evaluation VALUES(evaluate_sequence.NEXTVAL, 1003,
 1000, 'You are awesome!', 99, to_date('20-DEC-2018', 'dd-mon-yyyy'));






 REM insert into table potential client
INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
'Google', 'Kobe', 'Bryant', '4121111111', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Facebook', 'Lebron', 'James', '4122222222', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Amazon', 'Jenny', 'Liu', '4123333333', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Microsoft', 'Jesse', 'Liu', '4124444444', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
'Bloomberg', 'Nick', 'Bloomberg', '4121112222', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Yelp', 'Kevin', 'Chen', '4122223333', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Pinterest', 'Anthony', 'Brown', '4123334444', 'Small Business');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Uber', 'Bessie', 'Lin', '4126666666', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Oracle', 'Jack', 'Jin', '4128888888', 'Large Corporation');

 INSERT INTO potential_client VALUES(client_sequence.NEXTVAL,
 'Apple', 'Jason', 'Wang', '4129999999', 'Large Corporation');











REM insert into table lead
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1003, 2001, 9000, 'It is a potential client!');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1003, 2001, 9001, 'The company need lots of water');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1003, 2003, 9002, '');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1004, 2002, 9003, 'The client is avaliable after 6pm.');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1006, 2001, 9004, '');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1007, 2002, 9005, 'good');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1002, 2001, 9006, '');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1004, 2002, 9007, '');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1008, 2001, 9008, '');
INSERT INTO lead VALUES(lead_sequence.NEXTVAL, 1009, 2001, 9009, 'Only needs small bottle of water');




























































/* we will send the bill to customer text customer at the middle of the month if they 
have unpaid balance*/
CREATE VIEW balance_not_paid_customer AS
select Customer_id, phone, transaction_date, current_balance
from customer
where current_balance!=0;
select * from balance_not_paid_customer;






/*show the deliver_leader and deliver person*/
create view deliver_management as 
select employee_id1 as manager_id, employee_id as employee_id 
from deliver_person 
where employee_id1 is not null
order by (employee_id1);
select * from deliver_management;







/* when the customer pay the balance, we will reduce the current_balance
but we have to make sure they pay all required balance, not partial*/
CREATE OR REPLACE TRIGGER customer_pay_balance
BEFORE UPDATE ON Customer 
FOR EACH ROW

DECLARE 
   invalid_payment EXCEPTION;
BEGIN
   
   IF :new.current_balance!=0 and :new.current_balance<:old.current_balance THEN 
   RAISE invalid_payment;
  
   END IF;
   
EXCEPTION
   WHEN invalid_payment THEN
        raise_application_error(-20004, 'You cannot pay partial balance '); 
    
END;
/
/*A customer can sign a new contract when he is active and have no unpaid balance*/
CREATE OR REPLACE TRIGGER valid_new_contract
BEFORE INSERT ON CONTRACT 
FOR EACH ROW

DECLARE 
   current_balance customer.current_balance%type;
   status customer.status%type;
   invalid_customer EXCEPTION;
BEGIN
   SELECT current_balance,status INTO current_balance,status
   FROM Customer
   where Customer_id=:new.customer_id;
   IF current_balance!=0 or status='NON-ACTIVE' THEN 
   RAISE invalid_customer;
  
   END IF;
   
EXCEPTION
   WHEN invalid_customer THEN
          DBMS_OUTPUT.PUT_LINE('The customer cannot initialize a new contract because of unpaid balance or locked ');
        raise_application_error(-20003, 'Balance is not paid '); 
        
END;
/


/* When the customer want to have new order, they should satisfy
two condition, the quantity of the item is smaller than the order quantity
and the customer current balance is not locked. when they satisfy this
two condition,we update item quantity*/
CREATE OR REPLACE TRIGGER new_item_check
BEFORE INSERT ON deliver_item 
FOR EACH ROW

DECLARE 
   current_quantity item.quantity%type;
   status customer.status%type;
   invalid_order_type1 EXCEPTION;
   invalid_order_type2 Exception;
BEGIN
   SELECT quantity INTO current_quantity 
   FROM item
   where item_id=:new.item_id;
    select distinct status into status
    from deliver_service join customer using (customer_id)
                         join deliver_item using (service_id)
    where service_id=:new.service_id;

   IF current_quantity< :new.quantity THEN 
   RAISE invalid_order_type1; 
   END IF;
   IF status='NON-ACTIVE' THEN  
   RAISE invalid_order_type2; 
   END IF;
   update item set quantity=quantity-:new.quantity
   where item_id=:new.item_id;
   
      
EXCEPTION
   WHEN invalid_order_type1 THEN
        raise_application_error(-20001, 'Storage is not enough ');
      
   WHEN invalid_order_type2 THEN
        
        raise_application_error(-20002, 'User is locked ');    
END;
/
create table service_denormal as
select SERVICE_ID,customer_id, DELIVER_ROUTE_ID,TIME_ARRIVED, 
TIME_DEPARTED, deliver_item.item_id as deliver_item,
deliver_item.quantity as de_quantity, 
pickup_item.item_id as pickup_item,pickup_item.partial as partial,
pickup_item.empty as empty, pickup_item.full_bottle as full 
from deliver_service join deliver_item using(service_id)
                     join pickup_item using(service_id)
order by service_id;

/









REM This file contains a package called billing
SET SERVEROUTPUT ON
CREATE OR REPLACE PACKAGE billing
AS
    PROCEDURE bill1(inputBill_id IN bill.bill_id%TYPE, input_customer_id OUT bill.customer_id%TYPE, bill_date OUT bill.start_date%TYPE);
    PROCEDURE bill_detail(inputBill_id IN bill.bill_id%TYPE,
                                        input_customer_id IN bill.customer_id%TYPE, 
                                        bill_date IN DATE,
                                        totalFee OUT NUMBER, totalMonthlyFee OUT NUMBER);
    FUNCTION total_charge(month_fee NUMBER, item_total_charge NUMBER)
    RETURN NUMBER;
    FUNCTION total_discount(refer_id customer.customer_id%TYPE)
    RETURN NUMBER;
    FUNCTION late_fee(c_id customer.customer_id%TYPE)
    RETURN NUMBER;

    PROCEDURE total_bill(month_fee IN NUMBER,
                    item_total_charge IN NUMBER, c_id IN customer.customer_id%TYPE);
END billing;
/

REM The body follows
CREATE OR REPLACE PACKAGE BODY billing
AS

PROCEDURE bill1(inputBill_id IN bill.bill_id%TYPE, input_customer_id OUT bill.customer_id%TYPE, bill_date OUT bill.start_date%TYPE)
AS
BEGIN
    SELECT customer_id, start_date INTO input_customer_id, bill_date FROM bill WHERE bill.bill_id = inputBill_id;
END bill1;

PROCEDURE bill_detail(inputBill_id IN bill.bill_id%TYPE,
                                        input_customer_id IN bill.customer_id%TYPE, 
                                        bill_date IN DATE,
                                        totalFee OUT NUMBER, totalMonthlyFee OUT NUMBER)
AS
    Cursor c1 IS
    SELECT deliver_service.location_address AS location, fee, deliver_item.item_id AS itemID, deliver_item.quantity, description, price, (deliver_item.quantity/10)*0.01 AS discount, 
    price*deliver_item.quantity*(1-(deliver_item.quantity/10)*0.01) AS total
    FROM deliver_service, deliver_item, item, monthly_fee
    WHERE deliver_service.customer_id = input_customer_id
    AND EXTRACT(YEAR FROM deliver_service.time_arrived) = EXTRACT(YEAR FROM bill_date)
    AND EXTRACT(MONTH FROM deliver_service.time_arrived) = EXTRACT(MONTH FROM bill_date)
    AND deliver_service.service_id = deliver_item.service_id
    AND deliver_item.item_id = item.item_id
    AND deliver_service.location_address = monthly_fee.location_address
    AND monthly_fee.bill_id = inputBill_id;
    totalSum NUMBER :=0;
    totalMonthFee NUMBER := 0;
BEGIN
    dbms_output.put_line('Location  ' || 'Monthly Fee   ' || 'itemID    ' || 'Qty   ' || 'Description   ' || 'Price ' || 'Discount  ' || 'Total ');
    FOR s_c IN C1 LOOP
        totalSum := totalSum + s_c.total;
        totalMonthFee := totalMonthFee + s_c.fee;
        dbms_output.put_line(s_c.location || '  ' || s_c.fee || '   '|| s_c.itemID || '  ' || s_c.quantity || '  ' || s_c.description || '  ' || s_c.price || '  ' || s_c.discount || '  ' || s_c.total);
    END LOOP;
    dbms_output.put_line(totalSum);
    totalFee := totalSum;
    totalMonthlyFee := totalMonthFee;
END bill_detail;

FUNCTION total_charge(month_fee NUMBER, item_total_charge NUMBER)
RETURN NUMBER AS
BEGIN

    RETURN month_fee + item_total_charge;
END total_charge;


FUNCTION total_discount(refer_id customer.customer_id%TYPE)
RETURN NUMBER
IS
    amount NUMBER;
BEGIN
    SELECT COUNT(refer_by)
    INTO amount
    FROM customer
    WHERE refer_by = refer_id;
    
    RETURN amount * 25;
END total_discount;

FUNCTION late_fee(c_id customer.customer_id%TYPE)
RETURN NUMBER
IS
    past_due NUMBER;
BEGIN
    SELECT current_balance
    INTO past_due
    FROM customer
    WHERE customer_id = c_id;
    
    RETURN past_due * 0.15;
END late_fee;

PROCEDURE total_bill(month_fee IN NUMBER, item_total_charge IN NUMBER, 
                      c_id IN customer.customer_id%TYPE)
AS
    charge_total NUMBER;
    discount_amount NUMBER;
    after_tax NUMBER;
    total_amount_due NUMBER;
    balance NUMBER;
    late_fee NUMBER;
    total NUMBER;
    today_date DATE := Last_day(ADD_MONTHS(SYSDATE, -1));
BEGIN
    charge_total := total_charge(month_fee, item_total_charge);
    DBMS_OUTPUT.PUT_LINE('Total Charges: '||charge_total);
    discount_amount := total_discount(c_id);
    DBMS_OUTPUT.PUT_LINE('Discount: '||discount_amount);
    after_tax := (charge_total - discount_amount) * 0.07;
    DBMS_OUTPUT.PUT_LINE('Tax: '||after_tax);
    total_amount_due := charge_total - discount_amount + after_tax;
    DBMS_OUTPUT.PUT_LINE('Amount Due : '||total_amount_due);
    SELECT current_balance INTO balance 
    FROM customer WHERE customer_id = c_id;
    DBMS_OUTPUT.PUT_LINE('Past Due : '||balance);
    late_fee := balance * 0.15;
    DBMS_OUTPUT.PUT_LINE('Late Fee : '||late_fee);
    total := total_amount_due + late_fee;
    DBMS_OUTPUT.PUT_LINE('Total Bill: '||total);
    DBMS_OUTPUT.PUT_LINE('Date Due: '|| today_date); 
END total_bill;

END billing;
/
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE call_total(b_id IN bill.bill_id%TYPE)
AS
c_id customer.customer_id%TYPE;
bill_date bill.start_date%TYPE;
month_total_fee NUMBER;
item_total_charge NUMBER;

BEGIN
billing.bill1(b_id, c_id, bill_date);
billing.bill_detail(b_id, c_id, bill_date, item_total_charge, month_total_fee);
billing.total_bill(month_total_fee, item_total_charge, c_id);
END;
/




















































 
