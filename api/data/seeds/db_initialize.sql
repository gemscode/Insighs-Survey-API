
insert into demo_user(name, img_path) values ('John Smith','/static/images/2.png');

insert into demo_person(name,img) values ('Charles Fonda','/static/images/10.png');
insert into demo_person(name,img) values ('Cindy Baker','/static/images/3.png');
insert into demo_person(name,img) values ('Agnes Walker','/static/images/4.png');
insert into demo_person(name,img) values ('Cecile Johnson','/static/images/7.png');
insert into demo_person(name,img) values ('Trevor Henderson','/static/images/6.png');

insert into demo_mood(description) values ('Happy');
insert into demo_mood(description) values ('Content');
insert into demo_mood(description) values ('Busy');
insert into demo_mood(description) values ('Frustrated');
insert into demo_mood(description) values ('Indifferent');

insert into demo_insight(description) values ('Collaboration');
insert into demo_insight(description) values ('Mentorship');
insert into demo_insight(description) values ('Feedback');
insert into demo_insight(description) values ('Impactful Work');
insert into demo_insight(description) values ('Kind Words');
insert into demo_insight(description) values ('Learning');
insert into demo_insight(description) values ('Other');


insert into demo_survey_source(description) values ('Github');


insert into demo_survey(description,source_id) values ('Codegems Challenge: Chrome Extension Insight Survey',1);


select id from demo_user
select id from demo_survey
insert into demo_survey_campaign (survey_id, user_id) values (1,'201de8f2-2f5d-490b-bdd5-7ea0f3a6876a');
insert into demo_survey_campaign (survey_id, user_id) values (2,'114ea085-1410-43c6-b347-1d7a900fdc51')

select id from demo_person;

CALL public.ins_survey_campaign('{
	"user": [{"survey_id":1, "user_id":"201de8f2-2f5d-490b-bdd5-7ea0f3a6876a"}],
	"mood": [{"mood_id":1}], 
	"insight": [{"insight_id":1,"person_id":"21402891-b4d7-4f10-9859-f51654cb6890"}],
	"note":[{"note":"my note"}]}');


select * from demo_survey_campaign as c
inner join demo_survey_note as n ON n.campaign_id = c.id;

select * from demo_survey_campaign