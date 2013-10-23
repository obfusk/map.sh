[]: {{{1

    File        : README.md
    Maintainer  : Felix C. Stegerman <flx@obfusk.net>
    Date        : 2013-10-23

    Copyright   : Copyright (C) 2013  Felix C. Stegerman
    Version     : v0.0.1-SNAPSHOT

[]: }}}1

## Description
[]: {{{1

  map.sh - map/filter for bash

  `map` evaluates an expression for arguments, files, or lines;
  `filter` filters arguments, files, or lines based on the return
  value of an expression; the expression can refer to its argument as
  `$it`.

  Options:

  * `-v` prints the expression before evaluating it; only for `map`
  * `-l` maps/filters lines instead of arguments
  * `-0` input lines end with 0 byte, not newline; implies `-l`
  * `-z` output lines end with 0 byte, not newline; only for `filter`
  * `-f` treats arguments/lines as files, providing the canonical path
    as `$path`, the absolute path as `$abs`, the basename as `$base`,
    the dirname as `$dir`, and the dirnames of the canonical and
    absolute paths as `$path_dir` and `$abs_dir`

  The canonical path is the result of `readlink -f`: the absolute path
  with all symlinks followed.

[]: }}}1

## Examples
[]: {{{1

[]: {{{2

```bash
map 'echo $it' foo bar baz
# foo
# bar
# baz

map -v 'echo "$it"; echo ${#it}' foo 'bar baz'
# ==> echo foo
# foo
# ==> echo 3
# 3
# ==> echo 'bar baz'
# bar baz
# ==> echo 7
# 7

map -f 'echo "$path"' foo bar/baz
# /canonical/path/to/foo
# /canonical/path/to/baz

find -type f -print0 | sort -z | map -f0 'echo "$path_dir"'
```

[]: }}}2

[]: {{{2

```bash
filter '[ -e "$it" ]' existing-file nonexisting-file
# existing-file

filter '[[ "$it" =~ foo ]]' foo bar food
# foo
# food

filter '[ -L "$it" ]' some/file some/link | map -fl 'echo "$abs"'
# /absolute/path/to/some/link

find -type f -print0 | sort -z | filter -f0 '[ "${#base}" == 4 ]'
```

[]: }}}2

[]: }}}1

## License
[]: {{{1

  GPLv2 [1].

[]: }}}1

## References
[]: {{{1

  [1] GNU General Public License, version 2
  --- http://www.opensource.org/licenses/GPL-2.0

[]: }}}1

[]: ! ( vim: set tw=70 sw=2 sts=2 et fdm=marker : )
