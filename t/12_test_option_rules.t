#!/usr/local/bin/perl
#################################################################
#
#   $Id: 12_test_option_rules.t,v 1.3 2005/09/20 06:43:50 erwan Exp $
#
#   050919 erwan Created
#   

use strict;
use warnings;
use Test::More tests => 3;
use Test::NoWarnings;
use File::Temp qw/ tmpnam /;
use lib ("./t/", "../lib/", "./lib/");

use Utils;

my $dirname;

BEGIN { 
    Utils::backup_log_settings();

      my $conf = "".
	  "main:: = 2\n".
	  "main::test2 = 4\n".
	  "Foo::test1  = 3\n".
	  "What::Ever = 4\n".
	  "Foo::Bar::*  = 1\n";

      # write config in /tmp
      unlink "new_rules.conf";
      open(OUT,"> new_rules.conf") 
	  or die "ERROR: failed to open [new_rules.conf] for writting:$!\n";
      print OUT $conf;
      close(OUT) 
	  or die "ERROR: failed to close [new_rules.conf]:$!\n";
    
      # redirecting Log::Localized to config file located in local dir
      use_ok('Log::Localized',
	     'rules',
	     "Log::Localized::use_rules = new_rules.conf",
	     );
} 

my $want_rules = { 
    "main::" => 2,
    "main::test2" => 4,
    "Foo::test1" => 3,
    "Foo::Bar::*" => 1,
    "What::Ever" => 4,
};
my %rules = Log::Localized::_test_verbosity_rules();
is_deeply(\%rules,$want_rules,"checking that rules were properly loaded");	  

unlink 'new_rules.conf';
Utils::restore_log_settings();
