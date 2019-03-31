#!/usr/bin/perl
#############################################################
# @package ADMIN HUNTER - PERL                         #
# @author Ahmad Ishaq <ahmad.ishaq15@gmail.com>   #
# @license GPLV3.0                                          #
# @copyright 2019 StalkersSecurity                          #
# @link https://stalkers.pk                                 #
#############################################################

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;
use Win32::Console;
use Term::ANSIColor;
use Win32::Console::ANSI;
use LWP::Simple;

system('title ADMIN HUNTER');
$SIG{'INT'} = sub
{
   print color("red"),"Programme Terminated!\n",color("reset");
   exit;
};

#Reads and display ascii art from file
print color("bold red");
print "\n";
open(my $fh, "logo.txt") or die("Can't open ascii.txt");
while(my $line = <$fh>) {
    print "\t\t\t".$line;
}
print color("reset");
close $fh;
print "\n\n\n";
#----------------------------------------

#Regex to identify admin page
my $regex = qr/type=(\"|\')password(\"|\')/ip;
#----------------------------------------

#Url input and its formatting
print color("bold blue"),"Enter ",color("bold red"),"target",color("bold blue")," website ",color("bold red"),"URL",color("bold blue")," [url.com/path] or [url.com] : ",color("reset");
my $url=<>;
chomp $url;
if ( $url !~ /^http:/ ) {
$url = 'http://' . $url;
}
if ( $url !~ /\/$/ ) {
$url = $url . '/';
}
#----------------------------------------

#Checking if URL exists
print color("green"), "[+]",color("bold blue"),"Checking if url Exists ";
if (head($url)) {
  print color("green"),"[OK]\n",color("reset");
} else {
  print color("red"),"[NOT]\n",color("reset");
  exit;
}
#----------------------------------------

#Basic Menu
print "\n";
print color("bold red"),"----->",color("bold blue"),"1. asp\n",
color("bold red"),"----->",color("bold blue"),"2. aspx\n",color("bold red"),"----->",color("bold blue"),"3. php\n",color("bold red"),"----->",
color("bold blue"),"4. js\n",color("bold red"),"----->",color("bold blue"),"5. cgi\n",color("bold red"),
"----->",color("bold blue"),"6. brf\n",color("bold red"),"----->",color("bold blue"),"7. cfm\n\n";
print color("bold blue"),"Enter ",color("bold red"),"source ",color("bold blue"),": ",color("reset");
my $option=<STDIN>;
chomp($option);
print "\n";
print color("bold red"),"-----> ",color("bold red"),"Target: ",color("bold blue"),"$url\n",color("reset");
print color("bold red"),"-----> ",color("bold blue"),"Site ",color("bold red"),"source ",color("bold blue"),"code: $option\n",color("reset");
print color("bold red"),"-----> ",color("bold blue"),"Searching ",color("bold red"),"admin cp...\n\n\n",color("reset");
#----------------------------------------

#Function that loads and tests them against the target
  sub admin_search {
    my ($list) = @_;
    open my $handle, '<', $list;
    chomp(my @lines = <$handle>);
    close $handle;
  foreach my $ways(@lines)
   {
    my $final = $url.$ways;
    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    my $request = HTTP::Request->new(GET => $final);
    my $response = $ua->request($request);
    if($response->content =~ $regex)
    {
      print color("green"),"[+]",color("bold blue"),"Found ->",color("green")," $final\n";
    }
    else
    {
      print color("bold red"),"[-] ",color("bold blue"),"Not Found -> ",color("bold red"),"$final\n";
    }
   }
    }
#----------------------------------------

#Simple code to test target against given source
if($option eq "1")
{
  my $asp_list = "asp.txt";
  admin_search($asp_list);
}
elsif($option eq "2")
{
  my $aspx_list = "aspx.txt";
  admin_search($aspx_list);
}
elsif($option eq "3")
{
  my $php_list = "php.txt";
  admin_search($php_list);
}
elsif($option eq "4")
{
  my $js_list = "js.txt";
  admin_search($js_list);
}
elsif($option eq "5")
{
  my $cgi_list = "cgi.txt";
  admin_search($cgi_list);
}
elsif($option eq "6")
{
  my $brf_list = "brf.txt";
  admin_search($brf_list);
}
elsif($option eq "7")
{
  my $cfm_list = "cfm.txt";
  admin_search($cfm_list);
}
else
{
  print "Invalid option\n";
  exit;
}
#----------------------------------------

print color("bold blue"),"Wordlist ended press Enter to exit \n",color("reset");
<>;
