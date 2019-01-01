# encoding: utf-8


module Base32   ## Base32  (2^5 - 5-bits)

  BASE = 32    #  ALPHABET.length == 32   ## 32 chars/letters/digits


  class Configuration
     attr_reader :format

     MAPPING = {
       kai:           Kai,            # starts counting at 1 (one)
       crockford:     Crockford,      # starts counting at 0 (zero)
       hex:           Crockford,      #  note: use hex as an alias - why? why not?
       electrologica: Electrologica,
       num:           Electrologica,  #  note: use num as an alias
     }

     def initialize
       @format = Kai
     end

     def format=(value)
       if value.is_a? Symbol
         @format = MAPPING[ value ]
       else  ## assume class
         @format = value
       end
     end
  end # class Configuration

  ## lets you use
  ##   Base32.configure do |config|
  ##      config.format     =  :kai
  ##   end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield( configuration )
  end

  ## add convenience helper for format
  def self.format() configuration.format; end
  def self.format=(value) self.configuration.format = value; end



  def self.encode( num, klass: configuration.format, group: nil, sep: ' ' )
    klass.encode( num, group: group, sep: sep )
  end

  def self.decode( str, klass: configuration.format )
    klass.decode( str )
  end

  def self.fmt( str, klass: configuration.format, group: 4, sep: ' ' )
    klass.fmt( str, group: group, sep: sep )
  end



  ## encoding alphabet - letter-to-number by index / array
  def self.alphabet( klass: configuration.format ) klass::ALPHABET; end

  ## decoding letter-to-number mapping / hash
  def self.number( klass: configuration.format ) klass::NUMBER; end
  ## decoding letter-to-code mapping / hash
  def self.code( klass: configuration.format ) klass::CODE; end
  ## decoding letter-to-binary mapping / hash
  def self.binary( klass: configuration.format ) klass::BINARY; end
end # module Base32
