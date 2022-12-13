#!/usr/bin/env perl

use strict;
use warnings;

my $results = {
             X => {
                   A => (1 + 3),
                   B => (1 + 0),
                   C => (1 + 6),
                  },
             Y => {
                   A => (2 + 6),
                   B => (2 + 3),
                   C => (2 + 0),
                  },
             Z => {
                   A => (3 + 0),
                   B => (3 + 6),
                   C => (3 + 3),
                  },
            };

chomp (my @results = <>);
my $score;
foreach my $result (@results) {

	my ($his, $mine) = split /\s+/, $result;
	die "Illegal Result\n" unless
	  $his &&
	  $mine &&
	  ($his =~ /[ABC]/) &&
	  ($mine =~ /[XYZ]/);

	$score += $$results {$mine} {$his};
}

print "Total Score is $score\n";
