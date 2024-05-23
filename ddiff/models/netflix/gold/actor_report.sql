WITH 
actor_shows as (
    SELECT
        actor,
        count(show_id) count_shows,
        sum(IF("type" = 'Movie', 1, 0)) as count_movies,
        sum(IF("type" = 'TV Show', 1, 0)) as count_tv_shows
    FROM {{ ref('actor_show') }}
    GROUP BY
        actor
),

actor_countries as (
    SELECT
        actor,
        count(country) count_country_visits,
        count(distinct country) count_distinct_countries
    FROM {{ ref('actor_show') }}
    LEFT JOIN {{ ref('show_country')}}
        USING (show_id)
    GROUP BY
        actor
)

SELECT
    actor,
    count_shows,
    count_movies,
    count_tv_shows,
    count_country_visits,
    count_distinct_countries

FROM {{ ref('actor') }} actor

LEFT JOIN actor_shows
    USING (actor)

LEFT JOIN actor_countries
    USING (actor)
