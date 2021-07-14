#!/usr/bin/env bats

# shellcheck source=/dev/null
source "${BATS_TEST_DIRNAME:?}/../modules/bash-commons/src/array.sh"
source "${BATS_TEST_DIRNAME:?}/test-helper.sh"

@test "array_contains : given empty array, should return 1" {
  run array_contains "foo"
  assert_failure
}

@test "array_contains : given array of length 1 with no matching item, it should return 1" {
  run array_contains "foo" "bar"
  assert_failure
}

@test "array_contains : given array of length 1 with matching item, it should return 0" {
  run array_contains "foo" "foo"
  assert_success
}

@test "array_contains : given array of length 3 with no matching item, it should return 1" {
  run array_contains "foo" "bar" "baz" "blah"
  assert_failure
}

@test "array_contains : given array of length 3 with matching item, it should return 0" {
  run array_contains "foo" "bar" "foo" "blah"
  assert_success
}

@test "array_contains : given array of length 3 with multiple matches, it should return 0" {
  run array_contains "foo" "bar" "foo" "foo"
  assert_success
}

@test "array_contains : given array of length 3 with spaces in array values, it should return 1" {
  run array_contains "foo" "foo bar" "baz blah"
  assert_failure
}

# @test "array_join : empty array" {
#   run array_join ","
#   assert_success
#   assert_output ""
# }
#
# @test "array_join : array of length 1" {
#   run array_join "," "foo"
#   assert_success
#   assert_output "foo"
# }
#
# @test "array_join : array of length 3" {
#   run array_join "," "foo" "bar" "baz"
#   assert_success
#   assert_output "foo,bar,baz"
# }
#
# @test "array_join : array of length 3 with multi character separator" {
#   run array_join " == " "foo" "bar" "baz"
#   assert_success
#   assert_output "foo == bar == baz"
# }
