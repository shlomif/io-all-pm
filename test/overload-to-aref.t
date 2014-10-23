#!/usr/bin/perl

use strict;
use warnings;

# This is a test for:
#
# https://github.com/ingydotnet/io-all-pm/issues/13 .

use Test::More tests => 5;

use IO::All;

use File::Temp qw/ tempfile tempdir /;

my $dir = tempdir( CLEANUP => 1 );

my $fn1 = "$dir/file1.txt";
io->file($fn1)->print("IntoUndef\n");

my $fn2 = "$dir/file2.txt";
io->file($fn2)->print("IntoArrayRef\n");

my $fn3 = "$dir/file3.txt";
io->file($fn3)->print("One\nTwo\nThree\n");

{
    my $s;

    $s < io($fn1);

    # TEST
    is ($s, "IntoUndef\n", "redirect to undef.");

    $s = [];

    $s < io($fn2);

    # TEST
    is_deeply ($s, ["IntoArrayRef\n", ], "\@ < io - redirect to an array ref.");

    $s << io($fn3);

    # TEST
    is_deeply ($s, ["IntoArrayRef\n", "One\n", "Two\n", "Three\n", ],
        "\@ << io - redirect to an array ref.");
}

{
    my $s;

    $s = [];

    io($fn2)>$s;
    # TEST
    is_deeply ($s, ["IntoArrayRef\n", ], "io > \@ - redirect to an array ref.");

    io($fn3) >> $s;

    # TEST
    is_deeply ($s, ["IntoArrayRef\n", "One\n", "Two\n", "Three\n", ],
        "io >> \@ - redirect to an array ref.");
}
