# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Foo.t'

use lib qw(t/lib);
use Test::More tests => 5;

BEGIN { use_ok('CLASS'); }


package Foo;
sub bar { 23 }
sub check_caller { caller }

::is( CLASS->bar, 23,             'CLASS->meth' );

#line 42
eval { CLASS->i_dont_exist };
my $CLASS_death = $@;
#line 42
eval { __PACKAGE__->i_dont_exist };
my $Foo_death = $@;
::is( $CLASS_death, $Foo_death,   '__PACKAGE__ and CLASS die the same' );

my $CLASS_caller = CLASS->check_caller;
my $Foo_caller   = __PACKAGE__->check_caller;
::is($CLASS_caller, $Foo_caller,  'caller preserved' );


# Make sure AUTOLOAD is preserved.
package Bar;
sub AUTOLOAD { return "Autoloader" }

::is( CLASS->i_dont_exist, 'Autoloader',        'AUTOLOAD preserved' );
