#!/usr/bin/perl

use strict; use warnings;


open IN,"<$ARGV[0]" or die "Can not read the file $ARGV[0]\n";
open SMATRIX, '>>S_matrix.txt';
open COMPOUNDS, '>>compounds.txt';
open RXN, '>>reactions.txt';
open RRXN, '>>reversible_reactions.txt';
open UPPBOUND, '>>upperbound_on_fluxes.txt';
open LOWBOUND, '>>lowerbound_on_fluxes.txt';

my @lines=<IN>;
close IN;

foreach my $line(@lines)
{
	chomp $line;
	my @fields=split(/\t/,$line);
	
#Reaction files
	
	print(RXN "\'$fields[0]\'\n");	#Print reaction
	
	
	if($fields[1] =~ /\s<=>\s/)	#Reversible reaction
	{
		print(RRXN "\'$fields[0]\'\n");
		print(UPPBOUND "\'$fields[0]\' 1000\n");
		print(LOWBOUND "\'$fields[0]\' -1000\n");
	}
	elsif($fields[1] =~ /\s=>\s/)	#Irreversible reaction
	{
		print(UPPBOUND "\'$fields[0]\' 1000\n");
		print(LOWBOUND "\'$fields[0]\' 0\n");
	}
	elsif($fields[1] =~ /\s<=\s/)	#Irreversible reaction
	{
		print(UPPBOUND "\'$fields[0]\' 1000\n");
		print(LOWBOUND "\'$fields[0]\' 0\n");
	}
	
#Stoichiometric Matrix

	if($fields[1] =~ /\s<=\s/)
	{
		my @met=split(/\s<=\s/, $fields[1]);
		my @met_izq = ();
		my @met_der = ();
		
		if($met[0] =~ /\s\+\s/)
		{
			@met_izq = split(/\s\+\s/, $met[0]);
		}
		else
		{
			@met_izq = $met[0];
		}
			
		foreach my $met_izq_2(@met_izq)
		{
			if($met_izq_2 =~ s/^\s?\((\d+\.\d+|\d+)\)\s//)	#Stoichiometric coefficient
			{
				print(COMPOUNDS "\'$met_izq_2\'\n");
				print(SMATRIX "\'$met_izq_2\'\.\'$fields[0]\' $1\n");
			}
			else	#Stoichiometric coefficient is 1
			{
			
				print(COMPOUNDS "\'$met_izq_2\'\n");
				print(SMATRIX "\'$met_izq_2\'\.\'$fields[0]\' 1\n");
			}
		}
		
		if($met[1] =~ /\s\+\s/)
		{
			@met_der = split(/\s\+\s/, $met[1]);
		}
		else
		{
			@met_der = $met[1];
		}
			
		foreach my $met_der_2(@met_der)
		{
			if($met_der_2 =~ s/^\s?\((\d+\.\d+|\d+)\)\s//)	#Stoichiometric coefficient
			{				
				print(COMPOUNDS "\'$met_der_2\'\n");
				print(SMATRIX "\'$met_der_2\'\.\'$fields[0]\' -$1\n");
			}
			else	#Stoichiometric coefficient is 1
			{	
				print(COMPOUNDS "\'$met_der_2\'\n");
				print(SMATRIX "\'$met_der_2\'\.\'$fields[0]\' -1\n");
			}
		}
	}
	else
	{
		my @met=split(/\s=>\s|\s<=>\s/, $fields[1]);
		
		my @met_izq = ();
		my @met_der = ();
		
		if($met[0] =~ /\s\+\s/)
		{
			@met_izq = split(/\s\+\s/, $met[0]);
		}
		else
		{
			@met_izq = $met[0];
		}
		
			
		foreach my $met_izq_2(@met_izq)
		{
			if($met_izq_2 =~ s/^\s?\((\d+\.\d+|\d+)\)\s//)	#Stoichiometric coefficient
			{
				print(COMPOUNDS "\'$met_izq_2\'\n");
				print(SMATRIX "\'$met_izq_2\'\.\'$fields[0]\' -$1\n");
			}
			else	#Stoichiometric coefficient is 1
			{
			
				print(COMPOUNDS "\'$met_izq_2\'\n");
				print(SMATRIX "\'$met_izq_2\'\.\'$fields[0]\' -1\n");
			}
		}
		
		if($met[1] =~ /\s\+\s/)
		{
			@met_der = split(/\s\+\s/, $met[1]);
		}
		else
		{
			@met_der = $met[1];
		}
		
		foreach my $met_der_2(@met_der)
		{
			if($met_der_2 =~ s/^\s?\((\d+\.\d+|\d+)\)\s//)	#Stoichiometric coefficient
			{				
				print(COMPOUNDS "\'$met_der_2\'\n");
				print(SMATRIX "\'$met_der_2\'\.\'$fields[0]\' $1\n");
			}
			else	#Stoichiometric coefficient is 1
			{	
				print(COMPOUNDS "\'$met_der_2\'\n");
				print(SMATRIX "\'$met_der_2\'\.\'$fields[0]\' 1\n");
			}
		}
	}
}

close SMATRIX;
close COMPOUNDS;
close RXN;
close RRXN;
close UPPBOUND;
close LOWBOUND;
