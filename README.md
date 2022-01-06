

## 介绍

周易解析和规范输出，输出两个数字（下卦和上卦）对应解析到周易中的一卦，
并分部分输出主卦，六爻，彖辞，象传部分。可以来进行初步卦卜。

## 安装及使用

具体使用方法，见example
先安装模块，然后

    use ZHOUYI;
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

#### 结果展示

#### the outer like :

    《易經》第十卦履天澤履乾上兌下

     履，履虎尾，不咥人，亨。


### ===六爻==

     《易經》第十卦履天澤履乾上兌下
     
     履，履虎尾，不咥人，亨。
     
     初九：素履往，無咎。
     九二：履道坦坦，幽人貞吉。
     六三：眇能視，跛能履，履虎尾，咥人，凶。武人為于大君。
     九四：履虎尾，愬愬，終吉。
     九五：夬履，貞厲。
     上九：視履考祥，其旋元吉。

### ===彖辞==
    
    《易經》第十卦履天澤履乾上兌下
    
    履，履虎尾，不咥人，亨。
    
    《彖》曰：履，柔履剛也。說而應乎乾，是以「履虎尾，不咥人，亨」。剛中正，履帝位而不疚，光明也。

### ===象传==
    
    《易經》第十卦履天澤履乾上兌下
    
      履，履虎尾，不咥人，亨。
    
    《象》曰：上天下澤，履。君子以辨上下、定民志。
    《象》曰：素履之往，獨行愿也。
    《象》曰：「幽人貞吉」，中不自亂也。
    《象》曰：「眇能視」，不足以有明也。「跛能履」，不足以與行也。咥人之凶，位不當也。「武人為于大君」，志剛也。
    《象》曰：「愬愬，終吉」，志行也。
    《象》曰：「夬履，貞厲」，位正當也。
    《象》曰：元吉在上，大有慶也

### ZHOUYI-ZhanBu
 
ZHUYI::ZhanBu (周易占卜) - A util of ZHOUYI modules，divination to judge for the future using YI's Gua(卦) or tuan（彖）info!


 
      use ZHOUYI::ZhanBu;
     
      my ( $gnum, $bgnum, $byao, $bgua ) = qigua();
      print  jiegua( $gnum, $bgnum, $byao, $bgua )
      ...

#### 结果展示

#### the outer like :

      卦：《易經》第三十二卦恆雷風恆震上巽下

      恆，亨，無咎，利貞，利有攸往。

    《彖》曰：恆，久也。剛上而柔下，雷風相與，巽而動，剛柔皆應，恆。「恆，亨，無咎，利貞」，久於其道也，天地之道，恆久而不已也。「利有攸往」，終則有始也。日月得天而能久照，四時變化而能久成，聖人久於其道而天下化成。觀其所恆，而天地萬物之情可見矣！
    《象》曰：雷風，恆。君子以立不易方。

     爻：六五：恆其德，貞婦人吉，夫子凶。
    《象》曰：婦人貞吉，從一而終也。夫子制義，從婦凶也
 
##### You can using in oneline as you like:

     $perl -MZHOUYI::ZhanBu  -e 'print jiegua(qigua())'
    
 #or just use:  
    
     $perl -MZHOUYI::ZhanBu -e 'print pu()'

### 利用Mojo::webqq插件形式交互式占卜。

####  Using this plugin I Successful predicted the United States election。

    插件example/Pu.pm（关于Mojo::webqq详见 https://github.com/sjdy521/Mojo-Webqq）

   ![成功预测美帝大选](example/zhanbu.jpg)

  
   如上图图显示预测提前两天预测到美国大选明主党候选人：
    
    九四。鼎折足，覆公餗，其形渥，凶。

    象曰：覆公餗，信如何也。
    
  北宋易学家邵雍解：

    凶：得此爻者，多灾之时，或生足疾。做官的有被贬职之忧。

  结果非常靠谱。

## Git repo
 
  [Github](http://github.com/bollwarm/ZHOUYI)
  
  [oschina](https://git.oschina.net/ijz/ZHOUYI)
 
## AUTHOR
 
    [orange](bollwarm@ijz.me), [虫虫之家Blog](http://ijz.me)

## COPYRIGHT AND LICEE
 
Copyright (C) 2016 桔子
 
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

