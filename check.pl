#!/usr/bin/perl

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
use Term::ANSIColor;

my @files = ({ name => "Adult_words_list_basic.txt", occurrence => 1},	{ name => "Adult_words_list_phrases.txt", occurrence => 2 });

foreach my $file (@files) {

	print $file->{name},":\n";

	open(INF, $file->{name} ) or die("Can not open $file: $!");

	my %words;
	my $line = 0;
	my $errors = 0;
	while (<INF>) {
		chomp;

		$line++;

		if ($_ =~ /^#/) {next;}
		if ($_ eq '') {next;}

		if ($_ =~ / $/) {
			print "\tEntry '$_' ends in a space on line $line\n";
			$errors++;
			next;
		}

		if ($_ =~ /  /) {
			print "\tEntry '$_' has sequential spaces on line $line\n";
			$errors++;
			next;
		}

		my ($word, $value) = split(/ ([^ ]+)$/, $_);

		if ((scalar split(' ', $word)) != $file->{occurrence}) {
			print "\tEntry '$_' dos not have the correct number of words on line $line\n";
			$errors++;
			next;
		}

		if (!$value) {
			print "\tCan not find number in entry '$_' on line $line\n";
			$errors++;
			next;
		}

		if (!looks_like_number($value)) {
			print "\tValue '$value' is not a number in entry '$_' on line $line\n";
			$errors++;
			next;
		}

		if ($words{$word}) {
			print "\tDuplicate word '$word' on line $line\n";
			$errors++;
		}

		$words{$word} = 1;


		
	}

	close INF;

	if ($errors == 0) {
		print color("green"), "Ok!\n\n", color("reset");
	}
	else {
		print "\n\n";
	}

}