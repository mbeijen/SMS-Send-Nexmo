use strict;
use warnings;
package SMS::Send::Nexmo;
# ABSTRACT: SMS::Send backend for the Nexmo.com SMS service.

use SMS::Send::Driver;
use Nexmo::SMS;

our @ISA = qw/SMS::Send::Driver/;
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();

our $URL = 'https://rest.nexmo.com/sms/json';


sub new {
  my $pkg = shift;
  my %p = @_;
  exists $p{_username} or die $pkg."->new requires _username parameter\n";
  exists $p{_password} or die $pkg."->new requires _password parameter\n";
  exists $p{_from} or die $pkg."->new requires _from parameter\n";
  exists $p{_server} or $p{_server} = $URL;
  exists $p{_verbose} or $p{_verbose} = 1;
  my $self = \%p;
  bless $self, $pkg;
  $self->{_nexmo} = Nexmo::SMS->new(
      server   => $p{_server},
      username => $p{_username},
      password => $p{_password},
  );
  return $self;
}

sub send_sms {
  my $self = shift;
  my %p = @_;
  $p{to} =~ s/^\+//;
  $p{to} =~ s/[- ]//g;

  my $sms = $self->{_nexmo}->sms(
      text => $p{text},
      from => $self->{_from},
      to   => $p{to},
      );
  
  my $response = $sms->send;
  
  unless ($response->is_success) {
    warn "Failure: $sms->errstr\n" if ($self->{_verbose});
    return 0;
  }
  return 1;
}

1;


=head1 SYNOPSIS

This is an SMS::Send backend for the L<http://nexmo.com> SMS service. 
You're not supposed to use this module directly, you should use
SMS::Send instead. 

=head1 DESCRIPTION

Installing this module will also install almost all the modules you'll need to run OTRS.

Note that OTRS itself also ships some CPAN modules in Kernel/cpan-libs, these modules will
not be required by Task::OTRS. See for the bundled list of modules in OTRS 
L<Module::OTRS::CoreList>.

The only module that you need to run OTRS but that will not be installed is the database driver, because OTRS supports 
multiple database backends. So after you're done installing Task::OTRS you might also want to
install the database driver for your DMBS of choice:

=cut

1;

__END__
=pod

=head1 NAME

SMS::Send::CSoft - SMS::Send driver to send via the Connection Software service

=head1 VERSION

version 1.111490

=head1 SYNOPSIS

  # Create a testing sender
  my $send = SMS::Send->new( 'CSoft',
                             _login => 'csoft username',
                             _password => 'csoft pin' );

  # Send a message
  $send->send_sms(
     text => 'Hi there',
     to   => '+61 (4) 1234 5678',
  );

=head1 DESCRIPTION

SMS::Send driver for sending SMS messages with the Connection
Software (http://www.csoft.co.uk/) SMS service.

=head1 METHODS

=head2 CONSTRUCTOR

This constructor should not be called directly.  See L<SMS::Send> for
details.

=head1 SEE ALSO

SMS::Send(3), SMS::Send::Driver(3)

Connection Software Website: http://www.csoft.co.uk/

=head1 AUTHOR

Mark Hindess <soft-cpan@temporalanomaly.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Mark Hindess.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

1;
