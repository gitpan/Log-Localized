#!/usr/local/bin/perl
#################################################################
#
#   $Id: 91_test_pod_coverage.t,v 1.2 2005/09/20 06:50:04 erwan Exp $
#
#   050912 erwan Created
#   

use Test::More;
#eval "use Test::Pod 1.14";
#plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;

eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage" if $@;
all_pod_coverage_ok();

#my @files = all_pod_files("../lib/","lib/");
#plan tests => scalar(@files);
#foreach my $file (@files) {
#    pod_coverage_ok($file);
#}



