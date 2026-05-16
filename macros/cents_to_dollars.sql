{% macro cents_to_dollars(column_name) %}
    round({{ column_name }} / 100, 2)
{% endmacro %}