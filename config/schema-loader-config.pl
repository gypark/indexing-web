{
    schema_class => "Indexing::Schema",
    connect_info => {
        dsn  => $ENV{DB_DSN}      || "dbi:SQLite:./db/mybook.db3",
        sqlite_unicode => 1,
    },
    loader_options => {
        dump_directory     => 'lib',
        naming             => { ALL => 'v8' },
        skip_load_external => 1,
        relationships      => 1,
        col_collision_map  => 'column_%s',
        result_base_class => 'Indexing::Schema::ResultBase',
        default_resultset_class => 'ResultSetBase',
        overwrite_modifications => 1,
        datetime_undef_if_invalid => 1,

        custom_column_info => sub {
            my ($table, $col_name, $col_info) = @_;

            if ($col_name eq 'created_at') {
                return { %{ $col_info }, set_on_create => 1, timezone => "Asia/Seoul" };
            }

            if ($col_name eq 'updated_at') {
                return { %{ $col_info }, set_on_create => 1, set_on_update => 1, timezone => "Asia/Seoul"  };
            }
        },
    },
}


