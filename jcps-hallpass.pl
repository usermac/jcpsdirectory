#!/usr/bin/perl
use strict;
use warnings;
# 150707 - Is YYMMDD for documentation purposes. - Brian
# 150707 - See GitHub usermac/jcpsdirectory for more about this project. - Brian
open(my $in, "<", "directory-input.txt") or die "Can't open directory-input.txt:$!"; # 150708 - Rename your exported Etherpad text-only export to this name. - Brian
open(my $out, ">", "directory-output.txt") or die "Can't open directory-output.txt:$!"; # 150708 - This is the results file to be used on the Web. - Brian
open(my $log, ">>", "directory-log.txt") or die "Can't open directory-log.txt:$!"; # 150708 - Future use. It may become the log file. - Brian
while(<$in>){ #assigns each line in turn to $_
my $mark = /RWB|HEADING/; #150708 - If within the html comments of the Etherpad text-only export it finds RWB for Red, White and Blue for schools or HEADING for department heads mark it. - Brian
  if ($mark) { # 150708 - This will be 1 or blank. See above. - Brian
    print $out "<li><h2 class=\"name\">$_</h2>\n"; # 150708 - It is a school name or department heading so print with html trappings of h2. - Brian
    } else {
    print $out "<li><h3 class=\"name\">$_</h3>\n"; # 150708 - It is not a school name or department heading so print with html trappings of h3. - Brian
    }
  }    
my $time = localtime; # scalar context. Needed to setup the freshness date and time at the top. - Brian
print $out "\n<li><h2 class=\"edited\">Updated: $time<!--  --></h2>\n"; # 150708 - This is it. How it writes each line to the file. - Brian
