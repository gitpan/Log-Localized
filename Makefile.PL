use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Log::Localized',
    VERSION_FROM      => 'lib/Log/Localized.pm', # finds $VERSION
    PREREQ_PM         => {
	Config::Tiny => 2.02,
	  Log::Dispatch => 2.11,
	  Log::Dispatch::Config => 1.01,
	  Log::Dispatch::Screen => 1.17,
	  File::Spec => 3.11,
	  File::HomeDir => 0.06,
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Log/Localized.pm', # retrieve abstract from module
       AUTHOR         => 'Erwan Lemonnier <erwan@cpan.org>') : ()),
);
