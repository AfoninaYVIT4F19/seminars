-- Запрос join со второго семинара по SQL и БД

select DISTINCT "EMITENT_FULL_NAME"
from public.emitent INNER JOIN 
	(select DISTINCT emt_id 
	from public.sec_listed inner JOIN public.order_log
	ON public.sec_listed."TRADE_CODE"=public.order_log."SECCODE") as some_name
	ON public.emitent.emt_id=some_name.emt_id
	;