#!/usr/local/bin/perl
#################################################################
#
#   $Id: 13_test_option_path.t,v 1.3 2005/09/20 19:45:52 erwan Exp $
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

      # get a temporary filename
      $dirname = tmpnam();

      my $conf = "".
	  "main:: = 2\n".
	  "Bo::Kasper:: = 99\n".
	  "main::test2 = 4\n".
	  "Foo::test1  = 3\n".
	  "Foo::Bar::*  = 1\n";

      # write config in /tmp
      `mkdir $dirname`;
      unlink "$dirname/new_rules.conf";
      open(OUT,"> $dirname/new_rules.conf") 
	  or die "ERROR: failed to open [$dirname/new_rules.conf] for writting:$!\n";
      print OUT $conf;
      close(OUT) 
	  or die "ERROR: failed to close [$dirname/new_rules.conf]:$!\n";
    
      # redirecting Log::Localized to config file located in $dirname
      use_ok('Log::Localized',
	     'rules',
	     "Log::Localized::search_path = /bob:/marley:$dirname\n".
	     "Log::Localized::use_rules = new_rules.conf",
	     );
} 

my $want_rules = { 
    "main::" => 2,
    "Bo::Kasper::" => 99,
    "main::test2" => 4,
    "Foo::test1" => 3,
    "Foo::Bar::*" => 1,
};
my %rules = Log::Localized::_test_verbosity_rules();
is_deeply(\%rules,$want_rules,"checking that rules were properly loaded");	  

# cleanup
`rm -rf $dirname`;
Utils::restore_log_settings();
