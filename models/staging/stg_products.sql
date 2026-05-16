with source as (
    select * from {{ source('raw', 'raw_products') }}
),

renamed as (
    select
        product_id,
        product_name,
        category,
        price_in_cents,
        {{ cents_to_dollars('price_in_cents') }} as price,
        cast(created_at as date) as product_created_at
    from source
)

select * from renamed