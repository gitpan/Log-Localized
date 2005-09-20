#!/usr/local/bin/perl
#################################################################
#
#   $Id: 07_test_get_search_path.t,v 1.1 2005/09/18 16:03:43 erwan Exp $
#
#   test _get_search_path
#
#   050918 erwan Created
#   

use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 8;
use Test::NoWarnings;
use File::HomeDir;
use lib ("./t/", "../lib/", "./lib/");
use Utils;

BEGIN {
    $ENV{TEST1} = "test1";
    $ENV{TEST2} = "test2";
    
    use_ok('Log::Localized');
}

my $home = home();

my %TESTS = (
	     "/bob/morane:/lucky/luke/:anakin" => ["/bob/morane","/lucky/luke/","anakin"],
	     "~" => [$home],
	     "~/bob:" => ["$home/bob"],
	     "naph:~/bob:~/morane" => ["naph","$home/bob","$home/morane"],
	     "\$TEST1/\$TEST2:~/\$TEST2:~/bob/\$TEST2/\$TEST2/\$TEST1" => ["test1/test2","$home/test2","$home/bob/test2/test2/test1"],
	     "\$TEST2/\$TEST3/\$TEST2:\$TEST3" => ["test2/\$TEST3/test2","\$TEST3"],
	     );

while (my($path,$want) = each %TESTS) {
    my @search = Log::Localized::_get_search_path($path);
    is_deeply(\@search,$want,"check _get_search_path on [$path]");
}
