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
update name_event set name_category_id="primary-machine" where name_category_id='system';
update name_category set id="primary-machine", name="Primary Machine/Sub-Area", description="Primary Machine/Sub-Area", version=0 where id='system';
update name_event set name_category_id="system" where name_category_id='subsystem';
update name_category set id="system", name="System", description="System", version=0 where id='subsystem';
delete from name_category where id='signal-type' and not exists(select 1 from name_event where name_category_id='signal-type');
delete from name_category where id='signal-suffix' and not exists(select 1 from name_event where name_category_id='signal-suffix');
delete from name_category where id='signal-domain' and not exists(select 1 from name_event where name_category_id='signal-domain');

-- Enable foreign key checks again
SET FOREIGN_KEY_CHECKS=1;

