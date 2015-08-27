#!/usr/bin/perl
use strict;
use warnings;
# All information processed is public information.—Brian
# 150707—Is YYMMDD for documentation purposes.—Brian
# 150729—Comments are on the same line as the code.—Brian
# Do a find for "目录" to find Directory code lines. Why Chinese? It doesn't conflict with code; searchable.—Brian
# Do a find for "红白蓝" to find Schools or what we call the "Red, White, and Blue" list. This is per request of Jason C. via Mike for the iOS app of school listings. Should be JSON and put in mpu/data/live web directory.—Brian
# All code is in the public domain.—Brian
# _+_+_+_+_+_+_+_+_+_+_ Processing Online Directory _+_+_+_+_+_+_+_+_+_+_
# 150805—Sample input lines from Etherpad follows:
# ACADEMY @ SHAWNEE; 4001 Herman Street, 40212; 485-8326 • 485-8738 <!-- Red White Blue RWB -->
# Smith, Jane; Secretary; 485-8326 • 485-8738; Academy @ Shawnee; jane.smith@jefferson.kyschools.us <!-- Jane Smith BOLD ITALIC -->
# 150805—Sample output lines from Etherpad follows:
# *** coming attraction ***
my $credit = "<!-- See GitHub usermac/jcpsdirectory for more about this project.—Brian. -->"; # 目录 红白蓝 150709—Please do not remove.—Brian
use DateTime qw(); # 目录 150723—Grab the Date and Time as words only using the qw function.—Brian
my $date = DateTime->now->strftime('%m/%d/%Y'); #150723—Set to the date variable $date as MM/DD/YYYY.—Brian
open(my $in, "<", "directory-input.txt") or die "Can't open directory-input.txt:$!"; # 目录 150708—Rename your exported Etherpad text-only export to this name.—Brian
open(my $edited, ">", "directory-timestamp.html") or die "Can't open directory-timestamp.html:$!"; # 目录 150709—This simply writes to a file the edited timestamp. This is for Mike because I saw this on footer of Web pages.—Brian
open(my $out, ">", "directory-admin.html") or die "Can't open directory-admin.html:$!"; # 目录 150708—This is the results file to be used on the Web.—Brian
open(my $log, ">>", "directory-log.txt") or die "Can't open directory-log.txt:$!"; # 目录 150708—Future use. It may become the log file.—Brian
# open(my $contact, "<", "brian.ginn@.html") or die "Can't open brian.ginn@.html:$!"; # 目录 150825—Open the template file used for placeholders of "first last", "first.last" and "first_last" to be replace to make an individual contact page of their name using the email address.—Brian
print $out "$credit\n"; # 目录 150708—Write credit to the output file.—Brian
while(<$in>){ # 目录 assigns each line in turn to $_
  s/\n//; # 目录 150709—Remove the line ending as I'll add them back after the html code. This is just for beauty and has no function.—Brian
  s/ 485/ (502) 485/g; # 目录 150820 - Mike noted we need the area code as someone called from Indy today. - Brian
 # s/ 485/ (502) 485/; # 目录 150820 - A 2nd time for the fax number to add (502). - Brian
  s/jefferson\.kyschools\.us//; # 目录 150709—Remove the domain name, why? Because it becomes a mess when using the web pages' meta. Remove it.—Brian
  my $mark = /RWB|HEADING/; # 目录 150708—If within the html comments of the Etherpad text-only export it finds RWB for Red, White, and Blue for schools or HEADING for department heads mark it.—Brian
    if ($mark) { # 目录 150708—This will be 1 or blank. See above.—Brian
      print $out "<li><h2 class=\"name\">$_</h2>\n"; # 目录 150708—It is a school name or department heading so print with html trappings of h2.—Brian
    } else { # 目录
      print $out "<li><h3 class=\"name\">$_</h3>\n"; # 目录 150708—It is not a school name or department heading, it's a person; so print with html trappings of h3.—Brian
    }
  }    
print $edited "$date  $credit"; # 目录 150708—Write the date to a file for later linking with the update information.—Brian
# _+_+_+_+_+_+_+_+_+_+_ Processing Schools _+_+_+_+_+_+_+_+_+_+_
# 红白蓝 150728 Begin processing just schools for JSON format. This is for the iPhone app.—Brian
# 150805—Sample input line from Etherpad follows:
# ACADEMY @ SHAWNEE; 4001 Herman Street, 40212; 485-8326 • 485-8738 <!-- Red White Blue RWB -->
# 红白蓝 150731 "Louisville, KY" is assumed. The (502) area code is also assumed. They are sorted by school name.—Brian
system("sort directory-input.txt > directory-input-sorted.txt"); # 红白蓝 150804—Use shell sort command to sort the file before processing.—Brian
open(my $in2, "<", "directory-input-sorted.txt") or die "Can't open directory-input-sorted.txt:$!"; # 红白蓝 150708—Rename your exported Etherpad text-only export to this name. This is the same file as $in above.—Brian
open(my $json_people, ">", "directory-people.js") or die "Can't open directory-people.js:$!"; # 目录 150708—This is the results file to be used on the Web for JSON read-only.—Brian
open(my $json_schools, ">", "directory-schools.js") or die "Can't open directory-schools.js:$!"; # 红白蓝 150726—This is the results file to be used on the Web for JSON read-only.—Brian
      print $json_schools "{\n    \"school\":\n    [\n    {\n"; # 红白蓝 150730—This is the opening lines to the JSON.—Brian
      print $json_people "{\n    \"people\":\n    [\n    {\n"; # 目录 150805—This is the opening lines to the JSON.—Brian
my $address = "\",\n        \"address\": \""; # 红白蓝 150803—JSON between code for address text.—Brian
my $position = "\",\n        \"position\": \""; # 目录 150805—JSON between code for position text.—Brian
my $loc_name = "\",\n        \"loc_name\": \""; # 目录 150805—JSON between code for location name text.—Brian
my $phone = "\",\n        \"phone\": \"(502)"; # 红白蓝 150803—JSON between code for phone text.—Brian
my $fax = "\",,\n        \"fax\": \"(502)"; # 红白蓝 150803—JSON between code for fax text.—Brian
my $school_department = "\",\n        \"school_department\": \""; # 目录 150805—JSON between code for school or department name text.—Brian
my $email = "\",\n        \"email\": \""; # 目录 150805—JSON between code for school or department name text.—Brian
my $meta = "\",,\n        \"meta\": \""; # 红白蓝 150803—JSON between code for meta text.—Brian
while(<$in2>){ # 红白蓝 assigns each line in turn to $_
  s/\n//; # 红白蓝 150709—Remove the line ending as I'll add them back after the html code. This is just for beauty and has no function.—Brian
  my $rwb = /RWB/; # 红白蓝 150708—If within the html comments of the Etherpad text-only export, it finds RWB for Red, White, and Blue for schools.—Brian
  my $head = /HEADING/; # 红白蓝 150804—If within the html comments of the Etherpad text-only export, it finds HEADING for department heads mark it.—Brian
    if ($rwb) { # 红白蓝 150708—This will be 1 or blank. See above.—Brian
      s/, 4/, Louisville KY 4/; # 红白蓝 150803—Fills in the assumed city and state of "Louisville, KY" for each ", 4" which is the end of the address and beginning of the ZIP code.—Brian
      s/;/$address/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      s/; /$phone/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      s/• /$fax/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      s/" /"/; # 红白蓝 150803—Fix a silly formatting error where I don't account for a space properly above.—Brian
      s/<!-- /$meta/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      s/ -->/"/; # 红白蓝 150803—Replace the close comment tag with a simple quote to end the entry.—Brian
      s/ ",/"/; # 红白蓝 150803—Fix more silly formatting error where I don't account for a space properly above.—Brian
      s/ ",/"/; # 红白蓝 150803—[Again] Fix more silly formatting error where I don't account for a space properly above.—Brian
      print $json_schools "        \"entity\": \"$_\n    }, {\n"; # 红白蓝 150708—It is a school name or department heading, so print with html trappings of h2.—Brian
      # 150805—Sample output from this PERL script follows:
      # { "school": [ { "entity": "ACADEMY @ SHAWNEE", "address": "4001 Herman Street, Louisville KY 40212", "phone": " 485-8326 • 485-8738 ", "search": "Red White Blue RWB" }, ...
# _+_+_+_+_+_+_+_+_+_+_ Processing People _+_+_+_+_+_+_+_+_+_+_
# 150805—Sample input line from Etherpad follows:
# Smith, Jane; Secretary; 485-8326 • 485-8738; Academy @ Shawnee; jane.smith@jefferson.kyschools.us <!-- Jane Smith BOLD ITALIC -->
     } elsif ($head) { # 目录 150804—It is not a head so it is a person so write the line.—Brian
      # 150804—Do nothing as I can't get the not-if statment correct so I do it this way. Sheesh.—Brian
     } else  { # 目录 150804—Now, finally, write the person to the file. It needs to be made JSON but it finds the right people now. ^_^ —Brian
       my $count = () = $_ =~ /\;/g; # 目录 150805—Counts number of semicolons. If 5 it's a department otherwise it's 4 and is a school. If it's not either 4 or 5, it's a line item that needs correcting at the Etherpad. This accounts for the building number just before phone in departments only.—Brian
#       print $json_people "$count";
#       print $json_people "<li><h3 class=\"name\">$_</h3>\n"; # 目录 150803—YET TO BE PROGRAMMED It is not a school name or department heading; it's a person, so print with JSON trappings.—Brian
      # 150805—Sample output from this PERL script follows:
      # *** coming attraction ***
      s/\"/\\"/; # 目录 150806—Added to fix the nicknames that are already in quotes such as "Butch".—Brian
      s/\";/\\";/; # 目录 150806—[REPEAT to do the ending quote] Added to fix the nicknames that are already in quotes such as "Butch".—Brian
      s/ ; /; /; # 目录 150806—Added to fix the spaces that are occurring before semicolons.—Brian
      s/, 4/, Louisville KY 4/; # 红白蓝 150803—Fills in the assumed city and state of "Louisville, KY" for each ", 4" which is the end of the address and beginning of the ZIP code.—Brian
      s/;/$position/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      if ($count == 5) { # 目录 150806—This is to account for the Location Name for departments which have it. Schools have 4 semicolons, departments have 5.—Brian
        s/; /$loc_name/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      }
      s/; /$phone/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      s/• /$fax/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      s/; /$school_department/; # 目录 150805—The in-between code from the var above goes here.—Brian
      s/; /$email/; # 目录 150805—The in-between code from the var above goes here.—Brian
      s/" /"/; # 红白蓝 150803—Fix a silly formatting error where I don't account for a space properly above.—Brian
      s/<!-- /$meta/; # 红白蓝 150803—The in-between code from the var above goes here.—Brian
      s/ -->/"/; # 红白蓝 150803—Replace the close comment tag with a simple quote to end the entry.—Brian
      s/ ",/"/; # 红白蓝 150803—Fix more silly formatting error where I don't account for a space properly above.—Brian
      s/ ",/"/; # 红白蓝 150803—[Again] Fix more silly formatting error where I don't account for a space properly above.—Brian
      s/,,/,/; # 目录 150805—[Again and again] Fix more silly formatting error where I don't account for a space properly above.—Brian
      s/,,/,/; # 目录 150805—[Again and again] Fix more silly formatting error where I don't account for a space properly above.—Brian
       if ($count > 1) {
         print $json_people "        \"entity\": \"$_\n    }, {\n"; # 目录 150708—Write the persons information to the file.—Brian      
        }
       } 
     }
for my $print ($json_schools, $json_people) { print $print "        \"comment\": \"$date end of file. $credit\"\n    }\n    ]\n}"}; # 红白蓝 目录 150805—This is the closing lines to the JSON.—Brian;
# _+_+_+_+_+_+_+_+_+_+_ Pre-processing directory-people.js file _+_+_+_+_+_+_+_+_+_+_
# 150827—Immediately take the resulting JSON people file above and read into memory as $in3. Format it to one line per person. Remove the head and foot, then parse and process each line to a single html page for each person.—Brian
system("cp directory-people.js directory-people2.js"); # 150827—Use shell copy command because running this natively caused a loss of data near the end of the file.—Brian
open(my $in3, "<", "directory-people2.js") or die "Can't open directory-people2.js:$!"; # 150827—Open the people JSON file to process.—Brian
open(my $out3, ">", "directory-contact.txt") or die "Can't open directory-contact.txt:$!"; # 150727—This is the resulting file.—Brian
while(<$in3>){ # Below is to prepare the file for processing. Call it pre-processing. ;) - Brian
  s/        //g;
  s/    //g;
  s/}, {/|/g;
  s/{|}//g;
  s/\[|\]//g;
  s/,\n/, /g;
  s/\|//g;
  s/"people"://;
  print $out3 "$_";
  };
system("awk 'NF > 0' directory-contact.txt > directory-contact2.txt"); # 150827—Use shell awk command to remove blank lines. Silly but effective.—Brian
#150827—Whew... Finally a file ready to begin the one-by-one creation of contact files: directory-contact2.txt file.—Brian
#150827—I think in addition to the stand-alone contact file that is linked to from the online directory page, I'll also process the vCard here because it is timely.—Brian
#150827—Each resulting file will be from a template. The filename will be the person's email address up to and including the "@" plus. ".html".—Brian
open(my $in4, "<", "directory-contact2.txt") or die "Can't open directory-contact2.txt:$!"; # 150827—Open the people JSON file to process into single files.—Brian
open(my $out4, ">", "directory-contact4.txt") or die "Can't open directory-contact4.txt:$!"; # 150727—This is the resulting file.—Brian
my $entity4 = "";
my $position4 = "";
my $school_department4 = "";
my $loc_name4 = "";
my $phone4 = "";
my $fax4 = "";
my $email4 = "";
my $last_name4 = "";
my $first_name4 = "";
while(<$in4>){ # - Brian
  #  $last_name4 =~ s/("entity": "([a-z]|[A-Z].)+,)/$1/;
  #  s/[a-z]/9/;
  #  $last_name2 = "abc";
  #  s//(.*)\s(.*)./  
  print $out4 "$_";
};