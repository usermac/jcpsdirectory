#!/usr/bin/perl
use strict;
use warnings;
# 150707 - Is YYMMDD for documentation purposes. - Brian
my $credit = "<!-- 7/9/2015 - See GitHub usermac/jcpsdirectory for more about this project. - Brian. -->"; # 150709 - Please do not remove. - Brian
open(my $in, "<", "directory-input.txt") or die "Can't open directory-input.txt:$!"; # 150708 - Rename your exported Etherpad text-only export to this name. - Brian
open(my $edited, ">", "directory-timestamp.html") or die "Can't open directory-timestamp.html:$!"; # 150709 - This simply writes to a file the edited timestamp. This is for Mike because I saw this on footer of Web pages - Brian
open(my $out, ">", "directory-output-admin.html") or die "Can't open directory-output-admin.html:$!"; # 150708 - This is the results file to be used on the Web. - Brian
open(my $log, ">>", "directory-log.txt") or die "Can't open directory-log.txt:$!"; # 150708 - Future use. It may become the log file. - Brian
print $out "$credit\n"; # 150708 - Write credit to the top of the file. - Brian
while(<$in>){ #assigns each line in turn to $_
  s/\n//; # 150709 - Remove the line ending as I'll add them back after the html code. This is just for beauty and has no function. - Brian
  s/jefferson\.kyschools\.us//; #150709 - Remove the domain name why? Because it becomes a mess when using the web pages' search. Remove it. - Brian
  my $mark = /RWB|HEADING/; #150708 - If within the html comments of the Etherpad text-only export it finds RWB for Red, White and Blue for schools or HEADING for department heads mark it. - Brian
    if ($mark) { # 150708 - This will be 1 or blank. See above. - Brian
      print $out "<li><h2 class=\"name\">$_</h2>\n"; # 150708 - It is a school name or department heading so print with html trappings of h2. - Brian
    } else {
      print $out "<li><h3 class=\"name\">$_</h3>\n"; # 150708 - It is not a school name or department heading, it's a person, so print with html trappings of h3. - Brian
    }
  }    
my $time = localtime; # scalar context. Needed to setup the freshness date and time of the data. - Brian
print $edited "$time  $credit"; # 150708 - Write the timestamp to a file for later linking with the update information. - Brian
