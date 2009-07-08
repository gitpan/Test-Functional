use strict;
use warnings;
use Module::Build;

# For the record, I'm not really sure what versions of any of these modules are
# required. I'm pretty sure this won't work with Perl 4. I'm not sure which
# Perl 5 is the minimum (if any); I haven't tested with perls under 5.8, but I
# bet 5.6 is fine.

my $builder = Module::Build->new(
    module_name         => 'Test::Functional',
    license             => 'perl',
    dist_author         => 'Erik Osheim <erik@osheim.org>',
    dist_version_from   => 'lib/Test/Functional.pm',
    build_requires      => {
        'Test::More'    => 0,
    },
    requires            => {
        'perl'          => '5.0.0',
        'Data::Compare' => 0,
        'Scalar::Quote' => 0,
        'Test::Builder' => 0,
        'Test::More'    => 0,
    },
    add_to_cleanup      => [ 'Test-Functional-*' ],
    create_makefile_pl  => 'traditional',
    create_readme       => 1,
);

$builder->create_build_script();
