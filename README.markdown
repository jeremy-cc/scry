# Scry
#### Jeremy Botha, October 2013
#### Version 0.0.1

## Overview

Scry is a gem intended to provide lightweight, easy integration into notification services which provide api-based access.  It is intended as a small, lightweight manner
to capture various system messages to for e.g a developer chat room for action as appropriate.  It is supposed to be minimally intrusive, and ideally a single line call
should be all that is necessary whenever anything needs to be spooled to an external event sink.

## Supported Notifications

- Hipchat

## Usage

    require 'scry'

    config = {
        :hipchat => {
            :host=>'https://api.hipchat.com',
            :api_key => '<api key>',
            :room_id => '<room id>',
            :colours=>{
                          :info=>'green',
                          :none=>'gray',
                          :warning=>'yellow',
                          :error=>'red'
                      }
            }
        }
    }

    hipchat = Scry.for(:hipchat, config)

    hipchat.info 'Test message'

Scry makes use of method_missing to provide a dynamic binding onto modules within itself.  This may interfere with other modules, therefore caveat emptor.

## Source code

Source is available on github

## Release History

* 0.0.1 Initial release with support for Hipchat

## Origin of the name

See [This Wikipedia article](https://en.wikipedia.org/wiki/Scrying) for a description of the origin of the name.  It seemed appropriate as the name for a gem whose intent is to
allow the seeing of things - especially now that the NSA has palantir... :P

