package CLASS;

use 5.004;

$VERSION = '0.90';

sub CLASS { return scalar caller }

sub import {
    my($self) = shift;
    my $caller = caller;
    *{$caller.'::CLASS'} = \$caller;
    *{$caller.'::CLASS'} = \&CLASS;
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


=head1 AUTHOR

Michael G Schwern <schwern@pobox.com>


=head1 SEE ALSO

L<perlmod(1)>

=cut


1;
