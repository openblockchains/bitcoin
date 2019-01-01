# encoding: utf-8

module Base32
class Electrologica   ## Base32  (2^5 - 5-bits)

  ALPHABET = %w[ 00 01 02 03 04 05 06 07
                 08 09 10 11 12 13 14 15
                 16 17 18 19 20 21 22 23
                 24 25 26 27 28 29 30 31 ]

  def self.alphabet() ALPHABET; end    ## add alpha / char aliases - why? why not?


  def self.bytes( num_or_str )
    if num_or_str.is_a? String
      str = num_or_str
      num = decode( str )
    else  # assume number
      num = num_or_str
    end
    Base32._bytes( num )
  end


  # Converts a base10 integer to a base32 string.
  def self._encode( num )
    buf = String.new
    while num >= BASE
      # puts "num=#{num}"
      mod = num % BASE
      # puts "  mod=#{mod} == #{ALPHABET[mod]}"
      buf = "-" + ALPHABET[mod] + buf    ## note: add - separator
      # puts "buf=#{buf}"
      num = (num - mod)/BASE
    end
    ALPHABET[num] + buf
  end

  def self.encode( num, group: nil, sep: ' ' )
    buf = _encode( num )
    ## check for pretty print/format e.g. group: 4 or something
    if group
      fmt( buf, group: group, sep: sep )
    else
      buf
    end
  end


  NUMBER = {    ## rename INTEGER /INT - why? why not??
    '00' => 0,  '0' => 0,
    '01' => 1,  '1' => 1,
    '02' => 2,  '2' => 2,
    '03' => 3,  '3' => 3,
    '04' => 4,  '4' => 4,
    '05' => 5,  '5' => 5,
    '06' => 6,  '6' => 6,
    '07' => 7,  '7' => 7,
    '08' => 8,  '8' => 8,
    '09' => 9,  '9' => 9,
    '10' => 10,
    '11' => 11,
    '12' => 12,
    '13' => 13,
    '14' => 14,
    '15' => 15,
    '16' => 16,
    '17' => 17,
    '18' => 18,
    '19' => 19,
    '20' => 20,
    '21' => 21,
    '22' => 22,
    '23' => 23,
    '24' => 24,
    '25' => 25,
    '26' => 26,
    '27' => 27,
    '28' => 28,
    '29' => 29,
    '30' => 30,
    '31' => 31,
  }

  BINARY = ALPHABET.each_with_index.reduce({}) do |h, (char,index)|
    ## e.g. '00000', '00001', '00010', '00011', etc.
       h[char]           = '%05b' % index
       h[char.to_i.to_s] = '%05b' % index   if char =~ /0[0-9]/ # e.g. 00, 01, etc.
       h
  end

  CODE = ALPHABET.each_with_index.reduce({}) do |h, (char,index)|
     ## e.g. '00', '01', '02', '03', '04', etc.
       h[char]           = '%02d' % index
       h[char.to_i.to_s] = '%02d' % index   if char =~ /0[0-9]/ # e.g. 00, 01, etc.
       h
  end

  ## add shortcuts (convenience) aliases
  BIN = BINARY
  NUM = NUMBER

  def self.number() NUMBER; end
  def self.code() CODE; end
  def self.binary() BINARY; end


  def self.clean( str )
    ## note: allow spaces or slash (/) for dashes (-)
    str = str.strip  ## remove leading and trailing spaces (first)
    str = str.tr( ' /', '-' )
    str = str.gsub( /-{2,}/, '-' )  ## fold more than one dash into one
  end

  # Converts a base32 string to a base10 integer.
  def self.decode( str )
    str = clean( str )

    num = 0
    str.split('-').reverse.each.with_index do |char,index|
      code = NUMBER[char]
      raise ArgumentError, "Value passed not a valid base32 string - >#{char}< not found in alphabet"  if code.nil?
      num += code * (BASE**(index))
    end
    num
  end


  def self.fmt( str, group: 4, sep: ' ' )
    ## todo/fix: check sep - MUST be space () or slash (/) for now!!!!!

    str = clean( str )

    ## format in groups of four (4) separated by space
    ##  e.g.  09-09-09-09-06-07-07-04-01-01-14-01-09-15-14-14-00-05-05-00
    ##     :  09-09-09-09 06-07-07-04 01-01-14-01 09-15-14-14 00-05-05-00

    ## note: use reverse - if not divided by four that leading slice gets cut short
    str.split('-').reverse.each_slice( group ).map { |slice| slice.reverse.join( '-' ) }.reverse.join( sep )
  end

end # class Electrologica
end # module Base32
