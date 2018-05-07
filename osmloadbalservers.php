<?php
function cidr_match($ip, $cidr)
{
    list($subnet, $mask) = explode('/', $cidr);

    if ((ip2long($ip) & ~((1 << (32 - $mask)) - 1) ) == ip2long($subnet))
    { 
        return true;
    }

    return false;
}


if (cidr_match($_SERVER['REMOTE_ADDR'], '44.0.0.0/8')) {
  echo "db0sda.ampr.org/osm\n";
  echo "search.ampr.org/osm\n";
  echo "karten.ampr.org/osm\n";
  echo "srv.db0ii.ampr.org/osm\n";
} else {
  echo "a.tile.openstreetmap.org\n";
  echo "b.tile.openstreetmap.org\n";
  echo "c.tile.openstreetmap.org\n";
}

?>


