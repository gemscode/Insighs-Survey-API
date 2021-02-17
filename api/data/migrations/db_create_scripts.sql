CREATE USER dbuser WITH PASSWORD 'ndDB#20256';

GRANT ALL ON DATABASE insights TO node_dbuser;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE demo_user (
	id uuid DEFAULT uuid_generate_v4 () PRIMARY KEY, 
	name VARCHAR(100) NOT NULL, 
	img_path VARCHAR(100) NOT NULL,
	ref_id VARCHAR(100),			
	created_date TIMESTAMP WITHOUT TIME ZONE default NOW());

CREATE TABLE demo_person ( 
	id uuid DEFAULT uuid_generate_v4 () PRIMARY KEY,
	name VARCHAR NOT NUll,
	img VARCHAR NOT NULL,
	created_date TIMESTAMP WITHOUT TIME ZONE default NOW()
);

CREATE TABLE demo_mood ( 
	id SERIAL PRIMARY KEY,
	description VARCHAR(100) NOT NULL);
insert into demo_mood(description) values ('Happy');
insert into demo_mood(description) values ('Content');
insert into demo_mood(description) values ('Busy');
insert into demo_mood(description) values ('Frustrated');
insert into demo_mood(description) values ('Indifferent');

CREATE TABLE demo_insight (
	id serial PRIMARY KEY,
	description VARCHAR(100) NOT NULL);		

CREATE TABLE demo_survey_source (
	id serial PRIMARY KEY,
	description VARCHAR NOT NULL
);

CREATE TABLE demo_survey (
	id serial PRIMARY KEY,
	description VARCHAR NOT NULL,
	source_id integer REFERENCES demo_survey_source(id),
	created_date TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);

CREATE TABLE demo_survey_campaign (
	id serial PRIMARY KEY,
	survey_id integer REFERENCES demo_survey,
	user_id uuid REFERENCES demo_user NOT NULL,
	created_date TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
    );

CREATE TABLE demo_survey_note (
	campaign_id integer REFERENCES demo_survey_campaign,
	note Text
);

CREATE TABLE demo_survey_mood (
	campaign_id integer REFERENCES demo_survey_campaign NOT NULL,
	mood_id integer references demo_mood NOT NULL
);

CREATE TABLE demo_survey_insight (
	campaign_id integer REFERENCES demo_survey_campaign NOT NULL,
	insight_id integer REFERENCES demo_insight NOT NULL,
	person_id uuid REFERENCES demo_person
);
						 

CREATE PROCEDURE public.ins_survey_campaign(campaign json)
    LANGUAGE 'plpgsql'
AS $BODY$

BEGIN
	insert into demo_survey_campaign(survey_id, user_id)
	select x.survey_id, x.user_id from json_to_recordset(campaign::json->'user') x 
	(
    	survey_id int,
 		user_id uuid	
	);       
	
	insert into demo_survey_note(campaign_id, note)
	select currval('demo_survey_campaign_id_seq'), x.note from json_to_recordset(campaign::json->'note') x
	(
		note text
	);
	
	insert into demo_survey_mood(campaign_id, mood_id)
	select currval('demo_survey_campaign_id_seq'), x.mood_id from json_to_recordset(campaign::json->'mood') x
	(
		mood_id int
	);
	
	insert into demo_survey_insight(campaign_id, insight_id, person_id)
	select currval('demo_survey_campaign_id_seq'), x.insight_id, x.person_id from json_to_recordset(campaign::json->'insight') x
	(
		insight_id int,
		person_id uuid
	);
	
	COMMIT;
   END;
$BODY$;
