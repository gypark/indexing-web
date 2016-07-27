use utf8;
package Indexing::Schema::Result::Entry;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Indexing::Schema::Result::Entry

=cut

use strict;
use warnings;


=head1 BASE CLASS: L<Indexing::Schema::ResultBase>

=cut

use base 'Indexing::Schema::ResultBase';

=head1 TABLE: C<entry>

=cut

__PACKAGE__->table("entry");

=head1 ACCESSORS

=head2 row

  data_type: 'int (4, 0)'
  is_nullable: 0

=head2 level

  data_type: 'int (1, 0)'
  is_nullable: 1

=head2 eng_1

  data_type: 'text'
  is_nullable: 1

=head2 eng_2

  data_type: 'text'
  is_nullable: 1

=head2 eng_3

  data_type: 'text'
  is_nullable: 1

=head2 eng_page

  data_type: 'text'
  is_nullable: 1

=head2 parent_row_id

  data_type: 'int (4, 0)'
  is_foreign_key: 1
  is_nullable: 1

=head2 is_locked

  data_type: 'boolean'
  default_value: 0
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  is_nullable: 1
  set_on_create: 1
  timezone: 'Asia/Seoul'

=head2 updated_at

  data_type: 'datetime'
  is_nullable: 1
  set_on_create: 1
  set_on_update: 1
  timezone: 'Asia/Seoul'

=cut

__PACKAGE__->add_columns(
  "row",
  { data_type => "int (4, 0)", is_nullable => 0 },
  "level",
  { data_type => "int (1, 0)", is_nullable => 1 },
  "eng_1",
  { data_type => "text", is_nullable => 1 },
  "eng_2",
  { data_type => "text", is_nullable => 1 },
  "eng_3",
  { data_type => "text", is_nullable => 1 },
  "eng_page",
  { data_type => "text", is_nullable => 1 },
  "parent_row_id",
  { data_type => "int (4, 0)", is_foreign_key => 1, is_nullable => 1 },
  "is_locked",
  { data_type => "boolean", default_value => 0, is_nullable => 1 },
  "created_at",
  {
    data_type     => "datetime",
    is_nullable   => 1,
    set_on_create => 1,
    timezone      => "Asia/Seoul",
  },
  "updated_at",
  {
    data_type     => "datetime",
    is_nullable   => 1,
    set_on_create => 1,
    set_on_update => 1,
    timezone      => "Asia/Seoul",
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</row>

=back

=cut

__PACKAGE__->set_primary_key("row");

=head1 RELATIONS

=head2 entries

Type: has_many

Related object: L<Indexing::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "Indexing::Schema::Result::Entry",
  { "foreign.parent_row_id" => "self.row" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entry_pages

Type: has_many

Related object: L<Indexing::Schema::Result::EntryPage>

=cut

__PACKAGE__->has_many(
  "entry_pages",
  "Indexing::Schema::Result::EntryPage",
  { "foreign.entry_row_id" => "self.row" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 parent_row

Type: belongs_to

Related object: L<Indexing::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "parent_row",
  "Indexing::Schema::Result::Entry",
  { row => "parent_row_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "SET NULL",
    on_update     => "CASCADE",
  },
);

=head2 translations

Type: has_many

Related object: L<Indexing::Schema::Result::Translation>

=cut

__PACKAGE__->has_many(
  "translations",
  "Indexing::Schema::Result::Translation",
  { "foreign.entry_row_id" => "self.row" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-07-15 00:55:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DSsuyK7NcezuQlYfNdrPZw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

sub in_page {
    my ( $self, $page ) = @_;

    my $res = $self->search_related('entry_pages', { 'me.page' => $page })->count;

    return $res;
}

sub recent_translation {
    my $self = shift;

    my $translation = $self->translations->search(
        undef,
        {
            order_by => [ { -desc => 'me.created_at' }, { -desc => 'me.id' } ],
            rows => 1,
        }
    )->first;

    return $translation;
}

# XXX: translations should be sorted by descending order when searching
sub as_hash {
    my $self = shift;

    my $translation = $self->translations->first;
    return {
        ( map { $_ => $self->$_ } qw(row level eng_1 eng_2 eng_3 eng_page is_locked) ),
        ( map { $_ => $translation ? $translation->$_ : '' } qw(kor_1 kor_2 kor_3 kor_page comment user created_at) ),
        in_page => sub { $self->in_page($_[0]) },
    };
}


1;
