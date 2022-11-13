CREATE TABLE Company(ID int NOT NULL IDENTITY(1, 1), companyName varchar(100), profile_description varchar(100), business_stream_ID int, establishment_date date, establishment_website_url varchar(200), PRIMARY KEY(ID));

CREATE TABLE job_post(id int NOT NULL IDENTITY(1, 1), posted_by_id int,job_type_id int,company_id int, is_company_name_hidden char(1), created_date date, job_description varchar(100), job_location_id int, is_active char(1), website_id int, PRIMARY KEY(id));

CREATE TABLE job_location(id int NOT NULL IDENTITY(1, 1), street_address varchar(100), city varchar(200),state varchar(100), country varchar(100), zip varchar(100), PRIMARY KEY(id));

CREATE TABLE job_type(id int NOT NULL IDENTITY(1, 1), job_type varchar(100), PRIMARY KEY(id));

CREATE TABLE job_post_activity(user_account_id int, job_post_id int, apply_date date, CONSTRAINT PK_jpa PRIMARY KEY(user_account_id,job_post_id));

CREATE TABLE seeker_profile(user_account_id int, first_name varchar(100), last_name varchar(100), current_salary int, is_annually_monthly char(1), currency varchar(100));

CREATE TABLE education_detail(user_account_id int, certificate_degree_name varchar(100), major varchar(200), institute_university_name varchar(100), starting_date date, completion_date date, percentage int, cgpa int, CONSTRAINT PK_ed PRIMARY KEY(user_account_id, certificate_degree_name, major));

CREATE TABLE experience_detail(user_account_id int, is_current_job char(1), start_date date, end_date date, job_title varchar(100), company_name varchar(100), job_location_city varchar(100), job_location_state varchar(100), job_location_country varchar(100), description varchar(100), CONSTRAINT PK_exd PRIMARY KEY(user_account_id,start_date,end_date));

CREATE TABLE seeker_skill_set(user_account_id int, skill_set_id int, skill_level int, CONSTRAINT PK_sst PRIMARY KEY(user_account_id,skill_set_id));

CREATE TABLE skill_set(id int NOT NULL IDENTITY(1, 1), skill_set_name varchar(100), PRIMARY KEY(id));

CREATE TABLE business_stream(ID int NOT NULL IDENTITY(1, 1), business_stream_name varchar(200), PRIMARY KEY(id));

CREATE TABLE data_collection_websites(id int NOT NULL IDENTITY(1, 1), website_name varchar(100), PRIMARY KEY(id));

CREATE TABLE job_post_skill_set(skill_set_id int, job_post_id int, skill_level int, CONSTRAINT PK_jpss PRIMARY KEY(skill_set_id,job_post_id));

CREATE TABLE user_log(user_account_id int, last_login_date date, last_job_apply_date date, PRIMARY KEY(user_account_id));

CREATE TABLE user_account(id int NOT NULL IDENTITY(1, 1), user_type_id int, email varchar(255), password varchar(100), dateOfBirth date, gender char(1), is_active char(1), contact_number int, sms_notification_active char(1), email_notification_active char(1), registration_date date, PRIMARY KEY(id));

CREATE TABLE user_type(id int NOT NULL IDENTITY(1, 1), user_type_name varchar(100), PRIMARY KEY(id));

ALTER TABLE job_post ADD FOREIGN KEY(job_type_id) REFERENCES job_type(id);

ALTER TABLE job_post ADD FOREIGN KEY(company_id) REFERENCES company(id);

ALTER TABLE job_post ADD FOREIGN KEY(job_location_id) REFERENCES job_location(id);

ALTER TABLE job_post ADD FOREIGN KEY(posted_by_id) REFERENCES user_account(id);

ALTER TABLE job_post_activity ADD FOREIGN KEY(user_account_id) REFERENCES user_account(id);

ALTER TABLE job_post_activity ADD FOREIGN KEY(job_post_id) REFERENCES job_post(id);

ALTER TABLE seeker_profile ADD FOREIGN KEY(user_account_id) REFERENCES user_account(id);

ALTER TABLE education_detail ADD FOREIGN KEY(user_account_id) REFERENCES seeker_profile(user_account_id);

ALTER TABLE experience_detail ADD FOREIGN KEY(user_account_id) REFERENCES seeker_profile(user_account_id);

ALTER TABLE seeker_skill_set ADD FOREIGN KEY(user_account_id) REFERENCES skill_set(id);

ALTER TABLE seeker_skill_set ADD FOREIGN KEY(skill_set_id) REFERENCES skill_set(id);