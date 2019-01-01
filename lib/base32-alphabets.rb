# encoding: utf-8

require 'pp'


## our own code
require 'base32-alphabets/version'    # note: let version always go first

require 'base32-alphabets/base'
require 'base32-alphabets/kai'
require 'base32-alphabets/crockford'
require 'base32-alphabets/electrologica'
require 'base32-alphabets/base32'





## add a shortcut (convenience) alias
Kai           = Base32::Kai
Crockford     = Base32::Crockford
Electrologica = Base32::Electrologica


def encode32( num, group: nil, sep: ' ' )
  Base32.encode( num, group: group, sep: sep )
end

def decode32( num )
  Base32.decode( str )
end



# say hello
puts Base32.banner   if $DEBUG || (defined?($RUBYCOCO_DEBUG) && $RUBYCOCO_DEBUG)
