--
-- HYPERLOGLOG
--
set enable_oracle_compatible = on;
-- Basic tests for approx_count_distinct
SELECT approx_count_distinct(tenthous) from onek;
SELECT approx_count_distinct(four) from onek;
SELECT approx_count_distinct(stringu1) from onek;
-- Combined arithmetic tests for approx_count_distinct
SELECT approx_count_distinct(fivethous + tenthous) from onek;
SELECT approx_count_distinct(twothousand - unique1) from onek;
SELECT approx_count_distinct(unique2 * even) from onek;
-- test for where clause
select approx_count_distinct(four) from onek where unique1 % 2 = 0;
-- test for filter clause
select ten, approx_count_distinct(four) filter (where four::text ~ '123') from onek a
group by ten order by 1;
-- test for group by & having clause
select ten, approx_count_distinct(four) filter (where four > 10) from onek a
group by ten
having exists (select 1 from onek b where sum(distinct a.four) = b.four)
order by ten;

-- multi-data-type tests
CREATE TABLE multi_type (
  id		    int4,
  name      varchar(31),
  person    text,
  f         float,
  bool      boolean,
  birth     timestamp,
  ip        inet,
  mac       macaddr,
  bit       bit(4)
);

INSERT INTO multi_type (id, name, person, f, bool, birth, ip, mac, bit) VALUES
(1, 'Alice', 'Alice Smith', 3.14, true, '1990-05-15 08:30:00', '192.168.1.10', '08:00:2b:01:02:03', B'1010');
INSERT INTO multi_type (id, name, person, f, bool, birth, ip, mac, bit) VALUES
(2, 'Bob', 'Bob Johnson', 2.71, false, '1985-11-20 14:45:00', '10.0.0.5', '08:00:2b:04:05:06', B'1100');
INSERT INTO multi_type (id, name, person, f, bool, birth, ip, mac, bit) VALUES
(3, 'Charlie', 'Charlie Brown', 1.618, true, '1995-01-30 09:15:00', '172.16.254.3', '08:00:2b:07:08:09', B'1111');
INSERT INTO multi_type (id, name, person, f, bool, birth, ip, mac, bit) VALUES
(4, 'Dana', 'Dana White', 0.577, false, '1988-03-22 18:00:00', '203.0.113.15', '08:00:2b:0a:0b:0c', B'0001');
INSERT INTO multi_type (id, name, person, f, bool, birth, ip, mac, bit) VALUES
(5, 'Eve', 'Eve Adams', 1.414, true, '1992-07-10 12:00:00', '192.0.2.20', '08:00:2b:0d:0e:0f', B'0010');

SELECT approx_count_distinct(id) from multi_type;
SELECT approx_count_distinct(name) from multi_type;
SELECT approx_count_distinct(person) from multi_type;
SELECT approx_count_distinct(f) from multi_type;
SELECT approx_count_distinct(bool) from multi_type;
SELECT approx_count_distinct(birth) from multi_type;
SELECT approx_count_distinct(ip) from multi_type;
SELECT approx_count_distinct(mac) from multi_type;
SELECT approx_count_distinct(bit) from multi_type;

set enable_oracle_compatible = off;
SELECT approx_count_distinct(tenthous) from onek;
SELECT approx_count_distinct(four) from onek;
SELECT approx_count_distinct(stringu1) from onek;

drop table multi_type;