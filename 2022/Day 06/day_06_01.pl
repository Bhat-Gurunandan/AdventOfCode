#!/usr/bin/env perl

use 5.36.0;

chomp (my $line = <>);

my $offset = 0;
my $packet = 4;

my $found = 0;

while (! $found) {

	my @chars = sort split //, substr $line, $offset++, $packet;

	my $char = '';
	my $count = 0;
	for (@chars) {

		last if ($_ eq $char);

		$char = $_;
		$count ++;
	}

	$found = 1 if $count == $packet;
}

say "Pattern has size: " . ($offset - 1 + $packet);
