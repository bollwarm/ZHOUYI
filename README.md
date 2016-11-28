##介绍

周易解析和规范输出，输出两个数字（下卦和上卦）对应解析到周易中的一卦，
并分部分输出主卦，六爻，彖辞，象传部分。可以来进行初步卦卜。

##安装及使用

具体使用方法，见example
先安装模块，然后

    use ZHOUYI;
    use utf8
    binmode STDOUT, ":utf8";

    my ( $num1, $mum2 )=@ARGV;
    
    my $reply = ZhouyiEx( ZYindex( $mum2, $num1 ));
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

保存为zypm.pl

    perl zypm.pl 2 25

##结果展示

###输出：

    《易經》第十卦履天澤履乾上兌下

     履，履虎尾，不咥人，亨。


###===六爻==

     《易經》第十卦履天澤履乾上兌下
     
     履，履虎尾，不咥人，亨。
     
     初九：素履往，無咎。
     九二：履道坦坦，幽人貞吉。
     六三：眇能視，跛能履，履虎尾，咥人，凶。武人為于大君。
     九四：履虎尾，愬愬，終吉。
     九五：夬履，貞厲。
     上九：視履考祥，其旋元吉。

###===彖辞==
    
    《易經》第十卦履天澤履乾上兌下
    
    履，履虎尾，不咥人，亨。
    
    《彖》曰：履，柔履剛也。說而應乎乾，是以「履虎尾，不咥人，亨」。剛中正，履帝位而不疚，光明也。

###===象传==
    
    《易經》第十卦履天澤履乾上兌下
    
    履，履虎尾，不咥人，亨。
    
    《象》曰：上天下澤，履。君子以辨上下、定民志。
    《象》曰：素履之往，獨行愿也。
    《象》曰：「幽人貞吉」，中不自亂也。
    《象》曰：「眇能視」，不足以有明也。「跛能履」，不足以與行也。咥人之凶，位不當也。「武人為于大君」，志剛也。
    《象》曰：「愬愬，終吉」，志行也。
    《象》曰：「夬履，貞厲」，位正當也。
    《象》曰：元吉在上，大有慶也

