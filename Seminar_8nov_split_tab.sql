DROP TABLE IF EXISTS public.emitent;

-- создание таблицы для выноса информации
CREATE TABLE public.emitent
(
    "emt_id" bigint NOT NULL,
    "EMITENT_FULL_NAME" text,
	"INN" bigint,
	"DISCLOSURE_RF_INFO_PAGE" text,
    CONSTRAINT anyname PRIMARY KEY ("emt_id")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.emitent
    OWNER to postgres;

-- запрос и копирование инфорамции из исходной таблицы в новую
insert into emitent select count(*) over (order by "EMITENT_FULL_NAME", "INN","DISCLOSURE_RF_INFO_PAGE") as emt_id,
"EMITENT_FULL_NAME", "INN","DISCLOSURE_RF_INFO_PAGE"
from (select distinct "EMITENT_FULL_NAME","INN","DISCLOSURE_RF_INFO_PAGE"
from sec_listed)
 as my_select;


-- добавление в исходную таблицу поля с кодами-ссылками на новую таблицу
alter table sec_listed add column "emt_id" bigint;

-- заполнение поле с кодами-ссылками на новую таблицу
update sec_listed 
set emt_id=emitent.emt_id
from emitent
where sec_listed."EMITENT_FULL_NAME"=emitent."EMITENT_FULL_NAME"
;

-- присвоение полю ограничение внешнего ключа
ALTER TABLE public.sec_listed 
ADD CONSTRAINT fr_key_1 FOREIGN KEY (emt_id) REFERENCES public.emitent (emt_id);

-- удаление вынесенной информации из исходной таблицы
-- напишите сами