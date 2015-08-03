#!/usr/bin/perl
use strict;
use warnings;
# All information processed is public information. - Brian
# 150707 - Is YYMMDD for documentation purposes. - Brian
# 150729 - Comments are on the same line as the code. - Brian
# Do a find for "目录" to find Directory code lines. Why Chinese? It doesn't conflict with code yet is uniquely searchable. - Brian
# Do a find for "红白蓝" to find schools only or what we call "Red, White and Blue" list. This is per request of Jason C. via Mike for the iOS app of school listings. Should be JSON and put in mpu/data/live web directory. - Brian
# All code is in the public domain. - Brian
# _+_+_+_+_+_+_+_+_+_+_ Processing Online Directory _+_+_+_+_+_+_+_+_+_+_
my $credit = "<!-- See GitHub usermac/jcpsdirectory for more about this project. - Brian. -->"; # 目录 红白蓝 150709 - Please do not remove. - Brian
use DateTime qw(); # 目录 150723 - Grab the Date and Time as words only using the qw function. - Brian
my $date = DateTime->now->strftime('%m/%d/%Y'); #150723 - Set to the date var as MM/DD/YYYY. - Brian
open(my $in, "<", "directory-input.txt") or die "Can't open directory-input.txt:$!"; # 目录 150708 - Rename your exported Etherpad text-only export to this name. - Brian
open(my $edited, ">", "directory-timestamp.html") or die "Can't open directory-timestamp.html:$!"; # 目录 150709 - This simply writes to a file the edited timestamp. This is for Mike because I saw this on footer of Web pages - Brian
open(my $out, ">", "directory-admin.html") or die "Can't open directory-admin.html:$!"; # 目录 150708 - This is the results file to be used on the Web. - Brian
open(my $log, ">>", "directory-log.txt") or die "Can't open directory-log.txt:$!"; # 目录 150708 - Future use. It may become the log file. - Brian
print $out "$credit\n"; # 目录 150708 - Write credit to the top of the file. - Brian
while(<$in>){ # 目录 assigns each line in turn to $_
  s/\n//; # 目录 150709 - Remove the line ending as I'll add them back after the html code. This is just for beauty and has no function. - Brian
  s/jefferson\.kyschools\.us//; # 目录 150709 - Remove the domain name why? Because it becomes a mess when using the web pages' search. Remove it. - Brian
  my $mark = /RWB|HEADING/; # 目录 150708 - If within the html comments of the Etherpad text-only export it finds RWB for Red, White and Blue for schools or HEADING for department heads mark it. - Brian
    if ($mark) { # 目录 150708 - This will be 1 or blank. See above. - Brian
      print $out "<li><h2 class=\"name\">$_</h2>\n"; # 目录 150708 - It is a school name or department heading so print with html trappings of h2. - Brian
    } else { # 目录
      print $out "<li><h3 class=\"name\">$_</h3>\n"; # 目录 150708 - It is not a school name or department heading, it's a person, so print with html trappings of h3. - Brian
    }
  }    
print $edited "$date  $credit"; # 目录 150708 - Write the date to a file for later linking with the update information. - Brian
# _+_+_+_+_+_+_+_+_+_+_ Processing Schools _+_+_+_+_+_+_+_+_+_+_
# 红白蓝 150728 Begin processing just schools for JSON format. This is for the iPhone app. - Brian
# 红白蓝 150731 "Louisville, KY" is assumed. (502) area code is also assumed. They are sorted by school name. - Brian
open(my $in2, "<", "directory-input.txt") or die "Can't open directory-input.txt:$!"; # 红白蓝 150708 - Rename your exported Etherpad text-only export to this name. This is the same file as $in above. - Brian
open(my $json_schools, ">", "directory-schools.json") or die "Can't open directory-schools.json:$!"; # 红白蓝 150726 - This is the results file to be used on the Web for JSON read-only. - Brian
      print $json_schools "{\n    \"school\":\n    [\n    {\n"; # 红白蓝 150730 - This is the opening lines to the JSON. - Brian
my $address = "\",\n        \"address\": \""; # 红白蓝 150803 - JSON between code for address text. - Brian
my $phone = "\",\n        \"phone\": \""; # 红白蓝 150803 - JSON between code for phone text. - Brian
my $search = "\",\n        \"search\": \""; # 红白蓝 150803 - JSON between code for search text. - Brian
while(<$in2>){ # 红白蓝 assigns each line in turn to $_
  s/\n//; # 红白蓝 150709 - Remove the line ending as I'll add them back after the html code. This is just for beauty and has no function. - Brian
  s/, 4/, Louisville KY 4/; # 红白蓝 150803 - Fills in the assumed city and state of Louisville KY. Searches for ", 4" which is the end of the address and beginning of the zip code. - Brian
  my $mark = /RWB/; # 红白蓝 150708 - If within the html comments of the Etherpad text-only export it finds RWB for Red, White and Blue for schools or HEADING for department heads mark it. - Brian
    if ($mark) { # 红白蓝 150708 - This will be 1 or blank. See above. - Brian
      s/;/$address/;
      s/;/$phone/;
      s/" /"/; # 红白蓝 150803 - Fix a silly formatting error where I don't account for a space properly above. - Brian
      s/<!-- /$search/;
      s/ -->/"/; # 红白蓝 150803 - Replace the close comment tag with a simple quote to end the entry. - Brian
      print $json_schools "        \"entity\": \"$_\n    }, {\n"; # 红白蓝 150708 - It is a school name or department heading so print with html trappings of h2. - Brian
#        "entity": "3",
     }  
  }
      print $json_schools "        \"comment\": \"end of file. $credit\" }\n      ]\n}"; # 红白蓝 150730 - This is the closing lines to the JSON. - Brian
# _+_+_+_+_+_+_+_+_+_+_ Processing Presonnel _+_+_+_+_+_+_+_+_+_+_
