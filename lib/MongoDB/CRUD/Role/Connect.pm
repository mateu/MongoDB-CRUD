use strictures 1;
package MongoDB::CRUD::Role::Connect;
use Moo::Role;
use namespace::autoclean;
use MongoDB;

has 'conn' => (
    is => 'ro',
    lazy => 1,
    builder => '_build_conn',
);
has 'host' => (
    is => 'rw',
    lazy => 1,
    default => sub { 'mongodb://localhost:27017' },
    clearer => 'clear_host',
);
has 'db_name' => (
    is => 'rw',
    lazy => 0,
    default => sub { 'test' },
    clearer => 'clear_db_name',
    writer  => 'set_db_name'
);
after 'set_db_name' => sub {
    my $self = shift;
    $self->clear_db;
};
has 'db' => (
    is => 'rw',
    lazy => 1,
    builder => '_build_db',
    clearer => 'clear_db',
);
has 'collection_name' => (
    is => 'rw',
    lazy => 0,
    default => sub { 'test' },
    clearer => 'clear_collection_name',
    writer  => 'set_collection_name'
);
after 'set_collection_name' => sub {
    my $self = shift;
    $self->clear_collection;
};
has 'collection' => (
    is => 'rw',
    lazy => 1,
    builder => '_build_collection',
    clearer => 'clear_collection',
);

sub _build_conn {
    my $self = shift;
    MongoDB::MongoClient->new( host => $self->host );
}

sub _build_db  {
    my $self = shift;
    my $db_name = $self->db_name;
    $self->conn->get_database(${db_name});
}

sub _build_collection  {
    my $self = shift;
    my $collection_name = $self->collection_name;
    $self->db->get_collection(${collection_name});
}

1;
