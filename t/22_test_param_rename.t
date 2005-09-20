#!/usr/local/bin/perl
#################################################################
#
#   $Id: 22_test_param_rename.t,v 1.1 2005/09/20 18:40:04 erwan Exp $
#
#   test renaming llog in calling package
#
#   050919 erwan Created
#   

use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 5;
use Test::NoWarnings;
use lib ("./t/", "../lib/", "./lib/");
use Utils;

BEGIN { 
    # using Log::Localized with global verbosity off but a config file
    Utils::backup_log_settings();
    Utils::set_global_verbosity(0);
    use_ok('Log::Localized','log',1,'rename','my_log');
};

my $want_rules = {};
my %rules = Log::Localized::_test_verbosity_rules();
is_deeply(\%rules,$want_rules,"checking that rules were properly loaded");	  

my_log(0,\&Utils::mark_log_called);
is(Utils::check_log_called,1,"check my_log is llog");

eval { llog(0,\&Utils::mark_log_called); };
ok($@ =~ /undefined subroutine/i,"error when calling llog");

Utils::restore_log_settings();
