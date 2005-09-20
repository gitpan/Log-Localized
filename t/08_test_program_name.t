#!/usr/local/bin/perl
#################################################################
#
#   $Id: 08_test_program_name.t,v 1.1 2005/09/19 18:47:07 erwan Exp $
#
#   050919 erwan Created
#   

use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 3;
use Test::NoWarnings;
use lib ("./t/", "../lib/", "./lib/");

BEGIN {
    use_ok('Log::Localized');
}

is(Log::Localized::_test_program,"08_test_program_name.t","test program name properly identified");
