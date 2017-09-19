     use Encode; 
     use ZHOUYI::ZhanBu;
    my ( $gnum, $bgnum, $byao, $bgua ) = qigua();
   print Encode::encode("utf8",jiegua( $gnum, $bgnum, $byao, $bgua ));
