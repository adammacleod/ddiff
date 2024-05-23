SELECT
    {# DISTINCT #}
    TRIM(UNNEST(STRING_SPLIT("cast", ','))) as actor,
    show_id,
    "type"
FROM {{ ref('show')}}
