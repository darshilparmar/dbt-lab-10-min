with orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

final as (
    select
        orders.order_id,
        orders.order_date,
        orders.order_status,
        orders.quantity,
        customers.full_name as customer_name,
        products.product_name,
        products.price as unit_price,
        payments.payment_method,
        payments.amount as payment_amount,
        case when payments.payment_status = 'refunded' then true else false end as is_refunded
    from orders
    left join payments on orders.order_id = payments.order_id
    left join products on orders.product_id = products.product_id
    left join customers on orders.customer_id = customers.customer_id
)

select * from final