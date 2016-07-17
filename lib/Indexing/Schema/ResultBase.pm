package Indexing::Schema::ResultBase;

use parent 'DBIx::Class::Core';
use DateTimeX::Format::Ago;

__PACKAGE__->load_components(qw/
    Numeric
    InflateColumn::DateTime
    InflateColumn::Serializer
    TimeStamp
    UUIDColumns
    EncodedColumn
/);

__PACKAGE__->uuid_class('::Data::UUID');

sub time_ago {
    my ($self, $column) = @_;

    return $self->can($column) && defined $self->$column
        ? DateTimeX::Format::Ago->new( language => 'KOR')->format_datetime($self->$column)
        : '';
}

1;
