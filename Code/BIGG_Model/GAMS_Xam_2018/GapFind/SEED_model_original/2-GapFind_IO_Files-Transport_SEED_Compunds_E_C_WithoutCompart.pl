#!/usr/bin/perl

#Programa para escribir el listado de compuestos citosólicos y extracelulares por separado

use strict; use warnings;

open IN,"<$ARGV[0]" or die "No puedo leer el archivo $ARGV[0]\n";
open CCOMPOUNDS, '>>cytosolic_compounds.txt';
open ECOMPOUNDS, '>>extracellular_compounds.txt';


#leer el archivo linea a linea
my @lines=<IN>;
close IN;

print(CCOMPOUNDS "/\n");
print(ECOMPOUNDS "/\n");

foreach my $line(@lines)
{
	chomp $line;
			
	if($line =~ /\[e0\]/)	#Determina si la compartimentalizacion es extracelular
	{
		print(ECOMPOUNDS "$line\n");
	}
	else	#Sino es citosólica
	{
		print(CCOMPOUNDS "$line\n");
	}
}

print(CCOMPOUNDS "/\n");
print(ECOMPOUNDS "/\n");

close CCOMPOUNDS;
close ECOMPOUNDS;
