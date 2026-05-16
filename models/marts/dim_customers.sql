with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

customer_orders as (
    select
        customer_id,
        count(order_id) as total_orders
    from orders
    group by customer_id
),

customer_payments as (
    select
        orders.customer_id,
        sum(case when payments.payment_status = 'success' then payments.amount else 0 end) as lifetime_value
    from payments
    left join orders on payments.order_id = orders.order_id
    group by orders.customer_id
),

final as (
    select
        customers.customer_id,
        customers.full_name,
        customers.email,
        customers.city,
        customers.country,
        coalesce(customer_orders.total_orders, 0) as total_orders,
        coalesce(customer_payments.lifetime_value, 0) as lifetime_value
    from customers
    left join customer_orders on customers.customer_id = customer_orders.customer_id
    left join customer_payments on customers.customer_id = customer_payments.customer_id
)

select * from final