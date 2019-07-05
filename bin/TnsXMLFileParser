#!/usr/bin/perl

use strict;
use warnings;

my $f = shift;
die "Usage: $0 <file>\n" unless $f;

open(my $fh, '<', $f) or die("Error: $!\n");
while (my $line = <$fh>){
    if( $line =~ /^<\/msg>/ ) { $line =~ s/<\/msg>/\n/g; print $line; next; }
    chomp($line);
    $line =~ s/<[\/,a-z]+>//g;
    $line =~ s/^<msg //g;
    if ($line =~ /CONNECT_DATA=/){
        print $line;
    }
}
close($fh);
