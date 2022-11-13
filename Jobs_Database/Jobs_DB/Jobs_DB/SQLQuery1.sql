CREATE TABLE tweet_data 
(
	ID int NOT NULL IDENTITY(1, 1), 
	companyName varchar(100) NOT NULL, 
	profile_description varchar(100), 
	website_url varchar(200) NOT NULL, 
	PRIMARY KEY(ID)
);

CREATE TABLE company 
(
	ID int NOT NULL IDENTITY(1, 1), 
	companyName varchar(100) NOT NULL, 
	profile_description varchar(100), 
	website_url varchar(200) NOT NULL, 
	PRIMARY KEY(ID)
);

CREATE TABLE job_post
(
	id int NOT NULL IDENTITY(1, 1), 
	posted_by_id int,job_type_id int,
	company_id int, 
	is_company_name_hidden char(1), 
	created_date date, 
	job_description varchar(100), 
	job_location_id int, 
	is_active char(1), 
	website_id int, 
	PRIMARY KEY(id)
);

