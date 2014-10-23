#!/usr/bin/perl

use strict;
use warnings;

# This is a test for:
#
# https://github.com/ingydotnet/io-all-pm/issues/13 .

use Test::More tests => 2;

use IO::All;

use File::Temp qw/ tempfile tempdir /;

my $dir = tempdir( CLEANUP => 1 );

my $fn1 = "$dir/file1.txt";
io->file($fn1)->print("IntoUndef\n");

my $fn2 = "$dir/file2.txt";
io->file($fn2)->print("IntoArrayRef\n");

my $s;

$s < io($fn1);

# TEST
is ($s, "IntoUndef\n", "redirect to undef.");

$s = [];

$s < io($fn2);

# TEST
is_deeply ($s, ["IntoArrayRef\n", ], "redirect to an array ref.");

