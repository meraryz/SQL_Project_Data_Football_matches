/*
    Stats about the top 6 teams result percentage with low possesssion (under 50%)
*/

WITH possession_data AS (
    SELECT
        home_team AS team,
        home_possession AS possession,
        result,
        'home' AS side
    FROM football_matches
    UNION ALL
    SELECT
        away_team AS team,
        away_possession AS possession,
        result,
        'away' AS side
    FROM football_matches
),
binned_data AS (
    SELECT
        team,
        result,
        side,
        CASE
            WHEN possession BETWEEN 20 AND 29.9 THEN '20-29.9%'
            WHEN possession BETWEEN 30 AND 39.9 THEN '30-39.9%'
            WHEN possession BETWEEN 40 AND 49.9 THEN '40-49.9%'
        END AS possession_range
    FROM possession_data
    WHERE possession BETWEEN 20 AND 49.9 AND
    team IN ('Manchester City', 'Chelsea', 'Manchester United', 'Liverpool', 'Arsenal', 'Tottenham Hotspur')
)

SELECT
    team,
    possession_range,
    ROUND(100.0 * COUNT(CASE WHEN (side = 'home' AND result = 0) OR (side = 'away' AND result = 1) THEN 1 END) / COUNT(*), 2) AS win_percentage,
    ROUND(100.0 * COUNT(CASE WHEN (side = 'home' AND result = 1) OR (side = 'away' AND result = 0) THEN 1 END) / COUNT(*), 2) AS lose_percentage,
    ROUND(100.0 * COUNT(CASE WHEN result = 2 THEN 1 END) / COUNT(*), 2) AS draw_percentage
FROM binned_data
WHERE possession_range IS NOT NULL
GROUP BY team, possession_range
ORDER BY team, possession_range
