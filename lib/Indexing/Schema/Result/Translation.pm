use utf8;
package Indexing::Schema::Result::Translation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Indexing::Schema::Result::Translation

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<Indexing::Schema::ResultBase>

=cut

use base 'Indexing::Schema::ResultBase';

=head1 TABLE: C<translation>

=cut

__PACKAGE__->table("translation");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 entry_row_id

  data_type: 'int (4, 0)'
  is_foreign_key: 1
  is_nullable: 1

=head2 kor_1

  data_type: 'text'
  is_nullable: 1

=head2 kor_2

  data_type: 'text'
  is_nullable: 1

=head2 kor_3

  data_type: 'text'
  is_nullable: 1

=head2 kor_page

  data_type: 'text'
  is_nullable: 1

=head2 comment

  data_type: 'text'
  is_nullable: 1

=head2 user

  data_type: 'text'
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  is_nullable: 1
  set_on_create: 1
  timezone: 'Asia/Seoul'

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "entry_row_id",
  { data_type => "int (4, 0)", is_foreign_key => 1, is_nullable => 1 },
  "kor_1",
  { data_type => "text", is_nullable => 1 },
  "kor_2",
  { data_type => "text", is_nullable => 1 },
  "kor_3",
  { data_type => "text", is_nullable => 1 },
  "kor_page",
  { data_type => "text", is_nullable => 1 },
  "comment",
  { data_type => "text", is_nullable => 1 },
  "user",
  { data_type => "text", is_nullable => 1 },
  "created_at",
  {
    data_type     => "datetime",
    is_nullable   => 1,
    set_on_create => 1,
    timezone      => "Asia/Seoul",
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 entry_row

Type: belongs_to

Related object: L<Indexing::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "entry_row",
  "Indexing::Schema::Result::Entry",
  { row => "entry_row_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-16 00:14:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gM82y4qBbx/aAAkV833R6w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
