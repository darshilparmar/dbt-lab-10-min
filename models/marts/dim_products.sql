with products as (
    select * from {{ ref('stg_products') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

product_stats as (
    select
        product_id,
        sum(quantity) as total_units_sold
    from orders
    group by product_id
),

final as (
    select
        products.product_id,
        products.product_name,
        products.category,
        products.price,
        coalesce(product_stats.total_units_sold, 0) as total_units_sold,
        coalesce(product_stats.total_units_sold * products.price, 0) as total_revenue
    from products
    left join product_stats on products.product_id = product_stats.product_id
)

select * from final