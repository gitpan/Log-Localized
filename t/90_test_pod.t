#!/usr/local/bin/perl
#################################################################
#
#   $Id: 90_test_pod.t,v 1.4 2005/09/20 06:43:50 erwan Exp $
#
#   050912 erwan Created
#   

use strict;
use warnings;
use Test::More;
eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;

my @files = all_pod_files("../lib/","lib/");
plan tests => scalar(@files);
foreach my $file (@files) {
    pod_file_ok($file);
}
