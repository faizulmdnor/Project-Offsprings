select * FROM Person
select * FROM Person_status
select * from Gender

ALTER VIEW vw_Person AS(
select
	p.id,
	p.First_Name,
	p.Last_Name,
	p.Birth_Cert AS [No. Sijil Lahir],
	p.ID_Number AS [No. Kad Pengenalan],
	g.Gender AS Jantina,
	s.Status,
	p.email_add
from Person p
LEFT JOIN Gender g ON g.Gender_id = p.Gender_id
LEFT JOIN Person_status s ON s.Status_id = p.Status_id
);

SELECT * FROM vw_Person

DELETE FROM Person

ALTER TABLE Person
ADD email_add VARCHAR(255)

SELECT * FROM PERSON

UPDATE Person
SET email_add = ''
WHERE id = 1007;
