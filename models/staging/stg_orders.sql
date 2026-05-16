with source as (
    select * from {{ source('raw', 'raw_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        product_id,
        quantity,
        cast(order_date as date) as order_date,
        lower(status) as order_status
    from source
)

select * from renamed