package Indexing::Schema::ResultSetBase;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub all_as_arr_ref { [ map { $_ } $_[0]->all ] }

1;
