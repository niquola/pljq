--db:test -e
--{{{
DROP EXTENSION IF EXISTS jsonb_extra;
CREATE EXTENSION jsonb_extra;

SELECT jsonb_extract('{"a":"1", "b":{"c":"2", "d": [1,2,{"x":100}], "e":{"f": 4}}}', '{b,e,f}');
SELECT jsonb_extract('{"b":{"c":"2"}}', '{b,c}');
SELECT jsonb_extract('{"b":[{"c":1},{"c":2},{"x":"ups"}]}', '{b,c}');


SELECT jsonb_extract('{"b":[{"c":{"x": 5}},{"c":2},{"x":"ups"}]}', '{b,c}');

SELECT jsonb_extract_text('{"b":[{"c":{"x": 5}},{"c":2},{"x":"ups"}]}', '{b,c}');
SELECT jsonb_extract_text('{"a":{"b":[{"c":[{"x": 5}]},{"c":[{"x": 6},{"x":"ups"}]}]}}', '{a,b,c,x}');


SELECT jsonb_as_text('"x"'::jsonb);
SELECT jsonb_as_text('1'::jsonb);
SELECT jsonb_as_text('true'::jsonb);
SELECT jsonb_as_text('null'::jsonb);
SELECT jsonb_as_text('[]'::jsonb);
SELECT jsonb_as_text('{}'::jsonb);

--}}}

--{{{
SELECT jsonb_update('{}'::jsonb, '{a,b,c}'::text[], '5'::jsonb);
SELECT jsonb_update('{"a":{"b":{"c":1, "d": 7}}}'::jsonb, '{a,b,c}'::text[], '5'::jsonb);
SELECT jsonb_update('{"a":{"b":{"c":1, "d": 7}}}'::jsonb, '{a,b,c}'::text[], '{"x":19}'::jsonb);
--}}}
