#!/usr/bin/perl

use strict;
use warnings;

use JSON;
use Data::Dumper;

my $debug = 0;

my @stack;
while( <> ){
    my $line = $_;

    my $json_decoder = JSON->new();
    my $result       = $json_decoder->decode( $line );

    my $token_pos   = 0;
    foreach my $token ( @{ $result } ){
        my $curr_token  = $result->[$token_pos];
        my $next_token  = $result->[$token_pos + 1];

        push( @stack, $curr_token );
        check_rules( \@stack, $next_token );

        $token_pos++;
    }
}

sub check_rules {
    my ( $stack, $next_token ) = @_;

    print Dumper( $stack );
    print "Next token: " . Dumper( $next_token );

    return ;
}
