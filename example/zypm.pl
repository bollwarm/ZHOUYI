use ZHOUYI;
use utf8
binmode STDOUT, ":utf8";


my ( $num1, $mum2 )=@ARGV;
#print "$num1 $mum2";
my $reply = ZhouyiEx( ZYindex( $mum2, $num1 ), 'YI');
my $reply1=outGua($reply);
my $replyyao=sixyao($reply);
my $replytuan=outtuan($reply);
my $replyxiang=outxiang($reply);


print $reply1,"\n";
print "===六爻==\n\n";
print $replyyao,"\n";
print "===彖辞==\n\n";
print $replytuan,"\n";
print "===象传==\n\n";
print $replyxiang,"\n";

