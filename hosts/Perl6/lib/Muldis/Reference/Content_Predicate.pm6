module Muldis::Reference::Content_Predicate
{
    sub extract_MCP_from_Text(Str:D $text)
    {
        return Muldis::Reference::Content_Predicate::Grammar.parse(
            $text,
            :token<parsing_unit>,
            :actions(Muldis::Reference::Content_Predicate::Actions.new())
        );
    }
}

grammar Muldis::Reference::Content_Predicate::Grammar
{
    token parsing_unit
    {
        .*
            <predicate_block>
        .*
    }

    token predicate_block
    {
        Muldis_Content_Predicate
            <predicate>*
        Muldis_Content_Predicate
    }

    token predicate
    {
        .*
            MCP
                <sp>
                    <name> <sp> [<term>+ % <sp>]
                <sp>
            MCP
        .*
    }

    token sp
    {
        [' ' | '\t' | '\n' | '\r']+
    }

    token name
    {
        version | script | syntax | model | comment
    }

    token term
    {
        <bare_term> | <quoted_term>
    }

    token bare_term
    {
        <-[ \x[0]..\x[1F] \x[20] " \x[80]..\x[9F] ]>+
    }

    token quoted_term
    {
        '"'
            <-[ \x[0]..\x[1F] " \x[80]..\x[9F] ]>*
        '"'
    }
}

class Muldis::Reference::Content_Predicate::Actions
{
}
