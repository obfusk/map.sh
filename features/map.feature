Feature: map

  Scenario: echoes $it

    When  I run `map 'echo $it' foo bar baz`
    Then  it should succeed
    And   the last stdout should be:
      """
      foo
      bar
      baz

      """

  Scenario: is verbose w/ -v

    When  I run `map -v 'echo \"\$it\"; echo \${#it}' foo 'bar baz' 2>&1` with bash
    Then  it should succeed
    And   the last stdout should be:
      """
      ==> echo foo
      foo
      ==> echo 3
      3
      ==> echo 'bar baz'
      bar baz
      ==> echo 7
      7

      """

  Scenario: maps canonical files w/ -f and $path

    When  I run `map -f 'echo "$path"' foo bar/baz`
    Then  it should succeed
    And   the last stdout should match:
      """
      \A\S+/test/foo
      \S+/test/bar/baz
      \Z
      """

  Scenario: maps canonical dirnames from -print0 w/ -f0 and $path_dir

    When  I run `find -type f -print0 | sort -z | map -f0 'echo \"\$path_dir\"'` with bash
    Then  it should succeed
    And   the last stdout should match:
      """
      \A\S+/test/bar
      \S+/test
      \S+/test
      \S+/test
      \S+/test/some
      \Z
      """

  Scenario: correctly sets $path, $abs, $base, $dir, $path_dir, and $abs_dir

    When  I run `map -f 'echo $path,$abs,$base,$dir,$path_base,$path_dir,$abs_dir' some/link`
    Then  it should succeed
    And   the last stdout should match:
      """
      \A\S+/test/some/file,\S+/test/some/link,link,some,file,\S+/test/some,\S+/test/some
      \Z
      """

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
