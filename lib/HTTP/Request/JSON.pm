package HTTP::Request::JSON;

use strict;
use warnings;
no warnings 'uninitialized';

use parent 'HTTP::Request';

our $VERSION = $LWP::JSON::Tiny::VERSION;

use Encode ();
use LWP::JSON::Tiny;
use JSON::MaybeXS ();

=head1 NAME

HTTP::Request::JSON - a subclass of HTTP::Request that understands JSON

=head1 SYNOPSIS

 my $request = HTTP::Request::JSON->new(PATCH => "$base_url/death_ray");
 # $request has an Accept header saying it's OK to send JSON back
 $request->add_json_content(
     {
         self_destruct_mechanism   => 'disabled',
         users_allowed_to_override => [],
     }
 );
 # Request content is JSON-encoded, and the content-type is set.

=head1 DESCRIPTION

This is a simple subclass of HTTP::Request::JSON that does two things.
First of all, it sets the Accept header to C<application/json> as soon
as it's created. Secondly, it implements a L<add_json_content>
method that adds the supplied data structure to the request, as JSON.

=head2 new

 In: ...
 Out: $request

As HTTP::Request->new, but also sets the Accept header.

=cut

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->header('Accept' => 'application/json');
    return $self;
}

=head2 json_content

 In: $perl_data
 Out: $success

Supplied with a valid JSON data structure, sets the request contents
to be the JSON-encoded version of that data structure, and sets the
Content-Type header to C<application/json>. Will throw an exception
if the data structure cannot be converted to JSON.

All strings in $perl_data must be Unicode strings, or you will get
encoding errors.

=cut

sub json_content {
    my ($self, $perl_data) = @_;

    my $json = LWP::JSON::Tiny->json_object;
    $self->content(Encode::encode('UTF8', $json->encode($perl_data)));
    $self->content_type('application/json');
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