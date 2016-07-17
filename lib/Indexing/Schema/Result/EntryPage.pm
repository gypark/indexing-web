use utf8;
package Indexing::Schema::Result::EntryPage;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Indexing::Schema::Result::EntryPage

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<Indexing::Schema::ResultBase>

=cut

use base 'Indexing::Schema::ResultBase';

=head1 TABLE: C<entry_page>

=cut

__PACKAGE__->table("entry_page");

=head1 ACCESSORS

=head2 entry_row_id

  data_type: 'int (4, 0)'
  is_foreign_key: 1
  is_nullable: 0

=head2 page

  data_type: 'int (4, 0)'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "entry_row_id",
  { data_type => "int (4, 0)", is_foreign_key => 1, is_nullable => 0 },
  "page",
  { data_type => "int (4, 0)", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</entry_row_id>

=item * L</page>

=back

=cut

__PACKAGE__->set_primary_key("entry_row_id", "page");

=head1 RELATIONS

=head2 entry_row

Type: belongs_to

Related object: L<Indexing::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "entry_row",
  "Indexing::Schema::Result::Entry",
  { row => "entry_row_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-14 23:02:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aoSac3wyj6v3lkw/mvHamA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
