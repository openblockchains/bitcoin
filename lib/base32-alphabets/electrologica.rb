# encoding: utf-8

module Base32
class Electrologica   ## Base32  (2^5 - 5-bits)

  ALPHABET = %w[ 00 01 02 03 04 05 06 07
                 08 09 10 11 12 13 14 15
                 16 17 18 19 20 21 22 23
                 24 25 26 27 28 29 30 31 ]

  # Converts a base10 integer to a base32 string.
  def self.encode( num )
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

  ## Note:
  ##   for decoding allow (misspelled) l/L for 1
  ##    and               (misspelled)  0  for o/O - why? why not?
  ##    and UPPERCASE letters - why? why not?

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


  ## add shortcuts (convenience) aliases
  ## BIN = BINARY
  NUM = NUMBER

  # Converts a base32 string to a base10 integer.
  def self.decode( str )
    ## note: allow spaces or slash (/) for dashes (-)
    str = str.strip  ## remove leading and trailing spaces (first)
    str = str.tr( ' /', '-' )
    str = str.gsub( /-{2,}/, '-' )  ## fold more than one dash into one

    num = 0
    str.split('-').reverse.each.with_index do |char,index|
      code = NUMBER[char]
      raise ArgumentError, "Value passed not a valid base32 string - >#{char}< not found in alphabet"  if code.nil?
      num += code * (BASE**(index))
    end
    num
  end


  def self.fmt( str, sep: '-' )
    ## note: allow spaces or slash (/) for dashes (-)
    str = str.strip  ## remove leading and trailing spaces (first)
    str = str.tr( ' /', '-' )
    str = str.gsub( /-{2,}/, '-' )  ## fold more than one dash into one

    ## format in groups of four (4) separated by space
    ##  e.g.  ccac7787fa7fafaa16467755f9ee444467667366cccceede
    ##     :  ccac 7787 fa7f afaa 1646 7755 f9ee 4444 6766 7366 cccc eede

    ## note: use reverse - if not divided by four that leading slice gets cut short
    str.split('-').reverse.each_slice(4).map { |slice| slice.reverse.join( sep ) }.reverse.join( ' ' )
  end

end # class Electrologica
end # module Base32
