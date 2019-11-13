-- Полезные запросы с полями в форматах DATE и TIMESTAMP

-- Даты можно сравнивать и можно вычитать (результат будет дан в календарных днях) 
select "TRADE_CODE", "REGISTRY_DATE" - current_date 
from public.sec_listed
;

-- Забавная функция age, которая вычисляет время, прошедшее с заданной даты к текушему моменту.
select "TRADE_CODE", age("REGISTRY_DATE")
from public.sec_listed
;


-- Функция extract (работает также как date_part) позволяется извлекать компоненты даты и времени (например, компоненты результата age) 
-- (декады, года, месяцы, недели, дни, а также дни года, дню недели  и т.д.). Удобно использовать,когда нужно агрегировать данные
-- внутри года или исследовать сезонное поведения агрегатов.

select "TRADE_CODE", extract(year from "REGISTRY_DATE"), extract(year from age("REGISTRY_DATE")) extract(dow from "REGISTRY_DATE"), "REGISTRY_DATE" 
from public.sec_listed
;

-- Функция приведения к началу периода date_trunc. Удобно использовать для агрегирования информация по периодам: еженедельно,
-- ежемесечно и т.д. 
select count("TRADE_CODE"),date_trunc('month', "REGISTRY_DATE") 
from public.sec_listed
GROUP BY date_trunc('month', "REGISTRY_DATE")
;

-- БОНУС!!! Очень полезное выражение LAG ... OVER, которое позволяет смещать значения одного столбца относительно
-- другого или самого себя на выбраное число позиций. Используется для вычисления приращений во времени или относительно ранжирования.

select "TRADE_CODE", "REGISTRY_DATE", lag("REGISTRY_DATE", 1) over (order by "REGISTRY_DATE"), 
 "REGISTRY_DATE" - lag("REGISTRY_DATE", 1) over (order by "REGISTRY_DATE")
from public.sec_listed
;
