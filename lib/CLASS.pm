package CLASS;

require 5.004;

use strict;
use vars qw($VERSION $AUTOLOAD $die_string @EXPORT @ISA);
$VERSION = '0.02';

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(CLASS);

sub CLASS { return scalar caller }
    

# This is tricky.  The die message changes between versions of Perl.
# Here I'm trying to figure out what it is and translate it to a sprintf
# string.
eval { This::Class::Doesnt::Exist->i_dont_exist };
$die_string = $@;
$die_string =~ s/i_dont_exist/%s/g;
my $caller_nums = $die_string =~ s/This::Class::Doesnt::Exist/%s/g;
$die_string =~ s/\d+/%d/g;
$die_string =~ s/\Q$INC{'CLASS.pm'}\E/%s/g;

sub AUTOLOAD {
    my $class = shift;
    my($caller, $file, $line) = caller;
    my($meth) = $AUTOLOAD =~ /::([^:]+)$/;

    return if $meth eq 'DESTROY';

    # Gotta make sure we get the die message right if there's no
    # method to call.
    my $meth_ref = $caller->can($meth) || $caller->can('AUTOLOAD');
    unless( $meth_ref ) {
        die sprintf $die_string, $meth, ($caller) x $caller_nums, $file, $line;
    }

    goto $meth_ref;
}


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
