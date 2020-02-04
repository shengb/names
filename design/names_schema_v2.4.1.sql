--   -------------------------------------------------- 
--   Generated by Enterprise Architect Version 9.2.921
--   Created On : Thursday, 25 July, 2013 
--   DBMS       : MySql 
--   -------------------------------------------------- 


SET FOREIGN_KEY_CHECKS=0;


--  Drop Tables, Stored Procedures and Views 

DROP TABLE IF EXISTS configuration CASCADE;
DROP TABLE IF EXISTS name_category CASCADE;
DROP TABLE IF EXISTS name_event CASCADE;
DROP TABLE IF EXISTS name_release CASCADE;
DROP TABLE IF EXISTS privilege CASCADE;

--  Create Tables 
CREATE TABLE configuration
(
	name VARCHAR(64) NOT NULL,
	value VARCHAR(255),
	PRIMARY KEY (name)

) ENGINE=InnoDB COMMENT='Each row is a module property';


CREATE TABLE name_category
(
	id VARCHAR(32) NOT NULL,
	name VARCHAR(32) NOT NULL,
	description VARCHAR(255),
	version INTEGER NOT NULL,
	PRIMARY KEY (id)

) ENGINE=InnoDB COMMENT='Each row is a naming category';


CREATE TABLE name_event
(
	id INTEGER NOT NULL AUTO_INCREMENT,
	name_id VARCHAR(64) NOT NULL,
	event_type CHAR(1) NOT NULL,
	requested_by VARCHAR(64) NOT NULL,
	requestor_comment VARCHAR(255) NOT NULL,
	request_date DATETIME NOT NULL,
	status CHAR(1) NOT NULL,
	processed_by VARCHAR(64),
	processor_comment VARCHAR(255),
	process_date DATETIME,
	name_category_id VARCHAR(32),
	name_code VARCHAR(16),
	name_description VARCHAR(255),
	version INTEGER NOT NULL,
	PRIMARY KEY (id),
	KEY (name_category_id)

) ENGINE=InnoDB COMMENT='Each row is an event in a name''s lifecycle';


CREATE TABLE name_release
(
	id VARCHAR(16) NOT NULL,
	description VARCHAR(255) NOT NULL,
	doc_url VARCHAR(255),
	release_date DATETIME NOT NULL,
	released_by VARCHAR(64) NOT NULL,
	version INTEGER NOT NULL,
	PRIMARY KEY (id)

) ENGINE=InnoDB COMMENT='Each row is a naming system release';


CREATE TABLE privilege
(
	userid VARCHAR(64) NOT NULL,
	operation VARCHAR(1) NOT NULL,
	version INTEGER NOT NULL,
	PRIMARY KEY (userid)

) ENGINE=InnoDB;



SET FOREIGN_KEY_CHECKS=1;


--  Create Foreign Key Constraints 
ALTER TABLE name_event ADD CONSTRAINT FK_name_event_name_category 
	FOREIGN KEY (name_category_id) REFERENCES name_category (id)
	ON DELETE RESTRICT ON UPDATE CASCADE;
