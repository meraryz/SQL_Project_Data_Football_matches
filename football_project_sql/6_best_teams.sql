/*
 Using the table I created at section 2 to find the top 7 teams using the following parameters:
 1. Number of league championship (position 1).
 2. Number of times the position was in the top 4 (1-4).
 3. Average position (1-20).
 4. Number of appearances in the premier league.
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
),

filtered_season_table AS (
SELECT
    season,
    ROW_number() OVER (PARTITION BY season ORDER BY SUM(score) DESC, SUM(gf - ga) DESC, SUM(ga)) AS position,
    team
FROM
    season_table
GROUP BY
    season, team
ORDER BY
    season, position
    
)

SELECT
    team,
    average_position,
    top_4,
    league_championships,
    league_appearances
FROM (
    SELECT
    team,
    COUNT(CASE WHEN position = 1 THEN 1 END) AS league_championships,
    COUNT(CASE WHEN position BETWEEN 1 AND 4 THEN 1 END) AS top_4,
    ROUND(AVG(position)::numeric, 0) AS average_position,
    COUNT(*) AS league_appearances

    FROM filtered_season_table
    GROUP BY team
)
ORDER BY average_position, top_4 DESC, league_championships DESC, league_appearances DESC
LIMIT 6