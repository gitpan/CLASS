package CLASS;

use 5.004;

use strict;
use vars qw($VERSION @EXPORT @ISA);
$VERSION = '0.03';

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(CLASS);

sub CLASS { return scalar caller }
    

=head1 NAME

CLASS - Alias for __PACKAGE__

=head1 SYNOPSIS

  package Foo;
  use CLASS;

  print CLASS;          # Foo

  sub bar { 23 }

  print CLASS->bar;     # 23

=head1 DESCRIPTION

CLASS is a synonym for __PACKAGE__.  Its easier to type.


=head1 TODO

I tried to provide a $CLASS for easier use in strings, but it doesn't
quite evaluate right when used as a function argument.

=head1 AUTHOR

Michael G Schwern <schwern@pobox.com>


=head1 SEE ALSO

L<perlmod(1)>

=cut


1;
