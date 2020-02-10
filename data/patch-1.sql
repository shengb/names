-- This patch is to modify category names:
-- device-type to component-function
-- subsystem to primary-system
-- system to primary-machine-location

-- Increase size of column id in table name_category
ALTER TABLE name_category MODIFY id VARCHAR(32);

-- Increase size of column name_category_id in table name_event
ALTER TABLE name_event MODIFY name_category_id VARCHAR(32);

-- Disable foreign key checks otherwise update fails.
SET FOREIGN_KEY_CHECKS=0;

-- Make the modifications
update name_event set name_category_id="component-function" where name_category_id='device-type';
update name_event set name_category_id="primary-system" where name_category_id='subsystem';
update name_event set name_category_id="primary-machine-location" where name_category_id='system';
update name_category set id="component-function", name="Component Function", description="Component Function", version=0 where id='device-type';
update name_category set id="primary-system", name="Primary System", description="Primary System", version=0 where id='subsystem';
update name_category set id="primary-machine-location", name="Primary Machine Location", description="Primary Machine Location", version=0 where id='system';

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS=1;

