#!/usr/bin/perl -w
# DUNDi Crawler von Ralf Wilke DH3WR
# Version 0.21
# Lizenz:  CC BY-NC-SA http://creativecommons.org/licenses/by-nc-sa/3.0/

no warnings;

#use strict;
use LWP::UserAgent;
use DBI;
use Data::Dumper;
use Socket;

my @asteriskhosts;
my @dundipeers;
my @contacts;

$mysqlhost = "db0sda.ampr.org";
$mysqldatabase = "hamnetdb";
$mysqluser = "dundicrawler";
$mysqlpw = "dundipass";

sub addHost {
	my $myname = $_[0];
	my $myip = $_[1];
	my $mysite = $_[2];

	foreach (@asteriskhosts)
	{
		if ($_->{ip} eq $myip) {
#			print "Host mit dieser IP schon in der Liste der Hosts: $myip\n";
			return;
		}
	}
	# Versuche, aus der hamnetdb den Namen und Site zur IP-Adresse zu finden.
	my $myquery = $dbh->prepare("SELECT name, site FROM hamnetdb.hamnet_host where ip = \"$myip\";");
	$myquery->execute() or die $query->err_str;

	# Hole Name und Site von gesuchter IP-Adresse
	while (my ($sqlname, $sqlsite) = $myquery->fetchrow_array() ) {
		$myname = $sqlname;
		$mysite = $sqlsite;
		last;
	}
#	print "ip: $myip, name: $myname, site: $mysite\n";
	push @asteriskhosts, {"name" => $myname, "ip" => $myip, "site" => $mysite, "status" => 'unprocessed'};

}


sub addDundiPeer {

	my $origin_ip = $_[0];
	my $peer_ip = $_[1];
	my $peer_MAC = $_[2];
	my $peer_Port = $_[3];
	my $peer_Status = $_[4];
	my $peer_Time = $_[5];

	foreach (@dundipeers) {
		if ((($_->{origin_ip} eq $origin_ip) && ($_->{peer_ip} eq $peer_ip)) || 
		   (($_->{origin_ip} eq $peer_ip) && ($_->{peer_ip} eq $origin_ip))) {
#			print "Eintrag schon da: Origin $origin_ip, Peer $peer_ip\n";
			return;
		}
	}
	push @dundipeers, {"origin_ip" => $origin_ip, "peer_ip" => $peer_ip, "peer_MAC" => $peer_MAC, "peer_Port" => $peer_Port, "peer_Status" => $peer_Status, "peer_Time" => $peer_Time};
}


sub printAsteriskHosts
{
	print "\nAsterisk Hosts:\n";
	foreach my $host (@asteriskhosts) {
		print Dumper($host);
	}
	print "------------------------\n";
}

sub printAsteriskHostsLocation
{
	print "\nAsterisk Hosts:\n";
	foreach my $host (@asteriskhosts) {
		print "$host->{name} $host->{ip} ";
		if ($host->{position_ok} eq "true") {
			print "$host->{long} $host->{lat}\n";
		} else {
			print "Keine Position bekannt \n";
		}
	}
	print "------------------------\n";
}



sub printDundiPeers
{
	print "\nDundi Peers:\n";
	foreach my $peer (@dundipeers) {
		print Dumper($peer);
	}
	print "------------------------\n";
}

sub ProcessAsteriskHostContact {
  my $ip = $_[0];
  my $name = $_[1];
  my $url = '';
  if ($name eq 'unknown') {
  	$url = "http://" . $ip . "/dundi.info";
  } else {
  	$url = "http://" . $name . ".ampr.org" . "/dundi.info";
  }
#  print "$url\n";
  my $hostnumber = $_[2];

  my $website_content;

  my $ua = LWP::UserAgent->new;
  $ua->agent('DundiCrawler/0.21 by Ralf Wilke DH3WR');
  $ua->timeout(1);
  $ua->protocols_allowed( ['http'] );

  my $response = $ua->get($url);
 
  if ($response->is_success) {
    $website_content = $response->decoded_content;
#    print $website_content;  # or whatever
    my @lines = split /\n/, $website_content;

    foreach my $line (@lines) {
      if (substr($line,0,1) eq "#") { next; }

#      print "$line\n";
      my @values = split ';', $line;
      my $contactCallsign = $values[0];
      my $contactIP = $values[1];
      my $contactMAC = $values[2];
      my $contactRealName = $values[3];
      my $contactSysopCall = $values[4];
      my $contactEmail = $values[5];
      push @contacts, {"callsign" => $contactCallsign, "IP" => $contactIP, "MAC" => $contactMAC, "realname" => $contactRealName, "sysopcall" => $contactSysopCall, "email" => $contactEmail};
     last;
    }	
  }
}

sub ProcessAsteriskHost {
  my $ip = $_[0];
  my $name = $_[1];
  my $url = '';
  if ($name eq 'unknown') {
  	$url = "http://" . $ip . "/dundi_show_peers.info";
  } else {
  	$url = "http://" . $name . ".ampr.org" . "/dundi_show_peers.info";
  }
#  print "$url\n";
  my $hostnumber = $_[2];

  my $website_content;

  my $ua = LWP::UserAgent->new;
  $ua->agent('DundiCrawler/0.20 by Ralf Wilke DH3WR');
  $ua->timeout(1);
  $ua->protocols_allowed( ['http'] );

  my $response = $ua->get($url);
 
  if ($response->is_success) {
    $website_content = $response->decoded_content;
#   print $website_content;  # or whatever
    my @lines = split /\n/, $website_content;

    foreach my $line (@lines) {
      if (index($line,"EID") != -1) { next; }
      if (index($line,"dundi peers") != -1) { next; }
#      print $line;
      my @values = split ' ', $line;
      my $dundiMAC = $values[0];
      my $dundiIP = $values[1];
      my $dundiPort = $values[3];
      my $dundiStatus = $values[6];
      my $dundiPeerTime = "-1";
      if ($dundiStatus eq "OK") { 
        $dundiPeerTime = $values[7];
        $dundiPeerTime = substr($dundiPeerTime,1,length($dundiPeerTime)-1);
      }
	addDundiPeer($ip, $dundiIP, $dundiMAC, $dundiPort, $dundiStatus, $dundiPeerTime);
	addHost('unknown', $dundiIP, 'unknown');
	
#      print $dundiStatus;

#      last;
    }
  }
    $asteriskhosts[$hostnumber]->{status} = $response->code();
}

sub GetHostsfromHamnetDB {
	# Get Asterisk Hosts form HamnetDB
	$query = $dbh->prepare('SELECT name, ip, site FROM hamnetdb.hamnet_host where comment like "%asterisk_dundi%";');
	$query->execute() or die $query->err_str;

	# Hole alle Asterisk-Hosts aus der HamnetDB und füge sie ins Array ein 
	while (my ($name, $ip, $site) = $query->fetchrow_array() ) {
		# push @asteriskhosts, {"name" => $name, "ip" => $ip, "site" => $site};
		addHost($name, $ip, $site, 'unprocessed');
	}
}

sub WriteMapOverlay {

	# Open output file for JavaScript output

	my $filename = '/srv/dundicrawler/dundicrawlerresults.js';
	open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

	# Write function header and static content
	print $fh "function showDundiCrawlerResult(map)\n";
	print $fh "{\n";
	print $fh "\tvar DundiIconOffline = L.icon({\n";
	print $fh "\t  iconUrl: 'site-red.png',\n";
	print $fh "    iconSize: [19, 25]\n";
	print $fh "\t});\n\n";
	print $fh "\tvar DundiIconOnline = L.icon({\n";
	print $fh "\t  iconUrl: 'site-green.png',\n";
	print $fh "    iconSize: [19, 25]\n";
	print $fh "\t});\n\n";

	# Go through known host
	foreach (@asteriskhosts) {

		# If location is known, draw on map
		if ($_->{position_ok} eq "true") {
			print $fh "\tL.marker([$_->{lat}, $_->{long}], {icon: ";

			# Depending on line status, draw red or green icon
			if ($_->{status} eq "200") {
				print $fh "DundiIconOnline";
			} else {
				print $fh "DundiIconOffline";
			}
			print $fh "}).addTo(map)\n";

			# Show site info
			print $fh "\t  .bindPopup('";
			my $site_upperCase = uc $_->{site};
			print $fh "Site: <b><a href=\"http://hamnetdb.net/?q=$_->{ip}\" target=\"_blank\">$site_upperCase</a></b> ";
			print $fh "IP: $_->{ip} ";
			print $fh "DNS: $_->{name}.ampr.org<br />";

			# Show Peer Status, find correponding peers
			print $fh "<table><tr><th>IP</th><th>Port</th><th>Status</th><th>Time(ms)</th><th>Site</th></tr>";
			my $hostip = $_->{ip};
			foreach (@dundipeers) {
				my $peer_ip = "";
				if ($_->{origin_ip} eq $hostip)
				{
					$peer_ip = $_->{peer_ip};
				}
				elsif ($_->{peer_ip} eq $hostip)
				{
					$peer_ip = $_->{origin_ip};
				}
				else
				{
					next;
				}

#				my $MACuc = uc $_->{peer_MAC};
				
				print $fh "<tr><td style=\"text-align:left\">$peer_ip</td><td style=\"text-align:right\">$_->{peer_Port}</td><td style=\"text-align:center\">";

				# Style font color depending on status
				if ($_->{peer_Status} eq "OK")
				{
					print $fh "<font color=\"#01DF01\">$_->{peer_Status}</font>";
				}
				else
				{
					print $fh "<font color=\"red\">$_->{peer_Status}</font>";
				}

				print $fh "</td><td style=\"text-align:right\">";
				
				# If time is less than zero, display - instead of -1 or similar
				if ($_->{peer_Time} < 0)
				{
					print $fh "-";
				}
				else
				{
					print $fh "$_->{peer_Time}";
				}
				print $fh "</td>";

				foreach (@asteriskhosts) {
					if ($_->{ip} eq $peer_ip)
					{
						print $fh "</td><td style=\"text-align:right\">";
						print $fh "<a href=\"http://hamnetdb.net/?q=$_->{name}\" target=\"_blank\">$_->{name}.ampr.org</a>";
						print $fh "</td></tr>";
					}
				}


			}
			print $fh "</table>";

			print $fh "', {minWidth: 400});\n";
		}
	}
	print $fh "\n\n";

	# Draw lines between peers
	foreach my $dundipeer (@dundipeers) {
		my $PositionOf2Peers_ok = "false";
		my $lat1 = 0;
		my $long1 = 0;
		my $lat2 = 0;
		my $long2 = 0;
		my $site1 = "";
		my $site2 = "";
		
		# Check if first peer location is known
		foreach my $asteriskhost (@asteriskhosts) {
			if ($dundipeer->{origin_ip} eq $asteriskhost->{ip})
			{
				if ($asteriskhost->{position_ok} eq "true") {
					$PositionOf2Peers_ok = "true";
					$lat1 = $asteriskhost->{lat};
					$long1 = $asteriskhost->{long};
					$site1 = $asteriskhost->{site};
				} else {
					$PositionOf2Peers_ok = "false";
				}
				last;
			}
		}

		# Check if second peer's location is known
		if ($PositionOf2Peers_ok eq "true") {

			foreach my $asteriskhost (@asteriskhosts) {
				if ($dundipeer->{peer_ip} eq $asteriskhost->{ip})
				{
					if ($asteriskhost->{position_ok} eq "true") {
						$PositionOf2Peers_ok = "true";
						$lat2 = $asteriskhost->{lat};
						$long2 = $asteriskhost->{long};
						$site2 = $asteriskhost->{site};
					} else {
						$PositionOf2Peers_ok = "false";
					}
					last;
				}
			}

			# Format example: [50.1, 6.1],[50, 6]
			# Draw line between Dundi peers

			if ($PositionOf2Peers_ok eq "true") {
				print $fh "// Site1: $site1\tSite2: $site2\n";
				print $fh "\tvar mypolyline = new L.Polyline([[$lat1, $long1],[$lat2, $long2]], {\n";
				print $fh "\t\tcolor: ";
				if ($dundipeer->{peer_Status} eq "OK")
				{
					print $fh "'green'";
				} else {
					print $fh "'red'";
				}
				print $fh ",\n\t\tweight: 3,\n\t\topacity: 0.5,\n\t\tsmoothFactor: 1\n";
				print $fh "\t});\n";
				print $fh "\tmypolyline.addTo(map);\n\n";
			}
		}
	}
	print $fh "};\n";
	close $fh;
}

sub WriteTimestampOfLastUpdate {

	# Open output file for timestamp output

	my $filename = '/srv/dundicrawler/lastupdate.txt';
	open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";


	# Print timestamp to file in final output format
	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
	
	printf ($fh "Last Update: %02d.%02d.%04d - %02d:%02d:%02d", $mday, $mon, $year+1900, $hour, $min, $sec);

	close $fh;
}

sub CompleteHostInfo {
	foreach (@asteriskhosts) {
		# Versuche, aus der hamnetdb die Position der Site zu bestimmen
		my $myquery = $dbh->prepare("SELECT longitude, latitude FROM hamnetdb.hamnet_site where callsign = \"$_->{site}\"");
		$myquery->execute() or die $query->err_str;
		
		$_->{position_ok} = "false";
		# Hole Position
		while (my ($mylong, $mylat) = $myquery->fetchrow_array() ) {
			$_->{long} = $mylong;
			$_->{lat} = $mylat;
			$_->{position_ok} = "true";
			last;
		}	
	}
}

sub WriteHostsWithProblems {
	my $filename = '/srv/dundicrawler/hostswithproblems.html';
	open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

	print $fh '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
	print $fh "\n"; print $fh '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de-de" lang="de-de"><html>';
	print $fh "\n"; print $fh '<head>';
	print $fh "\n"; print $fh '<title>DUNDi Netzübersicht - Legende</title>';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/media/jui/css/icomoon.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/templates/system/css/system.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/templates/system/css/general.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/typo.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/addons.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/template-j30.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/layout.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/template.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/usertools.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/css3.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/plugins/system/jat3/jat3/base-themes/default/css/menu/mega.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/templates/business8/css/typo.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/templates/business8/css/template.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/templates/business8/css/menu/mega.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/templates/business8/themes/more_contrast/css/template.css" type="text/css" />';
	print $fh "\n"; print $fh '  <link rel="stylesheet" href="/templates/business8/themes/more_contrast/css/menu/mega.css" type="text/css" />';
	print $fh "</head>\n<body>\n";
	print $fh "<p>Nicht in der <a href=\"http://hamnetdb.net\" target=\"_blank\">hamnetdb</a> eingetragene Hosts, deren Position leider nicht auf der Karte dargestellt werden kann:</p>\n";
	print $fh "<p>Host which are not present in <a href=\"http://hamnetdb.net\" target=\"_blank\">hamnetdb</a> and thus cannot be displayed on the map:</p>\n";


	foreach (@asteriskhosts) {
		if ($_->{position_ok} eq "false") {
			print $fh "<p><b><a href=\"http://hamnetdb.net/?m=as&q=$_->{ip}&as=-All-&tab=&osm=1\" target=\"_blank\">$_->{ip}</a></b></p>\n";
		}
	}
	print $fh "</body>\n</html>\n";


}


# Setup Mysql connection
$dbh = DBI->connect("DBI:mysql:database=$mysqldatabase;host=$mysqlhost;", $mysqluser, $mysqlpw);

GetHostsfromHamnetDB();
#printAsteriskHosts();

# Prozessiere alle bekannten Hosts
$hostnumber = 0;
foreach (@asteriskhosts) {
	ProcessAsteriskHost($_->{ip},$_->{name},$hostnumber);
	ProcessAsteriskHostContact($_->{ip},$_->{name});
	$hostnumber++;
}

CompleteHostInfo();
#printAsteriskHostsLocation();
#printDundiPeers();
#printAsteriskHosts();

#print Dumper @contacts;


WriteMapOverlay();
WriteHostsWithProblems();
WriteTimestampOfLastUpdate();

# Disconnect from the database.
$dbh->disconnect();


# vim:syntax=perl

