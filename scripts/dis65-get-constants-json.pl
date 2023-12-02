#!/usr/bin/env perl

use strict;
use warnings;

use JSON::Parse qw(parse_json);
use JSON::Create qw(create_json);
use Data::Dumper;
use File::BOM qw(open_bom);

my $json = "";

my $fnin = $ARGV[0];
open_bom(my $fh, $fnin, "<:utf8") or die "Cannot open $fnin : $!";

while (<$fh>) {
	my $l = $_;
	if (!($l =~ /^#/)) {
		$json = $json . $l;
	}
}

my $struct = parse_json($json);

#print Dumper($struct->{"ProjectProps"}->{"ProjectSyms"});

my %matched = ();
my $syms = $struct->{"ProjectProps"}->{"ProjectSyms"};
foreach my $k (keys %$syms) {
	my $p = $syms->{$k};
	if ($k =~ /^COP_.*/) {
		$matched{$k} = $p;
	}
}

print create_json(\%matched, indent=>1);
