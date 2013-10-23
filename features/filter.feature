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

    When  I run `filter -f '[ -L "$it" ]' some/file some/link | map -l 'echo "$abs"'`
    Then  it should succeed
    And   the last stdout should match:
      """
      \A/absolute/path/to/some/link
      \Z
      """

  Scenario: finds 4-char files from -print0 w/ -0

    When  I run `find -type f -print0 | sort -z | filter -0 '[ "${#it}" == 4 ]'`
    Then  it should succeed
    And   the last stdout should be:
      """
      four

      """

# vim: set tw=70 sw=2 sts=2 et fdm=marker :
