#!/usr/bin/perl -w
use warnings;
use strict;
use Data::Dumper;

open SMATRIX, '>>S_matrix_corrected.txt';
open SMATRIXPRO, '>>S_matrix_PRO.txt';

my $file = $ARGV[0];

open FILE,'<', $file or die "Cannot read file $file";

my %S_Matrix;

while (<FILE>) {
	chomp($_);
	my @fields = split(' ',$_);
	my $key = shift(@fields);	
	my $value = shift(@fields);	
	if($S_Matrix{$key})
	{
		print(SMATRIXPRO "$key\t$S_Matrix{$key}\n");
		print(SMATRIXPRO "$key\t$value\n");
		my $result = $S_Matrix{$key} + $value;
		$S_Matrix{$key} = $result;
		if($result == 0)
		{
			
			delete $S_Matrix{$key} # borrar registro
		}
	}
	else
	{
		$S_Matrix{$key} = $value;
	}
}   

foreach my $key (sort keys %S_Matrix) {
    print(SMATRIX "$key\t$S_Matrix{$key}\n");
}

close SMATRIX;
close SMATRIXPRO;