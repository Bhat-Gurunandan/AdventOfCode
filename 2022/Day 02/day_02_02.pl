#!/usr/bin/env perl

use strict;
use warnings;

my $choose = {
			  X => { # must lose
					A => 'Z',
					B => 'X',
					C => 'Y',
				   },
			  Y => { # must draw
					A => 'X',
					B => 'Y',
					C => 'Z',
				   },
			  Z => { # must win
					A => 'Y',
					B => 'Z',
					C => 'X',
				   },
			};
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

chomp (my @data = <>);
my $score;
foreach my $game (@data) {

	my ($his, $result) = split /\s+/, $game;
	die "Illegal Result\n" unless
	  $his &&
	  $result &&
	  ($his =~ /[ABC]/) &&
	  ($result =~ /[XYZ]/);

	$score += $$results {$$choose {$result} {$his}} {$his};
}

print "Total Score is $score\n";
