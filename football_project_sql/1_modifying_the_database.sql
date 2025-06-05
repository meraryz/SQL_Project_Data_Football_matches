
-- Adding a column that displays the table score per game for the home team

ALTER TABLE football_matches
add column home_table_score INT;

UPDATE football_matches
SET home_table_score = 3
WHERE result = 0;

UPDATE football_matches
SET home_table_score = 1
WHERE result = 2;

UPDATE football_matches
SET home_table_score = 0
WHERE result = 1;

-- Adding a column that displays the table score per game for the away team

ALTER TABLE football_matches
add column away_table_score INT;

UPDATE football_matches
SET away_table_score = 0
WHERE result = 0;

UPDATE football_matches
SET away_table_score = 1
WHERE result = 2;

UPDATE football_matches
SET away_table_score = 3
WHERE result = 1;

SELECT *
FROM football_matches
ORDER by match_id

-- Delete the 20/21 season beacuse it wasn't completed by the writing of this table
Delete FROM football_matches
WHERE season = '20/21'
