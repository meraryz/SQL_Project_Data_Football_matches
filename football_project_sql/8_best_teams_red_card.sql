/*
    Stats about the difference in the top 6 teams' permormance with a red card.
*/

WITH red_card_teams AS (
SELECT
    home_team AS team,
    'home with red card' AS side,
    ROUND(100.0 * COUNT(CASE WHEN result = 0 THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 1 THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM football_matches
WHERE home_red_cards > 0 AND
home_team IN ('Manchester City', 'Chelsea', 'Manchester United', 'Liverpool', 'Arsenal', 'Tottenham Hotspur')
GROUP BY team

UNION ALL

SELECT
    away_team AS team,
    'away with red card' AS side,
    ROUND(100.0 * COUNT(CASE WHEN result = 1 THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 0 THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM football_matches
WHERE away_red_cards > 0 AND
away_team IN ('Manchester City', 'Chelsea', 'Manchester United', 'Liverpool', 'Arsenal', 'Tottenham Hotspur')
GROUP BY team
ORDER BY team, side DESC
)

SELECT
    'average' AS team,
    'home with red card' AS side,
    ROUND(100.0 * COUNT(CASE WHEN result = 0 THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 1 THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM football_matches
WHERE home_red_cards > 0

UNION ALL

SELECT
    'average' AS team,
    'away with red card' AS side,
    ROUND(100.0 * COUNT(CASE WHEN result = 1 THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 0 THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM football_matches
WHERE away_red_cards > 0

UNION ALL

SELECT *
FROM red_card_teams


