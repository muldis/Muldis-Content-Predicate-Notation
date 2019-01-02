# NAME

Muldis Content Predicate (MCP) -
Format for source code metadata

# VERSION

The fully-qualified name of this document is
`Muldis_Content_Predicate http://muldis.com 0.300.0`.

# SYNOPSIS

## Muldis Object Notation (MUON)

```
    `Muldis_Content_Predicate
    MCP version http://muldis.com 0.300.0 MCP
    MCP script Unicode 2.1 UTF-8 MCP
    MCP syntax Muldis_Object_Notation http://muldis.com 0.300.0 MCP
    MCP model Muldis_Data_Language http://muldis.com 0.300.0 MCP
    MCP comment "You know it, I hear that." MCP
    Muldis_Content_Predicate`

    \?%{
        (name : "Jane Ives", birth_date : \@(1971,11,06,,,),
            phone_numbers : {"+1.4045552995", "+1.7705557572"}),
        (name : "Layla Miller", birth_date : \@(1995,08,27,,,), phone_numbers : {}),
        (name : "岩倉 玲音", birth_date : \@(1984,07,06,,,),
            phone_numbers : {"+81.9072391679"}),
    }
```

## SQL: Postgres

```PLpgSQL
    /* Muldis_Content_Predicate
    MCP version http://muldis.com 0.300.0 MCP
    MCP script Unicode 2.1 UTF-8 MCP
    MCP syntax SQL https://postgresql.org 11.0 MCP
    MCP model SQL https://postgresql.org 11.0 MCP
    MCP comment "This, that, and the other." MCP
    Muldis_Content_Predicate */

    select * from (values
        ('Jane Ives', '1971-11-06'::date, array['+1.4045552995', '+1.7705557572']),
        ('Layla Miller', '1995-08-27'::date, array[]::text[]),
        ('岩倉 玲音', '1984-07-06'::date, array['+81.9072391679'])
    ) as r (name, birth_date, phone_numbers)
```

## Perl 5

```Perl
    # Muldis_Content_Predicate
    # MCP version http://muldis.com 0.300.0 MCP
    # MCP script Unicode 2.1 UTF-8 MCP
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
```

# DESCRIPTION

This document is the human readable authoritative formal specification named
**Muldis Content Predicate** (**MCP**).
The fully-qualified name of this document and specification is
`Muldis_Content_Predicate http://muldis.com 0.300.0`.
This is the official/original version by the authority Muldis Data Systems
(`http://muldis.com`), version number `0.300.0`.

**Muldis Content Predicate** specifies a generic format for metadata that
makes source code and data more strongly typed, to improve the odds that a
recipient can parse it correctly and interpret its meaning as the sender
intended.  The main intended use case is with character data, particularly
source code or serialized data in some programming language, where said
language isn't easy to distinguish from others with casual and simple
examination, and so benefits from extra information being provided.

In this document, a *parsing unit* or *parsing unit subject* or *subject*
is the primary source code or data itself that we care about, which
generally takes the form in memory of a character string or binary string
*S*; parsing a well-formed *S* results in some logical value *N*.
Typically *N* comprises a *compilation unit* of the programming language in
question, such as a *package* or *module* or *class*, but it might also be
a value of some other type.

A *parsing unit predicate* or *predicate* is a guide for *how* to
unambiguously parse the *subject*, and generally takes the form in memory
of a character string or binary string like the *subject*; it includes such
details as a grammar version declaration and a text encoding declaration.
**MCP** defines the format of a *predicate* in this scenario.

When source code is kept in its own self-describing single file, as per
library or project conventions for typical general-purpose programming
languages or structured data files, the *parsing unit* is the file as a
whole, with the *parsing unit predicate* being embedded within that as a
form of in-band signalling, usually as the very first part of the file.

In this combined-file situation, a primary role of the *predicate* is to
serve as a "magic number" that identifies the file as being source code of
a particular language.  Its secondary role is to explicitly state the
character encoding and similar details of the file so that the file can be
correctly converted from octets to character data which most of the
language grammar assumes it is taking as input; this means the parser does
not have to rely on heuristics or other methods of determining encoding
that could be wrong.  Its tertiary role is to explicitly state what
versions of the language grammar the author of the source code believes the
latter is known to be compatible or incompatible with, so that the grammar
can be more free to evolve without that leading to parsers wrongly
interpreting code.

When source code is not kept in its own self-describing file, typically
when a source code repository is in use that provides context externally to
each *parsing unit subject* on how to interpret it, then the *subject* and
*predicate* are typically given to the parser as separate inputs, this
being out-of-band signalling.  This is particularly likely in situations
where a virtual machine environment interpreting the source code is a
library of some host language that is feeding in the source code piecemeal
(possibly generated), such as a typical DBMS client application may do.
Such uses would be served by not having to provide the *predicate*
boilerplate every time they want to run *subject* code, which often is very
small itself.

# GRAMMAR

The syntax and intended interpretation of the grammar itself seen in this
document should match that of the user-defined grammars feature of the Perl
6 (Raku) language, which is described by
[https://docs.perl6.org/language/grammars](
https://docs.perl6.org/language/grammars).

A fundamental exception is that this document uses a proprietary shorthand
in syntax for declaring each named grammar section.

Every time you see this:

```
    <foo> ::=
        ...
```

That is shorthand for this Perl 6 code:

```
    token foo
    {
        ...
    }
```

The shorthand is intended to aid human readability of the grammar and is
not meant to be consumed by a parser-generator, but it should have all the
needed details to derive an executable parser.

*This shorthand may be eliminated in favor of the full syntax.*

See also the bundled actual Perl 6 module
[hosts/Perl6/lib/Muldis/Reference/Content_Predicate.pm6](
hosts/Perl6/lib/Muldis/Reference/Content_Predicate.pm6)
which has the executable grammar written out in full.

Grammar:

```
    <parsing_unit> ::=
        .*
            <predicate_block>
        .*

    <predicate_block> ::=
        Muldis_Content_Predicate
            <predicate>*
        Muldis_Content_Predicate

    <predicate> ::=
        .*
            MCP
                <sp>
                    <name> <sp> [<term>+ % <sp>]
                <sp>
            MCP
        .*

    <sp> ::=
        [' ' | '\t' | '\n' | '\r']+

    <name> ::=
        version | script | syntax | model | comment

    <term> ::=
        <bare_term> | <quoted_term>

    <bare_term> ::=
        <-[ \x[0]..\x[1F] \x[20] " \x[80]..\x[9F] ]>+

    <quoted_term> ::=
        '"'
            <-[ \x[0]..\x[1F] " \x[80]..\x[9F] ]>*
        '"'
```

## version

When a `<name>` is `version` then the subsequent `<term>` items declare, in
order, the *authority* and *version number* of the fully-qualified name of
the **Muldis Content Predicate** (**MCP**) specification that the
`<predicate_block>` as a whole conforms to.
See section **VERSIONING** for more on fully-qualified names.
There may be multiple `version` typed `<predicate>`; when this is the case,
it means the `<predicate_block>` conforms to every one of those versions.

Examples:

```
    version http://muldis.com 0.300.0
```

## script

When a `<name>` is `script` then the subsequent `<term>` items collectively
indicate the primary *script* of the `<parsing_unit>` as a whole, meaning
its character repertoire and/or character encoding and/or character
normalization.  Under the assumption that a parser might be reading the
`<parsing_unit>` as binary data or otherwise as unnormalized character
data, declaring the *script* makes it completely unambiguous as to what
characters it is to be treating the input as.

For a simple example, a *script* of `ASCII` says every literal source code
character is a 7-bit ASCII character (and representing any non-ASCII
characters is being done with escape sequences), and this is recommended
for any file that doesn't need to be something else. For various legacy
8-bit formats the *script* can tell us if we're using `Latin1` or `CP1252`
or `EBCDIC` etc.  For Unicode the *script* would have multiple parts, such
as `Unicode 2.1 UTF-8 canon`, indicating expected repertoire, and encoding
(useful more with ones lacking BOMs); but at the very least it is useful
with normalization; if `compat` is declared then the source code is folded
before it is parsed so possibly distinct literal characters in the original
code are seen as identical character strings by the main parser, while
`canon` would not do this folding.

A parser would possibly scan through the same source code multiple times
filtering by a variety of text encodings until it can read a
`<predicate_block>` declaring the same encoding that the
`<predicate_block>` is itself written in, and then from that point it would
expect the whole file to be that declared encoding or it would consider the
source code invalid.

There may be multiple `script` typed `<predicate>`; when this is the case,
it means the `<parsing_unit>` conforms to every one of those scripts,
typically because only the common subsets of said were used.

Examples:

```
    script ASCII

    script Unicode 2.1 UTF-8

    script Unicode 2.1 UTF-8 canon
```

## syntax

When a `<name>` is `syntax` then the subsequent `<term>` items declare, in
order, the *syntax base name*, *authority* and *version number* of the
fully-qualified name of the language syntax specification, or faked
stand-in name, that the `<parsing_unit>` as a whole conforms to.
See section **VERSIONING** for more on fully-qualified names.

There may be multiple `syntax` typed `<predicate>`; when this is the case,
it means the `<parsing_unit>` conforms to every one of those syntaxes,
typically because only the lowest common denominators of said were used.

Examples:

```
    syntax Muldis_Object_Notation http://muldis.com 0.300.0

    syntax Muldis_Object_Notation http://example.com 42

    syntax SQL https://iso.org "ISO/IEC 9075:2016"

    syntax SQL https://postgresql.org 11.0

    syntax SQL https://oracle.com 12.2.0.1

    syntax SQL https://sqlite.org 3.26

    syntax Perl http://perlfoundation.org 5.28
```

## model

When a `<name>` is `model` then the subsequent `<term>` items declare, in
order, the *data model base name*, *authority* and *version number* of the
fully-qualified name of the data model or type system specification, or
faked stand-in name, that the `<parsing_unit>` as a whole represents values
of, and influences what specific data types a parser maps data to.
See section **VERSIONING** for more on fully-qualified names.

There may be multiple `model` typed `<predicate>`; when this is the case,
it means the `<parsing_unit>` conforms to every one of those data models,
typically because only the lowest common denominators of said were used.

Examples:

```
    model Muldis_Data_Language http://muldis.com 0.300.0

    model Muldis_Data_Language http://example.com 42

    model SQL https://postgresql.org 11.0

    model SQL https://sqlite.org 3.26

    model Perl http://perlfoundation.org 5.28
```

## comment

When a `<name>` is `comment` then the subsequent single `<term>` item
provides the text of a generic comment about either the `<predicate_block>`
as a whole or about any individual other `<predicate>` that it is next to.
While a *comment* could be used to talk about the `<parsing_unit>` as a
whole or any part of it, the expectation is that the form of commenting
source code native to its language would typically be used instead, at
least where the language has such a feature.
There may be multiple `comment` typed `<predicate>`.

Examples:

```
    comment "You know it, I hear that."
```

# VERSIONING

Every version of this specification document is expected to declare its own
fully-qualified name, or *identity*, so that it can easily be referred to
and be distinguished from every other version that does or might exist.

The expected fully-qualified name of every version of this specification
document, as either declared in said document or as referenced by other
documents or by source code, has 3 main parts: *document base name*,
*authority*, and *version number*.

The *document base name* is the character string `Muldis_Content_Predicate`.

An *authority* is some nonempty character string whose value uniquely
identifies the authority or author of the versioned entity.  Generally
speaking, the community at large should self-regulate authority identifier
strings so they are reasonable formats and so each prospective
authority/author has one of their own that everyone recognizes as theirs.
Note that an authority/author doesn't have to be an individual person; it
could be some corporate entity instead.

Examples of recommended *authority* naming schemes include a qualified
base HTTP url belonging to the authority (example `http://muldis.com`) or
a qualified user identifier at some well-known asset repository
(example `http://github.com/muldis` or `cpan:DUNCAND`).

For all official/original works by Muldis Data Systems, Inc., the
*authority* has always been `http://muldis.com` and is expected to remain
so during the foreseeable future.

If someone else wants to *embrace and extend* this specification document,
then they must use their own (not `http://muldis.com`) base authority
identifier, to prevent ambiguity, assist quality control, and give due credit.

In this context, *embrace and extend* means for someone to do any of the
following:

- Releasing a modified version of this current document or any
component thereof where the original of the modified version was released
by someone else (the original typically being the official release), as
opposed to just releasing a delta document that references the current one
as a foundation.  This applies both for unofficial modifications and for
official modifications following a change of who is the official maintainer.

- Releasing a delta document for a version of this current document or
any component thereof where the referenced original is released by someone
else, and where the delta either makes significant incompatible changes.

A *version number* is an ordered sequence of 1 or more integers.  A
*version number* is used to distinguish between all of the versions of a
named entity that have a common *authority*, per each kind of versioned
entity; version numbers typically indicate the release order of these
related versions and how easily users can substitute one version for
another.  The actual intended meaning of any given *version number*
regarding for example substitutability is officially dependant on each
*authority* and no implicit assumptions should be made that 2 *version
number* with different *authority* are comparable in any meaningful way,
aside from case-by-case where a particular *authority* declares they use a
scheme compatible with another.  The only thing this document requires is that
every distinct version of an entity has a distinct fully-qualified name.

For each official/original work by Muldis Data Systems related to this
specification document and released after 2016 April 1, except where
otherwise stated, it uses *semantic versioning* for each *version number*,
as described below.  Others are encouraged to follow the same format, but
are not required to.  For all intents and purposes, every *version number*
of an official Muldis work is intended to conform to the external public
standard **Semantic Versioning 2.0.0** as published at
[https://semver.org](https://semver.org), but it is re-explained below for
clarity or in case the external document disappears.

A *version number* for authority `http://muldis.com` is an ordered sequence
of integers, the order of these being from most significant to least, with
3 positions [MAJOR,MINOR,PATCH] and further ones possible.  The version
sequence may have have as few as 1 most significant position.  Any omitted
trailing position is treated as if it were zero.  Each of
{MAJOR,MINOR,PATCH} must be a non-negative integer. MAJOR is always (except
when it is zero) incremented when a change is made which breaks
backwards-compatibility for functioning uses, such as when removing a
feature; it may optionally be incremented at other times, such as for
marketing purposes.  Otherwise, MINOR is always incremented when a change
is made that breaks forwards-compatibility for functioning uses, such as
when adding a feature; it may optionally be incremented at other times,
such as for when a large internals change is made.  Otherwise, PATCH must
be incremented when making any kind or size of change at all, as long as it
doesn't break compatibility; typically this is bug-fixes or performance
improvements or some documentation changes or any test suite changes.  For
fixes to bugs or security holes which users may have come to rely on in
conceptually functioning uses, they should be treated like API changes.
When MAJOR is zero, MINOR is incremented for any kind of breaking change.
There is no requirement that successive versions have adjacent integers,
but they must be increases.

Strictly speaking a *version number* reflects intention of the authority's
release and not necessarily its actuality.  If PATCH is incremented but the
release unknowingly had a breaking change, then once this is discovered
another release should be made which increments PATCH again and undoes that
breaking change, in order to safeguard upgrading users from surprises; an
additional release can be made which instead increments MAJOR or MINOR with
the breaking change if that change was actually desired.

*Currently this document does not specify matters such as how to indicate
maturity, for example production vs pre-production/beta/etc, so explicit
markers of such can either be omitted or be based on other standards.
However, a major version of zero should be considered either pre-production
or that the authority expects frequent upcoming backwards-incompatible changes.*

See also [http://design.perl6.org/S11.html#Versioning](
http://design.perl6.org/S11.html#Versioning) which was the primary
influence for the versioning scheme described above.

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Content Predicate** (**MCP**).

MCP is Copyright © 2002-2019, Muldis Data Systems, Inc.

[http://www.muldis.com/](http://www.muldis.com/)

MCP is free documentation for software;
you can redistribute it and/or modify it under the terms of the Artistic
License version 2 (AL2) as published by the Perl Foundation
([http://www.perlfoundation.org/](http://www.perlfoundation.org/)).
You should have received copies of the AL2 as part of the
MCP distribution, in the file
[LICENSE/artistic-2_0.txt](../LICENSE/artistic-2_0.txt); if not, see
[http://www.perlfoundation.org/attachment/legal/artistic-2_0.txt](
http://www.perlfoundation.org/attachment/legal/artistic-2_0.txt).

Any versions of MCP that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.

While it is by no means required, the copyright holder of MCP would
appreciate being informed any time you create a modified version of Muldis
D that you are willing to distribute, because that is a practical way of
suggesting improvements to the standard version.

# TRADEMARK POLICY

**MULDIS** and **MULDIS MULTIVERSE OF DISCOURSE** are trademarks of Muldis
Data Systems, Inc. ([http://www.muldis.com/](http://www.muldis.com/)).
The trademarks apply to computer database software and related services.
See [http://www.muldis.com/trademark_policy.html](
http://www.muldis.com/trademark_policy.html) for the full written details
of Muldis Data Systems' trademark policy.

# ACKNOWLEDGEMENTS

*None yet.*

# FORUMS

*TODO.*
