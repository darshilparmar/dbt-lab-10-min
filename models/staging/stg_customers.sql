with source as (
    select * from {{ source('raw', 'raw_customers') }}
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name,
        lower(email) as email,
        city,
        country,
        cast(created_at as date) as customer_created_at
    from source
)

select * from renamed