Feature: filter

  Scenario: filters existing files w/ -e $it

    When  I run `filter '[ -e "$it" ]' existing-file nonexisting-file`
    Then  it should succeed
    And   the last stdout should be:
      """
      existing-file

      """

  Scenario: filters arguments matching foo w/ =~

    When  I run `filter '[[ "$it" =~ foo ]]' foo bar food`
    Then  it should succeed
    And   the last stdout should be:
      """
      foo
      food

      """

  Scenario: filters links then maps absolute paths

    When  I run `filter '[ -L \"\$it\" ]' some/file some/link | map -fl 'echo \"\$abs\"'` with bash
    Then  it should succeed
    And   the last stdout should match:
      """
      \A\S+/test/some/link
      \Z
      """

  Scenario: finds 4-char files from -print0 w/ -0

    When  I run `find -type f -print0 | sort -z | filter -f0 '[ \"\${#base}\" == 4 ]'` with bash
    Then  it should succeed
    And   the last stdout should be:
      """
      ./four
      ./some/file

      """

  Scenario: output lines end with 0 byte w/ -z

    When  I run `filter -z true foo bar baz`
    Then  it should succeed
    And   the last stdout should match:
      """
      \Afoo\0bar\0baz\0\Z
      """

  Scenario: correctly sets $path, $abs, $base, $dir, $path_dir, and $abs_dir

    When  I run `filter -f 'echo $path,$abs,$base,$dir,$path_base,$path_dir,$abs_dir' some/link`
    Then  it should succeed
    And   the last stdout should match:
      """
      \A\S+/test/some/file,\S+/test/some/link,link,some,file,\S+/test/some,\S+/test/some
      some/link
      \Z
      """

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
