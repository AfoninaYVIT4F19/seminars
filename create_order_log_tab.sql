-- Данный скрипт можно запускать либо в pgAdmin, либо в SQL Shell (psql).
-- В pgAdmin нужно подключиться к БД, открыть Query Tool, вызвать скрипт через Open и исполнить через Execute.
-- В SQL Shell (pqsl) нужно подключиться к БД и ввести команду \i [путь к файлу].

-- Далее идут команды для создания и импорта данных в таблицу order_log, данные доступны по ссылке в групповой почте.

-- Команда удаляет предыдущую версию таблицы, если такая уже есть в базе.
DROP TABLE IF EXISTS public.order_log;

-- Команда создает таблицу в БД с требуемым составом полей в нужных форматах
CREATE TABLE public.order_log
(
    "NO" integer NOT NULL,
    "SECCODE" text NOT NULL,
    "BUYSELL" "char" NOT NULL,
    "TIME" bigint NOT NULL,
    "ORDERNO" integer NOT NULL,
    "ACTION" integer NOT NULL,
    "PRICE" real NOT NULL,
    "VOLUME" bigint NOT NULL,
    "TRADENO" bigint,
    "TRADEPRICE" real,
    CONSTRAINT order_log_pkey PRIMARY KEY ("NO")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Команда назначает владельца таблицу (необязательная команда).
ALTER TABLE public.order_log
    OWNER to postgres;

-- Команда для импорта данных из файла в готовую таблицу

-- Внимание! PostgreSQL Server имеет ограниченные права доступа к файлам. Команда COPY будет работать из pgAdmin
-- только, если загружаемый файл находится в папке с публичным доступом (например, ~\User\Public для Windows,
-- /tmp для Mac). Альтернатива - использовать команду \COPY, которая обходит все права доступа, но ее нужно запускать
-- из терминала SQL Shell (psql). Ниже представлены оба вариант. Используйте тот, который Вам больше нравится. 

-- copy public.order_log  FROM 'C:/Users/Public/OrderLog20151123.csv' DELIMITER ',' CSV HEADER;
\copy public.order_log  FROM 'C:/Users/Public/OrderLog20151123.csv' DELIMITER ',' CSV HEADER;

-- Результат исполнения скрипта - таблица order_log, имеющая порядка 15 млн строк.