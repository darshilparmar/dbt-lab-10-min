select
    payment_id,
    amount
from {{ ref('stg_payments') }}
where payment_status = 'success'
  and amount <= 0