#!/usr/bin/perl
use warnings FATAL => 'all';
use strict;

use Test::Builder::Tester tests => 21;
use Test::Functional;
use Test::More;

sub mytest_fail {
    my ($offset, $msg) = @_;
    my ($pkg, $file, $line) = caller();
    $line += $offset || 0;
    $msg ||= '';
    my $err = <<ERR;
#   Failed test 'test'
#   at $file line $line.
$msg
ERR
    $err =~ s#\n+$##;
    @_ = ($err);
    goto &test_err;
}

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 26.");
test { die } "test";
test_test("die");

test_out("not ok 1 - test");
mytest_fail(1, "#          got: '33'\n" . "#     expected: '34'");
test { 33 } 34, "test";
test_test("eqv");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 36.");
test { die } 34, "test";
test_test("eqv-die");

test_out("not ok 1 - test");
mytest_fail(1, "#     objects were the same");
test { 33 } ineqv(33), "test";
test_test("ineqv");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 46.");
test { die } ineqv(33), "test";
test_test("ineqv-die");

test_out("not ok 1 - test");
mytest_fail(1, "#     result was not of type ARRAY");
test { sub{} } typeqv('ARRAY'), "test";
test_test("typeqv");

test_out("not ok 1 - test");
mytest_fail(1, "#     result was undef");
test { undef } typeqv('ARRAY'), "test";
test_test("typeqv-undef");

test_out("not ok 1 - test");
mytest_fail(1, "#     result was not a ref");
test { 33 } typeqv('ARRAY'), "test";
test_test("typeqv-noref");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 66.");
test { die } typeqv('ARRAY'), "test";
test_test("typeqv-die");

test_out("not ok 1 - test");
mytest_fail(1, "#     failed to die");
test { 33 } dies, "test";
test_test("dies");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 76.");
test { die } noop, "test";
test_test("noop-die");

test_out("not ok 1 - test");
mytest_fail(1);
test { 0 } true, "test";
test_test("true");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 86.");
test { die } true, "test";
test_test("true-die");

test_out("not ok 1 - test");
mytest_fail(1);
test { 1 } false, "test";
test_test("false");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 96.");
test { die } false, "test";
test_test("false-die");

test_out("not ok 1 - test");
mytest_fail(1);
test { undef } isdef, "test";
test_test("isdef");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 106.");
test { die } isdef, "test";
test_test("isdef-die");

test_out("not ok 1 - test");
mytest_fail(1);
test { 1 } isundef, "test";
test_test("isundef");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 116.");
test { die } isundef, "test";
test_test("isundef-die");

test_out("not ok 1 - test");
mytest_fail(1, "#                   'bar'\n#     doesn't match '(?-xism:foo)'");
test { 'bar' } sub { like($_[0], qr/foo/, $_[1]) }, "test";
test_test("custom");

test_out("not ok 1 - test");
mytest_fail(1, "#     died: Died at t/output.t line 126.");
test { die } sub { like($_[0], qr/foo/, $_[1]) }, "test";
test_test("custom-die");
