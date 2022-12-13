#!/usr/bin/env perl

use 5.36.0;

chomp (my @data = <>);

my $start_pos = 1;
my $next_pos = 4;
my @piles;

# first parse and read all lines that begin with the stacks
my ($row, $col) = (0, 0);
while ((my $line = shift @data) =~ /^\[/) {

	for (my $offset = 1; $offset < length ($line); $offset += $next_pos) {

		$piles [$row ++] [$col] = substr $line, $offset, 1;
	}

	$row = 0;
	$col ++;
}

@$_ = grep { $_ ne ' ' } @$_
  for (@piles);

shift @data;

foreach my $line (@data) {

	my ($qty, $from, $to) = $line =~ /[0-9]+/g;

	# first extract $qty elements from pile $from - 1;
	my @removed = splice @{$piles [$from - 1]}, 0, $qty;

	# add these elements in selected order to pile $to - 1;
	@{$piles [$to - 1]} = (@removed, @{$piles [$to - 1]});
}


say "Top of Piles are: " . join '', map { $$_ [0] } @piles;
