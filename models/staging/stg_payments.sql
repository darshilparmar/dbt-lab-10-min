with source as (
    select * from {{ source('raw', 'raw_payments') }}
),

renamed as (
    select
        payment_id,
        order_id,
        payment_method,
        amount_in_cents,
        {{ cents_to_dollars('amount_in_cents') }} as amount,
        cast(payment_date as date) as payment_date,
        lower(status) as payment_status
    from source
)

select * from renamed