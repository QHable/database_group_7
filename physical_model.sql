CREATE  TABLE group_7.client ( 
	id                   char(8)  NOT NULL  ,
	address              varchar(100)  NOT NULL  ,
	phone_number         char(10)  NOT NULL  ,
	CONSTRAINT pk_client PRIMARY KEY ( id )
 );


CREATE  TABLE group_7.email ( 
	client_id            char(8)  NOT NULL  ,
	email                varchar(70)    ,
	CONSTRAINT client_id FOREIGN KEY ( client_id ) REFERENCES group_7.client( id )   
 );

CREATE INDEX idx_email ON group_7.email  ( client_id, email );

CREATE  TABLE group_7.patient ( 
	id                   char(8)  NOT NULL  ,
	name                 varchar(100)  NOT NULL  ,
	date_of_birth        date  NOT NULL  ,
	animal_species       varchar(70)  NOT NULL  ,
	animal_breed         varchar(70)  NOT NULL  ,
	client_id            char(8)  NOT NULL  ,
	CONSTRAINT pk_patient PRIMARY KEY ( id ),
	CONSTRAINT client_id FOREIGN KEY ( client_id ) REFERENCES group_7.client( id )   
 );

CREATE  TABLE group_7.practice ( 
	id                   varchar(100)  NOT NULL  ,
	phone_number         integer  NOT NULL  ,
	address              varchar(100)  NOT NULL  ,
	hours_of_operation   varchar(100)  NOT NULL  ,
	CONSTRAINT pk_practice PRIMARY KEY ( id )
 );

CREATE  TABLE group_7.products ( 
	id                   char(8)  NOT NULL  ,
	product_name         varchar(100)  NOT NULL  ,
	product_price        integer  NOT NULL  ,
	product_category     varchar(100) NOT NULL,
	product_description  varchar(100) NOT NULL,
	CONSTRAINT pk_products PRIMARY KEY ( id )
 );

CREATE  TABLE group_7.room ( 
	id                   integer  NOT NULL  ,
	practice_name        varchar(100)  NOT NULL  ,
	CONSTRAINT pk_room PRIMARY KEY ( id ),
	CONSTRAINT fk_practice FOREIGN KEY ( practice_name ) REFERENCES group_7.practice( id )   
 );

CREATE  TABLE group_7.time_slot ( 
	id                   timestamp  NOT NULL  ,
	"end"                time    ,
	on_call              boolean  NOT NULL  ,
	CONSTRAINT pk_time_slot PRIMARY KEY ( id )
 );

CREATE  TABLE group_7.worker ( 
	id                   char(8)  NOT NULL  ,
	employee_name        varchar(50)  NOT NULL  ,
	employee_address     varchar(100)  NOT NULL  ,
	phone_number         integer  NOT NULL  ,
	employee_roll        varchar(100)  NOT NULL  ,
	practice_name        varchar(100)  NOT NULL  ,
	CONSTRAINT pk_worker PRIMARY KEY ( id ),
	CONSTRAINT fk_practice FOREIGN KEY ( practice_name ) REFERENCES group_7.practice( id )   
 );

CREATE  TABLE group_7.worker_has_time_slot ( 
	worker_id            char(8)  NOT NULL  ,
	time_slot_id         timestamp  NOT NULL  ,
	CONSTRAINT fk_time_slot FOREIGN KEY ( time_slot_id ) REFERENCES group_7.time_slot( id )   ,
	CONSTRAINT worker_id FOREIGN KEY ( worker_id ) REFERENCES group_7.worker( id )   
 );

CREATE  TABLE group_7.appointment ( 
	id                   char(10)  NOT NULL  ,
	appointment_date     date  NOT NULL  ,
	description          varchar(100)    ,
	start_time           time  NOT NULL  ,
	end_time             time  NOT NULL  ,
	results              varchar(100)    ,
	appointment_type     varchar  NOT NULL  ,
	appointment_cost     smallint  NOT NULL  ,
	follow_up_of         char(10)    ,
	patient_id           char(8)  NOT NULL  ,
	room_number          integer  NOT NULL  ,
	CONSTRAINT pk_appointment PRIMARY KEY ( id ),
	CONSTRAINT appointment_id FOREIGN KEY ( follow_up_of ) REFERENCES group_7.appointment( id )   ,
	CONSTRAINT patient_id FOREIGN KEY ( patient_id ) REFERENCES group_7.patient( id )   ,
	CONSTRAINT room_id FOREIGN KEY ( room_number ) REFERENCES group_7.room( id )   
 );

CREATE  TABLE group_7.client_orders_product ( 
	product_id           char(8)  NOT NULL  ,
	client_id            char(8)  NOT NULL  ,
	order_date           date  NOT NULL  ,
	order_amount         integer  NOT NULL  ,
	CONSTRAINT client_id FOREIGN KEY ( client_id ) REFERENCES group_7.client( id )   ,
	CONSTRAINT product_id FOREIGN KEY ( product_id ) REFERENCES group_7.products( id )   
 );

CREATE INDEX idx_client_orders_product ON group_7.client_orders_product  ( product_id, client_id );

CREATE  TABLE group_7.prescribes ( 
	product_id           char(8)  NOT NULL  ,
	appointment_id       char(10)  NOT NULL  ,
	prescription_duration varchar(20)  NOT NULL  ,
	prescription_amount  integer  NOT NULL  ,
	CONSTRAINT product_id FOREIGN KEY ( product_id ) REFERENCES group_7.products( id )   ,
	CONSTRAINT appointment_id FOREIGN KEY ( appointment_id ) REFERENCES group_7.appointment( id )   
 );

CREATE INDEX idx_prescribes ON group_7.prescribes  ( product_id, appointment_id );

CREATE  TABLE group_7.specialisation ( 
	id                   varchar(100)  NOT NULL  ,
	worker_id            char(8)  NOT NULL  ,
	CONSTRAINT pk_specialisation PRIMARY KEY ( id ),
	CONSTRAINT worker_id FOREIGN KEY ( worker_id ) REFERENCES group_7.worker( id )   
 );

CREATE  TABLE group_7.vet_has_appointment ( 
	appointment_id       char(10)  NOT NULL  ,
	worker_id            char(8)  NOT NULL  ,
	CONSTRAINT appointment_id FOREIGN KEY ( appointment_id ) REFERENCES group_7.appointment( id )   ,
	CONSTRAINT worker_id FOREIGN KEY ( worker_id ) REFERENCES group_7.worker( id )   
 );

CREATE INDEX idx_vet_has_appointment ON group_7.vet_has_appointment  ( appointment_id, worker_id );

CREATE  TABLE group_7.animal_carer_has_appointment ( 
	appointment_id       char(10)  NOT NULL  ,
	worker_id            char(8)  NOT NULL  ,
	CONSTRAINT worker_id FOREIGN KEY ( worker_id ) REFERENCES group_7.worker( id )   ,
	CONSTRAINT appointment_id FOREIGN KEY ( appointment_id ) REFERENCES group_7.appointment( id )   
 );

CREATE INDEX idx_animal_carer_has_appointment ON group_7.animal_carer_has_appointment  ( appointment_id, worker_id );

GRANT ALL ON SCHEMA group_7 TO r1079475, r0965625, r1086252, r0998097, local_r1079475, local_r0965625, local_r1086252, local_r0998097;

GRANT ALL ON ALL TABLES IN SCHEMA group_7 TO r1079475, r0965625, r1086252, r0998097, local_r1079475, local_r0965625, local_r1086252, local_r0998097;