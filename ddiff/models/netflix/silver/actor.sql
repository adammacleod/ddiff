SELECT
    DISTINCT
    TRIM(UNNEST(STRING_SPLIT("cast", ','))) as actor
FROM {{ ref('show') }}
