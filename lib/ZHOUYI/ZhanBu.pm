package ZHOUYI::ZhanBu;

use strict;
use warnings;
use ZHOUYI;
use utf8;

our @ISA    = qw(Exporter);
our @EXPORT = qw(pu qigua jiegua );

=encoding utf8

=head1 NAME

ZHOUYI::ZhanBu - A util of ZHOUYI modules，divination to judge for the future using YI's Gua(卦) or tuan（彖）info (周易占卜)!

=head1 VERSION

Version 0.09

=cut

our $VERSION = '0.09';

=head1 SYNOPSIS


use ZHOUYI::ZhanBu;

my ( $gnum, $bgnum, $byao, $bgua ) = qigua();
print jiegua( $gnum, $bgnum, $byao, $bgua )
    ...

the outer like :

《易經》第九卦小畜風天小畜巽上乾下

小畜，亨。密云不雨，自我西郊。


九五：有孚攣如，富以其鄰。



=cut

# the main outing function.

sub pu {
  return jiegua( qigua() );

}

sub bugaindex {
    my ( @yigua, %yi, %zy, @bagua, @bagua1 );

    @bagua  = qw(kun zhen kan dui gen li xun qian);
    @bagua1 = qw(di lei shui ze shan huo feng tian);
    my @bgindex =
      qw(tian_tian tian_ze tian_huo tian_lei tian_feng tian_shui tian_shan tian_di ze_tian ze_ze ze_huo ze_lei ze_feng ze_shui ze_shan ze_di huo_tian huo_ze huo_huo huo_lei huo_feng huo_shui huo_shan huo_di lei_tian lei_ze lei_huo lei_lei lei_feng lei_shui lei_shan lei_di feng_tian feng_ze feng_huo feng_lei feng_feng feng_shui feng_shan feng_di shui_tian shui_ze shui_huo shui_lei shui_feng shui_shui shui_shan shui_di shan_tian shan_ze shan_huo shan_lei shan_feng shan_shui shan_shan shan_di di_tian di_ze di_huo di_lei di_feng di_shui di_shan di_di);
    my @num =
      qw(1 10 13 25 44 6 33 12 43 58  49 17 28 47 31 45 14 38 30 21 50 64 56 35 34 54 55 51 32 40 62 16 9 61 37 42 57 59 53 20 5 60 63 3 48 29 39 8 26 41 21 27 18 4 52 23 11 19 36 24 46 7 15 2);

    @zy{@bgindex} = @num;
    for ( 0 .. 63 ) {

        my $zindexs = sprintf( "%lo", $_ );
        push @yigua, $zindexs;
    }

    for (@yigua) {

        if (/^\d$/) {

            #print $_,"\n";
            $yi{$_} = $bagua1[0] . "_" . $bagua1[$_];

        }
        else {
            my ( $q, $k ) = split //, $_;
            $yi{$_} = $bagua1[$q] . "_" . $bagua1[$k];
        }

    }

    return ( \%zy, \%yi );
}

=pod

=head1 Explanations for Gua(解卦)

the explanations functions - input the guanum and it's 
changs trend from the yao's yinyang.

using old explinations of Zhuyi (明.朱熹 《易学启蒙》解卦)

 六爻不变，以本卦卦辞断；
 一爻变，以本卦变爻爻辞断；
 两爻变，以本卦两个爻辞断，但以上者为主；
 三爻变，以本卦与变卦卦辞断；本卦为贞（体），变卦为悔（用）；
 四爻变，以变卦之两不变爻爻辞断，但以下者为主；
 五爻变，以变卦之不变爻爻辞断；
 六爻变，以变卦之卦辞断，乾坤两卦则以「用」辞断。

=cut

sub jiegua {

    my ( $ogua, $bgua, $myao, $mguo ) = @_;
    my $int = $mguo ? $ogua : $bgua;
    my $msg;
    if  ($myao eq 'B'){
        
         $msg=zhanbu( $ogua, -1 ); 
         $msg.="变";
         $msg.=zhanbu( $bgua, -1 );

      }elsif($myao eq 'C') {
              
        ( $ogua == 0 )or ( $ogua == 63 )
              ? ($msg=zhanbu( $ogua, 6 ))
              : ($msg=zhanbu( $ogua, -1 ))

      }elsif($myao eq 'U') {
      
        $msg=zhanbu( $ogua, -1 ) 
     
     }else {
      
        $msg=zhanbu( $int,  $myao );
     
     } 
   return $msg;
}

sub zhanbu {
    my ( $zy,  $yi )   = bugaindex();
    my ( $gua, $myao ) = @_;
    my $sint   = sprintf( "%lo", $gua );
    my $reply  = ZhouyiEx( $zy->{ $yi->{$sint} } );
    my $reply1 = outtuan($reply);
    my ( $replyyao, $syao ) = maixyao( $reply, $myao );
    my ( $replyxiang, $sxiang ) = maixiang( $reply, $myao ); 
       $reply1.=$sxiang->[0];
    my $wydsg;
          
        if($myao == -1) {

         $wydsg="卦：".$reply1. "\n\n";       
 
        }elsif($myao == 6 ) {
         $wydsg= "爻：".$syao->[6]."\n".$sxiang->[7];
        }else {
         $wydsg= "卦：". $reply1. "\n\n";
         $wydsg.= "爻：".$replyyao."\n".$replyxiang."\n";
        }
   return $wydsg;

}

sub qigua {
    my $znum = initzhishu();
#    printbg( sumyingyan($znum) );
    my ( $gbnum, $gnum ) = sumgua( sumyingyan($znum) );
    my ( $bgnum, $byao, $bgua ) = biangua( sumyingyan($znum) );
    return ( $gnum, $bgnum, $byao, $bgua );
}

sub initzhishu {
    my @shishu;
    srand(time);
    for ( 0 .. 5 ) {
        my $int = int( rand(4) + 6 );
        push @shishu, $int;
    }
    return \@shishu;
}

sub sumyingyan {

    my ( %ying, %yang, %bianyao );
    my $shishu = shift;

    for ( 0 .. 5 ) {
        my $num = $shishu->[$_];

        #print $num,"\n";

        $ying{$_}    = 1 if ( $num % 6 == 0 ) || ( $num % 6 == 2 );
        $yang{$_}    = 1 if ( $num % 6 == 1 ) || ( $num % 6 == 3 );
        $bianyao{$_} = 1 if ( $num % 6 == 0 ) || ( $num % 6 == 3 );

    }
    return ( \%ying, \%yang, \%bianyao );

}

sub sumgua {

    my ( $ying, $yang, $bianyao ) = @_;
    my $yinum;
    my $n = 5;
    for ( 0 .. 5 ) {
        $n = 5 - $_;
        $yinum .= "1" if exists $yang->{$n};
        $yinum .= "0" if exists $ying->{$n};

    }

    #print $yinum,"\n";

    my $byinnum = '0b' . $yinum;
    my $dec     = oct $byinnum;

    #print $dec,"\n";
    return ( $yinum, $dec );

}

sub biangua {

    my ( $ying, $yang, $bianyao ) = @_;
    my ( $gnum, $num ) = sumgua( $ying, $yang, $bianyao );
    my @bnum = split //, $gnum;
#    print "@bnum", "\n";

    for ( 0 .. 5 ) {

        $bnum[$_] = $bnum[$_] ? 0 : 1 if exists $bianyao->{$_};

    }

    my %dingyao;

    for ( 0 .. 5 ) {
        next if exists $bianyao->{$_};
        $dingyao{$_} = 1;
    }
    my ( $maiyao, $maigua );

    my @by = sort keys %{$bianyao};
    my @dy = sort keys %dingyao;
#    print "by : @by", "\n";
#    print "dy : @dy", "\n";

    my $bunum=scalar @by;

    if($bunum == 1){$maiyao = $by[0]; $maigua = 1}
    elsif($bunum == 2){ $maiyao = $by[1]; $maigua = 1 }
    elsif($bunum == 3){ $maiyao = "B";    $maigua = 1 }
    elsif($bunum == 4){ $maiyao = $dy[0]; $maigua = 0 }
    elsif($bunum == 5){ $maiyao = $dy[0]; $maigua = 0 }
    elsif($bunum == 6){ $maiyao = "C";    $maigua = 0 }
    else {$maiyao = "U";    $maigua = 1 }

#    print "Yaobian:", $maiyao, "\n";
#    print "Guabian:", $maigua, "\n";
#    print "@bnum",    "\n";
    my $bnum = join '', @bnum;

    #print $bnum,"\n";
#    printgua($bnum);
    my $bbnum = '0b' . $bnum;
    my $dec   = oct $bbnum;

    #print $dec,"\n";
    return ( $dec, $maiyao, $maigua );

}

sub printgua {

    my $ying = shift;
    my @bnum = split //, $ying;

    #print "@bnum","\n";
    my $n = 5;
    for ( 0 .. 5 ) {
        $n = 5 - $_;
        $bnum[$_] ? ( print $n+ 1, ":— —\n" ) : ( print $n+ 1, ":—--\n" );
    }

}

sub printbg {

    my ( $ying, $yang, $bianyao ) = @_;
    my $m = 5;
    for ( 0 .. 5 ) {
        $m = 5 - $_;
        print $m+ 1, ":—-—\n" if exists $yang->{$m};
        print $m+ 1, ":— -\n"   if exists $ying->{$m};

    }
    print "\n";
    $m = 5;
    for ( 0 .. 5 ) {
        $m = 5 - $_;
        print $m+ 1, ":变爻\n" if exists $bianyao->{$m};

    }

    print "\n\n";
}

=head1 AUTHOR

ORANGE, C<< <bollwarm at ijz.me> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-zhouyi-zhanpu at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ZHOUYI-ZhanBu>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ZHOUYI::ZhanBu


You can also look for information at:

=head1 Git repo

Lhttps://github.com/bollwarm/ZHOUYI-ZhanBu

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ZHOUYI-ZhanBu>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ZHOUYI-ZhanBu>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ZHOUYI-ZhanBu>

=item * Search CPAN

L<http://search.cpan.org/dist/ZHOUYI-ZhanBu/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016 ORANGE.


This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

1;    # End of ZHOUYI::ZhanBu
