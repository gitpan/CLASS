package CLASS;

use 5.004;

$VERSION = '0.91';

BEGIN { 
    # Faster than 'use constant'.  Load time critical.
    # Must eval to make $] constant.
    *PERL_VERSION = eval qq{ sub () { $] } };
}

sub import {
    my($self) = shift;
    my $caller = caller;
    *{$caller.'::CLASS'} = \$caller;

    # This logic is compiled out.
    if( PERL_VERSION >= 5.008 ) {
        # 5.8.x smart enough to make this a constant.
        *{$caller.'::CLASS'} = sub () { $caller };
    }
    else {
        # Make CLASS a constant.
        *{$caller.'::CLASS'} = eval qq{ sub () { q{$caller} } };
    }
}

=head1 NAME

CLASS - Alias for __PACKAGE__

=head1 SYNOPSIS

  package Foo;
  use CLASS;

  print CLASS;                  # Foo
  print "My class is $CLASS\n"; # My class is Foo

  sub bar { 23 }

  print CLASS->bar;     # 23
  print $CLASS->bar;    # 23


=head1 DESCRIPTION

CLASS and $CLASS are both synonyms for __PACKAGE__.  Easier to type.

$CLASS has the additional benefit of working in strings.

=head1 NOTES

CLASS is a constant, not a subroutine call.  $CLASS is a plain
variable, it is not tied.  There is no performance loss for using
CLASS over __PACKAGE__ except the loading of the module. (Thanks
Juerd)

=head1 AUTHOR

Michael G Schwern <schwern@pobox.com>


=head1 SEE ALSO

L<perlmod(1)>

=cut


1;
