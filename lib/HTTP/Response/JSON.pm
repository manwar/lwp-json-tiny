package HTTP::Response::JSON;

use strict;
use warnings;
no warnings 'uninitialized';

use LWP::JSON::Tiny;
use parent 'HTTP::Response';

our $VERSION = $LWP::JSON::Tiny::VERSION;

=head1 NAME

HTTP::Response::JSON - a subclass of HTTP::Response that understands JSON

=head1 SYNOPSIS

 if ($response->isa('HTTP::Response::JSON')) {
     record_data_structure($response->json_content);
 }

=head1 DESCRIPTION

This is a simple subclass of HTTP::Response that implements a method
L<json_content> which returns the JSON-decoded contents of the response.

=head2 json_content

 Out: $perl_data

Returns the Perl data structure corresponding to the contents of this
response. Will throw an exception if the contents cannot be converted to
JSON.

=cut

sub json_content {
    my ($self) = @_;

    return $self->decoded_content;
}

=head1 AUTHOR

Sam Kington <skington@cpan.org>

The source code for this module is hosted on GitHub
L<https://github.com/skington/lwp-json-tiny> - this is probably the
best place to look for suggestions and feedback.

=head1 COPYRIGHT

Copyright (c) 2015 Sam Kington.

=head1 LICENSE

This library is free software and may be distributed under the same terms as
perl itself.

=cut

1;