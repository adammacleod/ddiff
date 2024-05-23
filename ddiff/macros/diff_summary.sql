-- -------------------------------------------------------------------
-- Author      : Adam MacLeod
-- Description : Creates a summary of differences between two models
--
-- Arguments   : diff_model: The source diff that we want to summarise
-- -------------------------------------------------------------------

{% macro diff_summary(
    diff_model
) %}
    SELECT 
        exists_in,
        non_matching_columns,
        count(*) AS count
    FROM {{ diff_model }}
    GROUP BY 1,2
    ORDER BY 1,2
{% endmacro %}




