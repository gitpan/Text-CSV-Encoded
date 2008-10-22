package Text::CSV::Encoded::Coder::Encode;

use 5.008;
use strict;
use warnings;

use base qw( Text::CSV::Encoded::Coder::Base );

use Carp ();
use Encode ();

our $VERSION = '0.01';

my %EncoderCache;


sub upgrade {
    utf8::upgrade( $_[1] ) if ( $_[1] );
}


sub encode {
    my ( $self, $encoding, $str ) = @_;
    $self->find_encoding( $encoding )->encode( $str );
}


sub decode {
    my ( $self, $encoding, $str ) = @_;
    $self->find_encoding( $encoding )->decode( $str );
}


sub decode_fields_ref {
    my ( $self, $encoding, $arrayref ) = @_;
    my $enc = $self->find_encoding( $encoding ) || return;
    for ( @$arrayref ) {
        $_ = $enc->decode( $_ );
    }
}


sub encode_fields_ref {
    my ( $self, $encoding, $arrayref ) = @_;
    my $enc = $self->find_encoding( $encoding ) || return;
    for ( @$arrayref ) {
        $_ = $enc->encode( $_ );
    }
}


sub find_encoding {
    shift;
    $EncoderCache { ($_[0] || 'utf8') }
       ||= Encode::find_encoding( $_[0] || 'utf8' ) || Carp::croak ( "Not found such an encoding name '$_[0]'" );
}



1;
__END__

=pod

=head1 NAME

Text::CSV::Encoded::Coder::Encode - Text::CSV::Encoded coder class using Encode

=head1 SYNOPSIS

  use Text::CSV::Encoded coder_class => 'Text::CSV::Encoded::Coder::Encode';
  # In Perl 5.8 or later, it is a default module.

=head1 DESCRIPTION

This module is used by L<Text::CSV::Encoded> internally.

=head1 SEE ALSO

L<Encode>, L<Encode::Supported>, L<Encode::Alias>, L<utf8>

=head1 AUTHOR

Makamaka Hannyaharamitu, E<lt>makamaka[at]cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by Makamaka Hannyaharamitu

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
