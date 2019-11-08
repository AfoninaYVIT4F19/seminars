-- Данный скрипт можно запускать либо в pgAdmin, либо в SQL Shell (psql).
-- В pgAdmin нужно подключиться к БД, открыть Query Tool, вызвать скрипт через Open и исполнить через Execute.
-- В SQL Shell (pqsl) нужно подключиться к БД и ввести команду \i [путь к файлу].

-- Далее идут команды для создания и импорта данных в таблицу sec_listed, данные доступны по ссылке в групповой почте.

-- Команда удаляет предыдущую версию таблицы, если такая уже есть в базе.
DROP TABLE if exists public.sec_listed
;

-- Команда создает таблицу в БД с требуемым составом полей в нужных форматах
CREATE TABLE public.sec_listed
(
   "INSTRUMENT_ID" smallint NOT NULL,
	"LIST_SECTION" text NOT NULL,
	"SUPERTYPE" text NOT NULL,
	"INSTRUMENT_TYPE" text NOT NULL,
	"INSTRUMENT_CATEGORY" text NOT NULL,
	"TRADE_CODE" text,
	"ISIN" text,
	"REGISTRY_NUMBER" text,
	"REGISTRY_DATE" date,
	"EMITENT_FULL_NAME" text,
	"INN" bigint,
	"NOMINAL" real,
	"CURRENCY" text,
	"DECISION_DATE" date,
	"HAS_PROSPECTUS" boolean,
	"IS_MORTGAGE_AGENT" boolean,
	"INCLUDED_DURING_CREATION" boolean,
	"SECURITY_HAS_DEFAULT" boolean,
	"SECURITY_HAS_TECH_DEFAULT" boolean,
	"LISTING_LEVEL_HIST" text,
	"OBLIGATION_PROGRAM_RN" text,
	"COUPON_PERCENT" real,
	"EARLY_REPAYMENT" boolean,
	"EARLY_REDEMPTION" boolean,
	"ISS_BOARDS" text,
	"DISCLOSURE_RF_INFO_PAGE" text,
	CONSTRAINT sec_listed_pkey PRIMARY KEY ("INSTRUMENT_ID")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Команда назначает владельца таблицу (необязательная команда).
ALTER TABLE public.sec_listed
    OWNER to postgres;
	
-- Для пользователей Mac!!! Команда смены стиля даты. Внимание: убедитесь, то в команде верно указано название БД.

ALTER DATABASE postgres SET datestyle TO "ISO, DMY"; 

-- Команда для импорта данных из файла в готовую таблицу

-- Внимание! PostgreSQL Server имеет ограниченные права доступа к файлам. Команда COPY будет работать из pgAdmin
-- только, если загружаемый файл находится в папке с публичным доступом (например, ~\User\Public для Windows,
-- /tmp для Mac). Альтернатива - использовать команду \COPY, которая обходит все права доступа, но ее нужно запускать
-- из терминала SQL Shell (psql). Ниже представлены оба вариант. Используйте тот, который Вам больше нравится. 

-- copy public.sec_listed  FROM 'C:/Users/Public/listing_tab.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';
\copy public.sec_listed  FROM 'C:/Users/Public/listing_tab.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';

-- Результат исполнения скрипта - таблица sec_listed, имеющая 2110 строк.
	