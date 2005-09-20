#!/usr/local/bin/perl
#################################################################
#
#   $Id: 41_test_warnings.t,v 1.2 2005/09/20 19:45:53 erwan Exp $
#
#   050919 erwan Created
#   

use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 4;
use Test::Warn;
use Test::NoWarnings;
use lib ("./t/", "../lib/", "./lib/");
use Utils;

BEGIN { 
    Utils::backup_log_settings();

      # test value check for import parameter 'log'
      $ENV{LOG_LOCALIZED_VERBOSITY} = 1;
      use_ok('Log::Localized');

      # check invalid global verbosity
      $ENV{LOG_LOCALIZED_VERBOSITY} = 'abc';
      warning_like { llog(0,"test"); } [ qr/environment variable .* must be an integer/i,
					 qr/environment variable .* must be an integer/i,
					 qr/environment variable .* must be an integer/i ], 
                   "test warning when LOG_LOCALIZED_VERBOSITY not integer";

#      my $conf = "Log::Localized::rename = lllog \nmain:: = abc";
#      warning_like { Log::Localized::import('bla','rules',$conf); } qr/invalid verbosity rules for .* should be an integer/i, "warning when verbosity in rule is not an integer";

      $ENV{LOG_LOCALIZED_VERBOSITY} = 0;

      my $conf = "Log::Localized::rename = llllog \nLog::Localized::dispatchers = thisfiledoesnotexists48937849324\nmain:: = abc";
      warning_like { Log::Localized::import('bla','rules',$conf); } [ qr/invalid verbosity rules for .* should be an integer/i,
								      qr/no dispatcher definition file/i ], 
                   "warnings when dispatcher file not found and invalid rule syntax";
  }

Utils::restore_log_settings();
