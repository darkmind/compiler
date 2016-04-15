#!/usr/bin/perl

use strict;
use warnings;

use JSON;
use Data::Dumper;

my $debug = 0;

while( <> ){
    my $line = $_;

    my $json_decoder = JSON->new();
    my $result       = $json_decoder->decode( $line );
    print Dumper( $result );
}
