#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

# read data from stdin into array. do we need to make sure that the
# line separator is correctly set?  probably not.

chomp (my @calories = <>);

my ($elf, $elf_calories, $max_calories) = (0, 0, -1);

# we could have more than one elf to borrow froma
my @max_elves;

foreach my $cal (@calories) {

	if ($cal eq '') {

		# we have a new elf so process the current elf and update max
		# values/elf if required. make sure you handle the case where
		# there are more than one elves whom we can borrow from.

		if ($elf_calories >= $max_calories) {

			if ($elf_calories > $max_calories) {

				# we have an elf who clearly has the most calories
				# (not tied) so far, so junk all the earlier ones and
				# restart

				@max_elves = ();
			}

			$max_calories = $elf_calories;
			push @max_elves, $elf;
		}

 		$elf_calories = 0;
		++ $elf;
	}
	else {
		$elf_calories += $cal + 0;
	}


}

print "Elves " . join(', ', map $_ + 1, @max_elves) . " have $max_calories calories\n";
