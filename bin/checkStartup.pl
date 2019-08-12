#!/usr/bin/perl

use strict;
use warnings;
use Time::Piece;

my ($t, $st, $et, $sec); 

my $f = shift;
die "Usage: $0 <file>\n" unless $f;
open(my $fh, '<', $f) or die("Error: $!\n");

print " Time | Control | StartUp or Stop Time : Sec(hour) \n";
while (my $line = <$fh>) {

	chomp($line);

    if( $line =~ /^(\d{4}-\d{2}-\d{2}).(\d{2}:\d{2}:\d{2})\..+/ ) { 
    	$t = Time::Piece->strptime("$1 $2", '%Y-%m-%d %H:%M:%S');
    	next; 
    }

    if( $line =~ /^(Starting ORACLE instance) \(.+\) \(OS id: \d+\)/ ) {
    	$st = $t; 
 		$sec = defined $et ? $st - $et : Time::Seconds->new(0);
 		my $sh = sprintf("%.0f", $sec->hours);
    	print $st->strftime('%Y-%m-%d %H:%M:%S') . " | $1   | $sec($sh) \n";
    	next;

    } elsif ( $line =~ /^(Instance shutdown complete) \(OS id: \d+\)/ ) {
    	$et = $t; 
    	$sec = $et - $st;
    	my $eh = sprintf("%.0f", $sec->hours);
    	print $et->strftime('%Y-%m-%d %H:%M:%S') . " | $1 | $sec($eh) \n"; 
    	next;
    }

}
close($fh);
