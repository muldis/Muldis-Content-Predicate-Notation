# Muldis Content Predicate (MCP) Feature Comparison

This document features a comparison between Muldis Content Predicate (MCP)
and other metadata formats or methods.

Note that Muldis Content Predicate metadata is designed such that it should
be able to coexist in the same files as many of these as applicable.

*Each section below is an unordered set of notes until otherwise finished.*

## UNIX Shebang Interpreter Directive

The shebang line `#!foo`
at the start of script files saying what interpreter to use and args for it.
The `#!` is a magic number and the metadata goes until the first linebreak.

See [https://en.wikipedia.org/wiki/Shebang_(Unix)](
https://en.wikipedia.org/wiki/Shebang_(Unix)) about that.

## Magic Numbers In Files

Magic Numbers are common as the first bytes in many file types,
particularly binary file types, as a form of strong typing done as in-band
signalling that indicate what the file contains.

Examples include:

- `#!` for UNIX scripts; see section **UNIX Shebang Interpreter Directive**
- `%PDF` for PDF files
- `CAFEBABE` for compiled Java class files
- `II` or `MM` followed by `42` as a 2-byte integer for TIFF image files
- `\211 P N G \r \n \032 \n` for a PNG image file
- `GIF89a` for `GIF87a` for a GIF image file

See [https://en.wikipedia.org/wiki/Magic_number_(programming)](
https://en.wikipedia.org/wiki/Magic_number_(programming)) about that.

## GNU Emacs File Variables

A text file of any kind, for example Markdown or Lisp source or C source,
can have either a first line like this:

```
    <!-- -*- coding: utf-8; mode: markdown; version: 1; -*- -->
```

Or like this:

```
    ;; -*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
```

Or it could have multiple lines like this anywhere in the file:

```
    /* Local Variables:  */
    /* mode: c           */
    /* comment-column: 0 */
    /* End:              */
```

GNU Emacs in particular but also BBEdit or other text editors understanding
the format would understand these as metadata saying things like the file
is source code for some particular language, or its text encoding,
or other editor configuration.

See [https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Variables.html](
https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Variables.html) about that.

## Extensible Markup Language (XML)

Declaration like `<?xml version="1.0" encoding="UTF-8"?>`
starting an XML file to declare it is XML and what version of XML it
conforms to and what the containing file's text encoding is.
That corresponds to the MCP `syntax` and `script` declarations.

Declaration like `<!DOCTYPE ...>`
near file start of what DTD or other schemas the XML conforms to.
That corresponds to the MCP `model` declaration.

## Hypertext Markup Language (HTML)

Declaration like `<meta ... />`
starting an HTML file can say a variety of things.

Declaration like `<meta charset="utf-8" />`
or `<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />`.

## HTTP Headers and Similar Internet Protocols

The Content-Type header including main data/encoding types etc are used
in the HTTP body.

## Version Control Systems

Metadata in comments at the top of some files under version control with
a stamp of commit number and timestamp etc, used by CVS or whatever.
