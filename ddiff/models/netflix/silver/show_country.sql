SELECT
    show_id,
    TRIM(UNNEST(STRING_SPLIT(country, ','))) as country
FROM {{ ref('show') }}
WHERE 
    country IS NOT NULL
