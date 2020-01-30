#!/usr/bin/perl -w
use warnings;
use strict;
use Data::Dumper;

open XREF,'<', $ARGV[0] or die "Cannot read file $ARGV[0]";

my @bigg = (); 
my @mnxm = ();


while (<XREF>) {
	chomp($_);
	my @fields = split("\t",$_);
	push @mnxm, shift(@fields);
	push @bigg, shift(@fields);
}  
close XREF;

my %xref;
@xref{@mnxm} = @bigg;

my $pattern = '(' . join('|', map quotemeta, @mnxm) . ')';

open FILE,'<', $ARGV[1] or die "Cannot read file $ARGV[1]";

while (<FILE>) {
	chomp($_);
	my $line = $_;
	$line =~ s/ $pattern@/ $xref{$1}@/g;
	print "$line\n";
}

close FILE;
