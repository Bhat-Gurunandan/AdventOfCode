#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

chomp (my @rucksack = <>);

my $priority = 0;
my $batch_size = 3;
my $batch = 0;
my @map;

my ($ord_a, $ord_A) = (ord('a'), ord('A'));

foreach my $items (@rucksack) {

    # create a hash with item identifiers as keys. repetaed
    # identifiers are fine.

    @{$map [$batch++]} {split //, $items} = (1) x length ($items);

	if (@map == $batch_size) {

		# We have a batch of 3. process the batch with a giant has of
		# all elements in a batch to loop over every possible key

		my %seen = map { %$_} @map;
		foreach my $key (keys %seen) {

			my $sum;
			for (@map) {
				$sum += $$_ {$key} // 0;
			}

			if ($sum == $batch_size) {

				# since each element contributes 1, a sum of
				# batch_size means we have that key in every
				# hash. find the priority and increment it

				my $_ord = ord ($key);

				$priority += ($_ord >= $ord_a) ?
				  ($_ord - $ord_a) + 1
				  : ($_ord - $ord_A) + 27;

				last;
			}
		}

		# reset batch

		$batch = 0;
		@map = ();
	}
}

print "Total Priority is $priority\n";
