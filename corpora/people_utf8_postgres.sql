/* Muldis_Content_Predicate
MCP version http://muldis.com 0.300.0 MCP
MCP script text Unicode 2.1 UTF-8 MCP
MCP syntax SQL https://postgresql.org 11.0 MCP
MCP model SQL https://postgresql.org 11.0 MCP
MCP comment "This, that, and the other." MCP
Muldis_Content_Predicate */

select * from (values
    ('Jane Ives', '1971-11-06'::date, array['+1.4045552995', '+1.7705557572']),
    ('Layla Miller', '1995-08-27'::date, array[]::text[]),
    ('岩倉 玲音', '1984-07-06'::date, array['+81.9072391679'])
) as r (name, birth_date, phone_numbers)
