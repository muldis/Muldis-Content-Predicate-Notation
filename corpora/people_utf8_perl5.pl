#!/usr/bin/env perl

# Muldis_Content_Predicate
# MCP version http://muldis.com 0.300.0 MCP
# MCP script text Unicode 2.1 UTF-8 MCP
# MCP syntax Perl http://perlfoundation.org 5.28 MCP
# MCP model Perl http://perlfoundation.org 5.28 MCP
# MCP comment "Laziness, Impatience and Hubris." MCP
# Muldis_Content_Predicate

use DateTime;
my $r = [
    {name => 'Jane Ives',
        birth_date => DateTime->new(year=>1971,month=>11,day=>6),
        phone_numbers => ['+1.4045552995', '+1.7705557572']},
    {name => 'Layla Miller',
        birth_date => DateTime->new(year=>1995,month=>8,day=>27),
        phone_numbers => []},
    {name => '岩倉 玲音',
        birth_date => DateTime->new(year=>1984,month=>7,day=>6),
        phone_numbers => ['+81.9072391679']},
];
