#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;

my $scp="/usr/bin/scp";
my $rc="";
my $file="";
my $user="";
my @hosts=();
my %opts=();

GetOptions(\%opts,
        'f=s',
        'u=s',
        'help'
);

if ( exists $opts{help} ) {
        print "Usage: scp.pl -f file host1, host2, host3\n";
        print "OR scp.pl -f file host1 host2 host3\n";
        exit 0;
}

if ( !$opts{f} ) {
        print STDERR "ERROR: Need -f file name\n";
        exit 1;
}

if ( !$opts{u} ) {
        print STDERR "ERROR: Need -u User name\n";
        exit 1;
}

$file = $opts{f};
$user = $opts{u};

while ( my $h = shift(@ARGV) ) {
        push( @hosts, split(/[ \t\,]/, $h) );
}


foreach my $host (@hosts) {
        print "host is $host\n";
        print "$scp $file $user\@$host\n";

        my $cmd="";
        if ( $user eq 'root') {
                $cmd = "$scp $file $user\@$host:/$user/";
        } else {
                $cmd = "$scp $file $user\@$host:/home/$user/";
        }
        $rc = system("$cmd");
        if ($rc ne '0') {
                print STDERR "ERROR: scp $file $user\@$host failed....\n";
        }
}
