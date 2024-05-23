-- --------------------------------------------------------------------------------------------
-- Author      : Adam MacLeod
-- Description : Creates a diff between two models
--
-- Arguments   : old_model:      The old model
--               old_unique_key: The column or formula to uniquely identify rows in `old_model`
--               new_model:      The new model
--               new_unique_key: The column or formula to uniquely identify rows in `new_model`
--               columns:        A list of columns which should be compared between the models
-- --------------------------------------------------------------------------------------------

{% macro diff(
    old_model,
    old_unique_key,
    new_model,
    new_unique_key,
    columns
) %}

WITH old AS (
    SELECT
        {{ old_unique_key }} as old_unique_key,
        *
    FROM {{ old_model }}
),
new AS (
    SELECT
        {{ new_unique_key }} as new_unique_key,
        * 
    FROM {{ new_model }}
)

SELECT
    coalesce(old_unique_key, new_unique_key) as unique_key,

    CASE
        WHEN old_unique_key IS NOT NULL AND new_unique_key IS NOT NULL THEN 'Both'
        WHEN old_unique_key IS NOT NULL THEN 'Old only'
        ELSE 'New only'
    END AS exists_in,

    ARRAY_TO_STRING(
        ARRAY[
            {% for col in columns -%}
                CASE WHEN old.{{ col }} IS DISTINCT FROM new.{{ col }} THEN '{{ col }}' END
                {{ "," if not loop.last }}
            {% endfor -%}
        ], 
        ', '
    ) AS non_matching_columns,

    {% for col in columns %}
        old.{{ col }} AS old_{{ col }},
        new.{{ col }} AS new_{{ col }}{{ "," if not loop.last }}
    {% endfor -%}

FROM old
FULL OUTER JOIN new
    ON old_unique_key = new_unique_key

{% endmacro %}

