#!/usr/bin/env perl

use 5.36.0;

chomp (my @data = <>);

my $is_inside;
my $no_overlap;

foreach my $sections (@data) {

	my ($first_left, $first_right, $second_left, $second_right) =
	                                     $sections =~ /[0-9]+/g;

	if (($first_left <= $second_left && $first_right >= $second_right) ||
	   ($second_left <= $first_left && $second_right >= $first_right)) {

		++ $is_inside;
	}
	elsif ($first_left > $second_right ||
		  $first_right < $second_left) {

		++ $no_overlap;
	}
}

say "Included Sections: $is_inside";
say "Overlapping sections: " . (scalar (@data) - $no_overlap);
