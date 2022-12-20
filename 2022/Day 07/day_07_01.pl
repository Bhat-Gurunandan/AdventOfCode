#!/usr/bin/env perl

use 5.36.0;
use Data::Dumper;

chomp (my @ops = <>);

# Two assumption: (1) we move directories one step at a time (via cd)
# except a move to the root directory which can be carried out at any
# point. The move along the file system can therefore be modeled with
# a simple stack and (2) We never list (via ls) the same directory
# twice

my @dirs;  # a stack to model directories
my $sizes; # a has to keep track of file sizes

my $current_path = '';

foreach my $op (@ops) {

	my @cmd = split / /, $op;

	if ($cmd [0] eq '$') {

		# we have three possibilities: cd, dir and lsof which we
		# ignore dir and ls since they have no consequence

		 move_to ($cmd [2] =~ s/^\///r) if ($cmd [1] eq 'cd');
	}
	elsif ($cmd [0] =~ /[0-9]+/) {

		add_to_current ($cmd [0]);
	}
}

my $sum;
$sum += $_ for (grep {$_ <= 100000} values %$sizes);

my $disk_space = 70000000;
my $required   = 30000000;
my $must_free  = $required - $disk_space + $$sizes {'/'};

say "Sum is $sum and required free space is $must_free";

# Now we need to find the size of the smallest directory that has
# total size greater than $must_free

my $to_delete = $required; # Just some large number
foreach my $size (values %$sizes) {

	next if $size < $must_free;
	$to_delete = $size if $size <= $to_delete;
}

say "Smallest directory size to be deleted is $to_delete";

sub move_to ($dir) {

	if ($dir eq '..') {
		pop @dirs;
	}
	else {
		push @dirs, $current_path .= '/' . $dir;
	}

	$current_path = $dirs [-1];
}

sub add_to_current ($size) {

	# Just make sure we have not visited the same directory in our
	# travels

	$$sizes {$_} += $size for (@dirs);
}
