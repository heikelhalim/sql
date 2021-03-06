/* Drop Tables */

DROP TABLE IF EXISTS calendar_event;

DROP TABLE IF EXISTS admin_master;
DROP TABLE IF EXISTS admin_master_password_history;
DROP TABLE IF EXISTS admin_account_master;
DROP TABLE IF EXISTS admin_account_password_history;
DROP TABLE IF EXISTS admin_locked_out;
DROP TABLE IF EXISTS mutex;

/* Create Tables */

CREATE TABLE admin_account_master
(
    -- uuid
    id varchar(32) NOT NULL,
    full_name varchar(64) NOT NULL,
    email varchar(256) NOT NULL UNIQUE,
    password_hash varchar(256) NOT NULL,
    admin_password varchar(256) NOT NULL,
    account_info varchar(256),
    created_at timestamp,
    created_by varchar(256),
    updated_at timestamp,
    updated_by varchar(256),
    update_version int NOT NULL,
    PRIMARY KEY (id)
) WITHOUT OIDS;

CREATE TABLE admin_account_password_history
(
    -- uuid
    id varchar(32) NOT NULL,
    account_update_version int NOT NULL,
    password_hash char(256) NOT NULL,
    admin_password char(256) NOT NULL,
    email varchar(256) NOT NULL,
    created_at timestamp,
    created_by varchar(256),
    updated_at timestamp,
    updated_by varchar(256),
    update_version int NOT NULL,
    PRIMARY KEY (id, account_update_version)
) WITHOUT OIDS;

CREATE TABLE admin_locked_out
(
    -- uuid
    id varchar(32) NOT NULL,
    account_id varchar(32) NOT NULL,
    attempts int,
    locked_out_at timestamp,
    ip_address varchar(39),
    created_at timestamp,
    created_by varchar(256),
    updated_at timestamp,
    updated_by varchar(256),
    update_version int NOT NULL,
    PRIMARY KEY (id)
) WITHOUT OIDS;

CREATE TABLE mutex
(
    id int NOT NULL,
    name varchar(20) NOT NULL,
    created_at timestamp,
    created_by varchar(256),
    updated_at timestamp,
    updated_by varchar(256),
    update_version int NOT NULL,
    PRIMARY KEY (id)
) WITHOUT OIDS;


CREATE TABLE calendar_event(
id varchar(32) NOT NULL, 
account_id varchar(32) NOT NULL,
event_title varchar(64) NOT NULL,
StartDate timestamp,
StartTime timestamp,
EndDate timestamp,
EndTIme timestamp,
event_location varchar(64),
event_note varchar (256),
created_at timestamp,
created_by varchar(256),
updated_at timestamp,
updated_by varchar(256),
update_version int NOT NULL,
PRIMARY KEY (id)
) WITHOUT OIDS;



/* Create Foreign Keys */

ALTER TABLE admin_account_password_history
    ADD FOREIGN KEY (id)
    REFERENCES admin_account_master (id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
;

ALTER TABLE admin_locked_out
    ADD FOREIGN KEY (account_id)
    REFERENCES admin_account_master (id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
;

ALTER TABLE calendar_event
    ADD FOREIGN KEY (account_id)
    REFERENCES admin_account_master (id)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
;

/* This is query for mutex table */
INSERT INTO mutex (id, name, update_version) VALUES (1, 'admin', 0);