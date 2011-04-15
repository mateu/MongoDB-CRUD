use strictures 1;
use Test::More;
use MongoDB::CRUD;

my $crud = MongoDB::CRUD->new( db_name => 'test', collection_name => 'test', );
isa_ok( $crud->conn, 'MongoDB::Connection' );
my $page = {
    name  => 'favorite links',
    links => [
        { 
            url => 'http://www.indiana.edu/', 
            title => 'Indiana University' 
        },
        {
            url   => 'http://missoulanews.com',
            title => 'Independent'
        }
    ]
};
my $page_id = $crud->create($page);
# Read page back
my $page_read = $crud->read($page_id);
is($page_read->{links}->[0]->{title}, 'Indiana University', 'page read');

done_testing();
