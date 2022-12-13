#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

chomp (my @rucksack = <>);

my $priority = 0;
my ($ord_a, $ord_A) = (ord('a'), ord('A'));
foreach my $items (@rucksack) {

    my $len = length ($items);
    die "Error: found odd number of items\n"
      if $len % 2;

    my @items = split //, $items;
    my $qty = int ($len / 2);

    # create a hash with item identifiers as keys. repetaed
    # identifiers are fine.

	my $map;
    @{$map} {@items[0 .. $qty - 1]} = (1) x $qty;

    # Check if a key exists to pick the duplicated items and stop when
    # you find one.

    for (@items [$qty .. $len - 1]) {

        if ($$map {$_}) {

			my $_ord = ord ($_);

			$priority += ($_ord >= $ord_a) ?
              ($_ord - $ord_a) + 1
              : ($_ord - $ord_A) + 27;

            last;
        }
    }
}

print "Total Priority is $priority\n";
