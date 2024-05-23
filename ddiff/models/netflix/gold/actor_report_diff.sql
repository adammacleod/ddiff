-- TODO: How to stop this erroring on first run? Probably include the database in the commit..
{{ diff(
    "main_netflix.old_actor_report",
    "actor",
    ref("actor_report"),
    "actor",
    [
        "actor",
        "count_shows",
        "count_movies",
        "count_tv_shows",
        "count_country_visits",
        "count_distinct_countries"
    ]
) }}
