#!/usr/bin/perl -Tw

use 5.004;

use lib qw(t/lib);
use Test::More tests => 7;

BEGIN { use_ok('CLASS'); }


package Foo;
use CLASS;

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

#line 24
my $CLASS_caller = CLASS->check_caller;
my $Foo_caller   = __PACKAGE__->check_caller;
::is($CLASS_caller, $Foo_caller,  'caller preserved' );


::is( CLASS,  __PACKAGE__,              'CLASS is right' );

{
    package Bar;
    use CLASS;

    sub Yarrow::Func {
        ::is( CLASS, __PACKAGE__,    'CLASS works in tricky subroutine' );
    }
}

Yarrow::Func();


# Make sure AUTOLOAD is preserved.
package Bar;
sub AUTOLOAD { return "Autoloader" }

::is( CLASS->i_dont_exist, 'Autoloader',        'AUTOLOAD preserved' );
