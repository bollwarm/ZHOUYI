package ZHOUYI;

require Exporter;
use utf8;
use open ":encoding(utf8)";
use strict;
use warnings;

our @ISA     = qw(Exporter);
our @EXPORT  = qw(ZhouyiEx ZYindex outGua sixyao outtuan outxiang);

=head1 NAME

ZHOUYI - The ZHOUYI is module interpreter and outer the Chinese ancient 
philosophy of The Book of Change(易经);

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use ZHOUYI;

    my ( $num1, $mum2 )=@ARGV;
    my $foo = ZhouyiEx( ZYindex( $mum2, $num1 ), 'ZhouYi') ;
    print $foo;

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=cut

sub ZYindex {
    my ( $wgua, $ngua ) = @_;
    $wgua %= 8;
    $ngua %= 8;
    my ( @index, @bgindex, @num, %qiankun );

    @index = qw(di tian ze huo lei feng shui shan);
    @bgindex =
      qw(tian_tian tian_ze tian_huo tian_lei tian_feng tian_shui tian_shan tian_di ze_tian ze_ze ze_huo ze_lei ze_feng ze_shui ze_shan ze_di huo_tian huo_ze huo_huo huo_lei huo_feng huo_shui huo_shan huo_di lei_tian lei_ze lei_huo lei_lei lei_feng lei_shui lei_shan lei_di feng_tian feng_ze feng_huo feng_lei feng_feng feng_shui feng_shan feng_di shui_tian shui_ze shui_huo shui_lei shui_feng shui_shui shui_shan shui_di shan_tian shan_ze shan_huo shan_lei shan_feng shan_shui shan_shan shan_di di_tian di_ze di_huo di_lei di_feng di_shui di_shan di_di);
    @num =
      qw(1 10 13 25 44 6 33 12 43 58  49 17 28 47 31 45 14 38 30 21 50 64 56 35 34 54 55 51 32 40 62 16 9 61 37 42 57 59 53 20 5 60 63 3 48 29 39 8 26 41 21 27 18 4 52 23 11 19 36 24 46 7 15 2);

    my $mindex = $index[$wgua] . "_" . $index[$ngua];
    @qiankun{@bgindex} = @num;
    return $qiankun{$mindex};
}

sub ZhouyiEx {
    my ( @line, $msg );
    my ( $n, $file ) = @_;
    open my $FD, '<', $file or die "Can't open /'$file/': $!";
    {
        local $/ = "";
        for (<$FD>) {
            @line = split /^\s+$/sm;
        }
    }
    my $i;
    for (@line) {
        $i++;
        $msg .= "$_\n" if $i == 2 * $n;
        $msg .= "$_\n" if $i == 2 * $n + 1;
    }
    return $msg;

}

sub outGua {
    my $msg     = shift;
    my @guatext = split /\n/sm, $msg;
    my $omsg.=$guatext[1]."\n\n".$guatext[4]."\n\n";
    return $omsg;
}

sub sixyao {
    my $msg = shift;
    my @guatext = split /\n/sm, $msg;
    my $omsg;
    $omsg .=outGua($msg);
    for (@guatext) {
        next if /^$/;
        next unless  /^(初|六|九|上|用).：/;
        $omsg .= $_."\n";
    }
    return $omsg;
}

sub outtuan {

    my $msg = shift;
    my @guatext = split /\n/sm, $msg;
    my $omsg;
    $omsg .=outGua($msg);
    for (@guatext) {
        next if /^$/;
        next unless /《彖》/;
        $omsg .= $_."\n";
    }
    return $omsg;

}

sub outxiang {
    my $msg = shift;
    my @guatext = split /\n/sm, $msg;
    my $omsg;
    $omsg .=outGua($msg);
    for (@guatext) {
        next if /^$/;
        next unless /《象》/;
        $omsg .= $_."\n";
    }
    return $omsg;

}
=head1 AUTHOR

orange, C<< <linzhe at ijz.me> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-zhouyi at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=ZHOUYI>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc ZHOUYI


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=ZHOUYI>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/ZHOUYI>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/ZHOUYI>

=item * Search CPAN

L<http://search.cpan.org/dist/ZHOUYI/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016 orange.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of ZHOUYI
