/*
    Stats about the difference in permormance between home and away games within the best teams in the league.
*/


WITH stats_by_teams AS (
SELECT
    home_team AS team,
    'home' AS side,
    ROUND(100.0*COUNT(CASE WHEN result = 0 THEN 1 END)/COUNT(*), 2) AS win_percentage,
    ROUND(AVG(home_yellow_cards::numeric), 3) AS yellow_cards_avg,
    ROUND(AVG(home_red_cards::numeric), 3) AS red_cards_avg,
    ROUND(AVG(home_possession::numeric), 2) AS possession_avg,
    ROUND(AVG(goal_home_ft::numeric), 2) AS gf_avg,
    ROUND(AVG(goal_away_ft::numeric), 2) AS ga_avg
FROM football_matches
WHERE home_team IN ('Manchester City', 'Chelsea', 'Manchester United', 'Liverpool', 'Arsenal', 'Tottenham Hotspur')
GROUP BY team

UNION ALL

SELECT
    away_team AS team,
    'away' AS side,
    ROUND(100.0*COUNT(CASE WHEN result = 1 THEN 1 END)/COUNT(*), 2) AS win_percentage,
    ROUND(AVG(away_yellow_cards::numeric), 3) AS yellow_cards_avg,
    ROUND(AVG(away_red_cards::numeric), 3) AS red_cards_avg,
    ROUND(AVG(away_possession::numeric), 2) AS possession_avg,
    ROUND(AVG(goal_away_ft::numeric), 2) AS gf_avg,
    ROUND(AVG(goal_home_ft::numeric), 2) AS ga_avg
FROM football_matches
WHERE away_team IN ('Manchester City', 'Chelsea', 'Manchester United', 'Liverpool', 'Arsenal', 'Tottenham Hotspur')
GROUP BY team
ORDER BY team, side DESC
)

SELECT
    'league average' AS team,
    'home' AS side,
    ROUND(100.0*COUNT(CASE WHEN result = 0 THEN 1 END)/COUNT(*), 2) AS win_percentage,
    ROUND(AVG(home_yellow_cards::numeric), 3) AS yellow_cards_avg,
    ROUND(AVG(home_red_cards::numeric), 3) AS red_cards_avg,
    ROUND(AVG(home_possession::numeric), 2) AS possession_avg,
    ROUND(AVG(goal_home_ft::numeric), 2) AS gf_avg,
    ROUND(AVG(goal_away_ft::numeric), 2) AS ga_avg
FROM football_matches

UNION ALL

SELECT
    'league average' AS team,
    'away' AS side,
    ROUND(100.0*COUNT(CASE WHEN result = 1 THEN 1 END)/COUNT(*), 2) AS win_percentage,
    ROUND(AVG(away_yellow_cards::numeric), 3) AS yellow_cards_avg,
    ROUND(AVG(away_red_cards::numeric), 3) AS red_cards_avg,
    ROUND(AVG(away_possession::numeric), 2) AS possession_avg,
    ROUND(AVG(goal_away_ft::numeric), 2) AS gf_avg,
    ROUND(AVG(goal_home_ft::numeric), 2) AS ga_avg
FROM football_matches

UNION ALL

SELECT
    *
FROM stats_by_teams
