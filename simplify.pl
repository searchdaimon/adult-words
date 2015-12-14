use strict;
use warnings;

my $file = shift or die("Pleas give file to simplify as arg 1");

open(INF, $file ) or die("Can not open $file: $!");

while (<INF>) {
	chomp;

	if ($_ =~ /^#/) {next;}
	if ($_ eq '') {next;}

	my ($word, $freq) = split(/ ([^ ]+)$/, $_);
	print "$word\n";
}

close INF;
