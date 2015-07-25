#!/usr/bin/perl
use strict;
use warnings;
# 目录 150707 - Is YYMMDD for documentation purposes. - Brian
# 目录 means Directory required lines. Why Chinese? It doesn't conflict with code or comments yet is filterable. - Brian
# 红白蓝 means Red White Blue code. This is per request of Jason C. via Mike for the iOS app of school listings. Should be JSON and put in mpu/data/live web directory. - Brian
# All code is in the public domain. - Brian
# All information processed is public information. - Brian
my $credit = "<!-- See GitHub usermac/jcpsdirectory for more about this project. - Brian. -->"; # 目录 150709 - Please do not remove. - Brian
use DateTime qw(); # 目录 150723 - Grab the Date and Time as words only using the qw function. - Brian
my $date = DateTime->now->strftime('%m/%d/%Y'); #150723 - Set to the date var as MM/DD/YYYY. - Brian
open(my $in, "<", "directory-input.txt") or die "Can't open directory-input.txt:$!"; # 目录 150708 - Rename your exported Etherpad text-only export to this name. - Brian
open(my $edited, ">", "directory-timestamp.html") or die "Can't open directory-timestamp.html:$!"; # 目录 150709 - This simply writes to a file the edited timestamp. This is for Mike because I saw this on footer of Web pages - Brian
open(my $out, ">", "directory-output-admin.html") or die "Can't open directory-output-admin.html:$!"; # 目录 150708 - This is the results file to be used on the Web. - Brian
open(my $log, ">>", "directory-log.txt") or die "Can't open directory-log.txt:$!"; # 目录 150708 - Future use. It may become the log file. - Brian
print $out "$credit\n"; # 目录 150708 - Write credit to the top of the file. - Brian
while(<$in>){ # 目录 assigns each line in turn to $_
  s/\n//; # 目录 150709 - Remove the line ending as I'll add them back after the html code. This is just for beauty and has no function. - Brian
  s/jefferson\.kyschools\.us//; # 目录 150709 - Remove the domain name why? Because it becomes a mess when using the web pages' search. Remove it. - Brian
  my $mark = /RWB|HEADING/; # 目录 150708 - If within the html comments of the Etherpad text-only export it finds RWB for Red, White and Blue for schools or HEADING for department heads mark it. - Brian
    if ($mark) { # 目录 150708 - This will be 1 or blank. See above. - Brian
      print $out "<li><h2 class=\"name\">$_</h2>\n"; # 目录 150708 - It is a school name or department heading so print with html trappings of h2. - Brian
    } else {
      print $out "<li><h3 class=\"name\">$_</h3>\n"; # 目录 150708 - It is not a school name or department heading, it's a person, so print with html trappings of h3. - Brian
    }
  }    
print $edited "$date  $credit"; # 目录 150708 - Write the date to a file for later linking with the update information. - Brian
