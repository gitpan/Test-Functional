use Test::Functional;

group {
    test { 14 } 14, "test1";
    pretest { 14 } 13, "test2";
    test { 13 } 13, "test3";
} "grp";
