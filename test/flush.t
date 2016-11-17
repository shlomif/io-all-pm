use strict; use warnings;
use lib -e 't' ? 't' : 'test';
use Test::More;
use IO::All;
use IO_All_Test;

plan((lc($^O) eq 'mswin32' and defined $ENV{PERL5_CPANPLUS_IS_RUNNING})
    ? (skip_all => "CPANPLUS/MSWin32 breaks this")
    : ($] < 5.008003)
      ? (skip_all => 'Broken on older perls')
      : (tests => 1)
);

{
    my $o = io->file(o_dir() . "/flush.txt");
    $o->print("TestString")->flush;

    # TEST
    is (scalar ( _slurp(o_dir() . "/flush.txt") ), "TestString", "flush is Ok.");
}

sub _slurp
{
    my $filename = shift;

    open my $in, "<", $filename
        or die "Cannot open '$filename' for slurping - $!";

    local $/;
    my $contents = <$in>;

    close($in);

    return $contents;
}

del_output_dir();
