# NAME

SMS::Send::Nexmo - SMS::Send backend for the Nexmo.com SMS service.

# VERSION

version 0.22

# SYNOPSIS

This is an SMS::Send backend for the [http://nexmo.com](http://nexmo.com) SMS service. 
You're not supposed to use this module directly, you should use
SMS::Send instead. 

# DESCRIPTION

It's easy!

    # Create a sender
    my $send = SMS::Send->new( 'Nexmo',
                               _username => '12345ab6',
                               _password => 'ab1cd2e3',
                               _from     => '0031715793800',
                              );

    # Send a message
    $send->send_sms(
       text => 'Hi there',
       to   => '+31 6 45742418',
    );

This module uses [Nexmo::SMS](https://metacpan.org/pod/Nexmo::SMS) as backend. If you need more advanced
functions than just sending messages; please use [Nexmo::SMS](https://metacpan.org/pod/Nexmo::SMS) directly.

# AUTHOR

Michiel Beijen <michielb@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by OTRS BV.

This is free software, licensed under:

    The GNU Affero General Public License, Version 3, November 2007
