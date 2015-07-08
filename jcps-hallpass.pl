#!/usr/bin/perl
use strict;
use warnings;
#150707 - Is YYMMDD for documentation purposes. - Brian
#150707 - See GitHub usermac/jcpsdirectory for more about this project. - Brian
print "Hello World\n";
my $animal = "<!-- bear -->"; 
print "The animal is a $animal.\n";
my $bananas = "";
print "We have no bananas.\n" unless $bananas;
#150707 - You should name the input file "directory-input.txt" and put is same dir. - Brian
open(my $in, "<", "directory-input.txt") or die "Can't open directory-input.txt:$!";
open(my $out, ">", "directory-output.txt") or die "Can't open directory-output.txt:$!";
open(my $log, ">>", "directory-log.txt") or die "Can't open directory-log.txt:$!";
while(<$in>){ #assigns each line in turn to $_
  s/Aldus/RAMOS/;
  s/text/TEXT/;
  s/<!--/\t/;
  s/(\S)-->/$1 -->/;
    print "Just read in this line: $_\n";
  }
  