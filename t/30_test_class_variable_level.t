#!/usr/bin/perl
#################################################################
#
#   $Id: 30_test_class_variable_level.t,v 1.1 2005/09/18 16:35:06 erwan Exp $
#
#   050912 erwan Created
#

use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 5;
use Test::NoWarnings;
use lib ("./t/", "../lib/", "./lib/");
use Utils;

BEGIN {
    Utils::backup_log_settings();
    Utils::set_global_verbosity(2);
    use_ok('Log::Localized');
}    

sub test {
    my $wanted = shift;
    my $level = $Log::Localized::LEVEL;
    is($level,$wanted,"check level");
    return "ok";
}

llog(0,sub { test(0);});
llog(1,sub { test(1);});
llog(2,sub { test(2);});

Utils::restore_log_settings();

