/*
- I created a unified table combining home and away matches per team per season.

- All the columns are self-explanatory except:
GF - Goals For (the number of goals that the team scored)
GA - Goals Against (the number of goals that were scored against the team)
GD - Goal difference (GF - GA)

- The position of the team in the table is determined by the following priorities:
1. Total points.
2. Goals difference.
3. Number of Wins.
*/

WITH season_table AS (
SELECT
    season,
    home_team AS team,
    home_table_score AS score,
    goal_home_ft AS gf,
    goal_away_ft AS ga
FROM
    football_matches

UNION ALL

SELECT
    season,
    away_team,
    away_table_score,
    goal_away_ft AS gf,
    goal_home_ft AS ga
FROM
    football_matches
)

SELECT
    season,
    ROW_number() OVER (PARTITION BY season ORDER BY SUM(score) DESC, SUM(gf - ga) DESC, SUM(ga)) AS position,
    team,
    SUM(score) AS points,
    COUNT(CASE WHEN score = 3 THEN score ELSE NULL END) AS won,
    COUNT(CASE WHEN score = 1 THEN score ELSE NULL END) AS drawn,
    COUNT(CASE WHEN score = 0 THEN score ELSE NULL END) AS lost,
    SUM(gf) AS gf,
    SUM(ga) AS ga,
    SUM(gf - ga) AS gd
FROM
    season_table
GROUP BY
    season, team
ORDER BY
    season, position
    
