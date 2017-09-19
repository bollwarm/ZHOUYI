use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'ZHOUYI',
    AUTHOR           => q{orange <linzhe@ijz.me>},
    VERSION_FROM     => 'lib/ZHOUYI.pm',
    ABSTRACT_FROM    => 'lib/ZHOUYI.pm',
    LICENSE          => 'Perl',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
     META_MERGE => {
          'meta-spec' => { version => 2 },
           resources   => {
            repository => {
                type => 'git',
                url  => 'https://github.com/bollwarm/ZHOUYI',
                web  => 'http://ijz.me',
            },
        },
},
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'ZHOUYI-*' },
);
