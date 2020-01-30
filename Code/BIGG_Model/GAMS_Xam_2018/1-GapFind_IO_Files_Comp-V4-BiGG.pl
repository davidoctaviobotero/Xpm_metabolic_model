#!/usr/bin/perl

use strict; use warnings;

#Generates the files for GapFill based on: 

open IN,"<$ARGV[0]" or die "No puedo leer el archivo $ARGV[0]\n";
open SMATRIX, '>>S_matrix.txt';
open COMPOUNDS, '>>compounds-1.txt';
open RXN, '>>reactions.txt';
open RRXN, '>>reversible_reactions.txt';
open UPPBOUND, '>>upperbound_on_fluxes.txt';
open LOWBOUND, '>>lowerbound_on_fluxes.txt';


#leer el archivo linea a linea
my @lines=<IN>;
close IN;

print(SMATRIX "/\n");
print(RXN "/\n");
print(RRXN "/\n");
print(UPPBOUND "/\n");
print(LOWBOUND "/\n");

foreach my $line(@lines)
{
	chomp $line;
	my @fields=split(/\t/,$line);
	
#1. Analizamos solo las reacciones para generar sus archivos

	print(RXN "\'$fields[0]\'\n");	#imprima la reaccion en el archivo de reacciones

#2. Ahora analizamos todo para generar la matriz y la lista de compuestos
		
		my @met=split(/\s-->\s|\s<--\s|\s<==>\s|\s<==>|\s-->|\s<--/, $fields[1]);	#Rompe lado izquierdo y derecho de la reaccion
		my @met_izq=split(/\s\+\s/, $met[0]);	#extrae los metabolitos de la izquierda
		my @met_der=split(/\s\+\s/, $met[1]);	#extrae los metabolitos de la derecha
		
				
		if($fields[2] < 0 && $fields[3] > 0)	#Evaluando reversibles
		{
			print(RRXN "\'$fields[0]'\n");	#Imprimalo en el archivo de reversibles
			
			foreach my $met_izq_2(@met_izq)
			{			
				if($met_izq_2 =~ s/^(\d+\.\d+|\d+)\s//)	#reemplaza por nada el coeficiente estequeiometrico 
				{							
						print(COMPOUNDS "\'$met_izq_2\'\n");
						print(SMATRIX "\'$met_izq_2\'\.\'$fields[0]\' -$1\n");
				}
			}
				
			foreach my $met_der_2(@met_der)
			{			
				if($met_der_2 =~ s/^(\d+\.\d+|\d+)\s//)	#reemplaza por nada el coeficiente estequeiometrico
				{							
						print(COMPOUNDS "\'$met_der_2\'\n");
						print(SMATRIX "\'$met_der_2\'\.\'$fields[0]\' $1\n");
				}
			}
			
			#Imprimiendo límites de reacción						
			print(UPPBOUND "\'$fields[0]\' 1000\n");
			print(LOWBOUND "\'$fields[0]\' -1000\n");		
		}
		
		
		
		
		
		if($fields[2]== 0 && $fields[3] > 0) 	#Evaluando Forward
		{		
			foreach my $met_izq_2(@met_izq)
			{			
				if($met_izq_2 =~ s/^(\d+\.\d+|\d+)\s//)	#reemplaza por nada el coeficiente estequeiometrico 
				{							
						print(COMPOUNDS "\'$met_izq_2\'\n");
						print(SMATRIX "\'$met_izq_2\'\.\'$fields[0]\' -$1\n");
				}
			}
				
			foreach my $met_der_2(@met_der)
			{			
				if($met_der_2 =~ s/^(\d+\.\d+|\d+)\s//)	#reemplaza por nada el coeficiente estequeiometrico
				{							
						print(COMPOUNDS "\'$met_der_2\'\n");
						print(SMATRIX "\'$met_der_2\'\.\'$fields[0]\' $1\n");
				}
			}
			
			#Imprimiendo límites de reacción						
			print(UPPBOUND "\'$fields[0]\' 1000\n");
			print(LOWBOUND "\'$fields[0]\' 0\n");	
		}
		
		elsif($fields[2]<0 && $fields[3] == 0)	#Evaluando Backward
		{		
				foreach my $met_izq_2(@met_izq)
			{			
				if($met_izq_2 =~ s/^(\d+\.\d+|\d+)\s//)	#reemplaza por nada el coeficiente estequeiometrico 
				{							
						print(COMPOUNDS "\'$met_izq_2\'\n");
						print(SMATRIX "\'$met_izq_2\'\.\'$fields[0]\' $1\n");
				}
			}
				
			foreach my $met_der_2(@met_der)
			{			
				if($met_der_2 =~ s/^(\d+\.\d+|\d+)\s//)	#reemplaza por nada el coeficiente estequeiometrico
				{							
						print(COMPOUNDS "\'$met_der_2\'\n");
						print(SMATRIX "\'$met_der_2\'\.\'$fields[0]\' -$1\n");
				}
			}
			
			#Imprimiendo límites de reacción						
			print(UPPBOUND "\'$fields[0]\' 0\n");
			print(LOWBOUND "\'$fields[0]\' -1000\n");	
		}		
}

print(SMATRIX "/\n");
print(RXN "/\n");
print(RRXN "/\n");
print(UPPBOUND "/\n");
print(LOWBOUND "/\n");

close SMATRIX;
close COMPOUNDS;
close RXN;
close RRXN;
close UPPBOUND;
close LOWBOUND;