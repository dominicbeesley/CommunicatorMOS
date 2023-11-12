#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Std;
use Data::Dumper;
use File::Spec;

$Getopt::Std::STANDARD_HELP_VERSION = 1;
my %opts=();
getopts('b:d:', \%opts);

#print Dumper(\%opts);

$opts{d} && ! -d $opts{d} && die "No such directory \"$opts{d}\"";

my $addr = exists($opts{b})?hexmaybe($opts{b}):0xFC0000;

print "ADDR     SERV SIZE   FLAGS    VER  NAME\n";
print "======== ==== ====== ======== ==== ====================\n";

while (my $filename = shift) {

	print "--- $filename ---\n";

	open(my $fh, "<:raw:", $filename) or die "Cannot open \"$filename\" for input : $!";

	my $rombin = do {local $/; <$fh> };

	while (length ($rombin) >= 256) {
		
		my ($brl, $brloffs, $crcoffs, $crcoffsh, $ver, $flags, $resv, $cmdtab, $helptab) = unpack("C S S C S L S Z* Z*", $rombin);

		#  TODO: technically need a better check here but this appears to work
		if ($brl != 0x82) {
			printf "skipping ... %x\n", $addr;

			if ($opts{d}) {
				my $curmod = substr($rombin, 0, 256);
				my $modfn = "pad-" . sprintf("%06X", $addr) . ".bin";
				my $modfn2 = File::Spec->catfile($opts{d}, $modfn);
				open(my $fho, ">:raw:", $modfn2) or die "Cannot open \"$modfn2\" for output $!";
				print $fho $curmod;
				close $fho;
			}

			$rombin = substr($rombin, 256);
			$addr += 256;
		} else {

			$crcoffs += 0x1000 * $crcoffsh;
			my @cmds = unescapeall(split /(?<!\|)\//, $cmdtab);
			my @helps = unescapeall(split /(?<!\|)\//, $helptab);
			my $title = $cmds[0];

			printf "%08x %04x %06x %08x %04x %-20s\n", $addr, $brloffs, $crcoffs, $flags, $ver, $title;	

			my $skip = ($crcoffs + 255 + 2) & 0xFFFF00;


			$skip > length($rombin) && die "module straddles ROM boundary";

			if ($opts{d}) {
				my $curmod = substr($rombin, 0, $skip);
				my $modfn = $title . (($flags & 0x80)?".bas":".mod");
				my $modfn2 = File::Spec->catfile($opts{d}, $modfn);
				open(my $fho, ">:raw:", $modfn2) or die "Cannot open \"$modfn2\" for output $!";
				print $fho $curmod;
				close $fho;
				my $modfn3 = File::Spec->catfile($opts{d}, "$modfn.info");
				open(my $fhoi, ">", $modfn3) or die "Cannot open \"$modfn3\" for output $!";
				print 	$fhoi "TITLE:\t$title\n";
				printf 	$fhoi "BASE:\t%06x\n", $addr;
				print 	$fhoi "FLAGS:\t$flags\n";
				print   $fhoi "COMMANDS:\n";

				for (my $i=0; $i <= $#cmds && $i < $#helps; $i++) {
					print $fhoi "\t$cmds[$i]\t$helps[$i]\n";
				} 

				close $fhoi;
				
			}

			$rombin = substr($rombin, $skip);
			$addr += $skip;
		}

	}

	close $fh;
}

sub HELP_MESSAGE {
	print "
catalogue-modules.pl [options] files...

	-b	Set base address (default 0xFC0000)
	-d <directory>
		Dump module binaries to directory as <title>.mod or title.bbc (for BASIC)
";
}

sub VERSION_MESSAGE {
	print "catalogue-module.pl 0.1\n";
}

sub hexmaybe {
	my ($in) = @_;

	$in =~ s/^\s*//;
	$in =~ s/\s*$//;

	if ($in =~ /^(0x|\$|\&)([0-9A-F]+)$/) {
		return hex($2);
	} else {
		return $in;
	}
}

sub unescape {
	my ($i) = @_;

	$i =~ s/\|(.)/$1/g;

	return $i
}

sub unescapeall {

	my @ret = ();

	foreach my $x (@_) { 
		push @ret, unescape($x);
	}

	return @ret;
}