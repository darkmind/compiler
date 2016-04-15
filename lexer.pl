#!/usr/bin/perl

use strict;
use warnings;

my $debug = 0;

my $token_exprs = [
    { qr/^(\d+)/m => 'DIGIT' },
    { qr/^(\+)/m  => 'PLUS' },
    { qr/^(\-)/m  => 'MINUS' },
    { qr/^(\*)/m  => 'MULT' },
    { qr/^(\/)/m  => 'SEPARATE' },
    { qr/^(\()/m  => 'L_BRACKET' },
    { qr/^(\))/m  => 'R_BRACKET' },
    { qr/^([\s\n]*)/m => '' },
];

my @tokens;

while( <> ){
    my $line = $_;

    my $lenght = length( $line );
    my $pos = 0;

    while( $pos < $lenght ){
        debug( "POS: <$pos> FROM <$lenght>" );
        my $matched   = 0;
        my $val_lengh = 0;
        my $pr_line = substr( $line, $pos, $lenght );
        debug( "Line to process <$pr_line>" );
        foreach my $token_exp ( @{ $token_exprs } ){
            my ( $re )  = keys %{ $token_exp };
            my ( $tag ) = values %{ $token_exp };

            if( $pr_line =~ $re ){
                my $value  = $1;
                $matched   = 1;
                $val_lengh = length( $value );
                if( $tag ){
                    my $token = { $tag => $value };
                    push( @tokens, $token );
                    last;
                }
            }
        }
        if( $matched == 0 ){
            print STDERR ( "ERROR: Illegal character in line <$pr_line>\n" );
            exit 1;
        }
        $matched = 0;
        $pos += $val_lengh;
    }
}

my $json_line = '[';
foreach my $token ( @tokens ){
    my ( $tag )   = keys %{ $token };
    my ( $value ) = values %{ $token };
    $json_line .= " \"$tag\": \"$value\",";
}
$json_line =~ s/,$//;
$json_line .= ' ]';
print( "$json_line\n" );

sub debug {
    my ( $message ) = @_;

    if( $debug ){
        print( "$message\n" );
    }

    return ;
}
