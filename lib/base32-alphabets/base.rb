# encoding: utf-8

#########
## shared code for formats / variants with single char alphabets
##   e.g. Kai, Crockford, ...

module Base32
class Base

  # Converts a base10 integer to a base32 string.
  def self.encode( num, klass: )
    buf = String.new
    while num >= BASE
      ## puts "num=#{num}"
      mod = num % BASE
      ## puts "  mod=#{mod} == #{klass::ALPHABET[mod]}"
      buf = klass::ALPHABET[mod] + buf
      ## puts "buf=#{buf}"
      num = (num - mod)/BASE
    end
    klass::ALPHABET[num] + buf
  end



  # Converts a base32 string to a base10 integer.
  def self.decode( str, klass: )
    ## note: allow spaces or dashes (-); remove them all first
    str = str.tr( ' -', '' )

    num = 0
    str.reverse.each_char.with_index do |char,index|
      code = klass::NUMBER[char]
      raise ArgumentError, "Value passed not a valid base32 string - >#{char}< not found in alphabet"  if code.nil?
      num += code * (BASE**(index))
    end
    num
  end




  def self.fmt( str )
    ## note: allow spaces or dashes (-); remove them all first
    str = str.tr( ' -', '' )

    ## format in groups of four (4) separated by space
    ##  e.g.  ccac7787fa7fafaa16467755f9ee444467667366cccceede
    ##     :  ccac 7787 fa7f afaa 1646 7755 f9ee 4444 6766 7366 cccc eede
    str.reverse.gsub( /(.{4})/, '\1 ').reverse.strip
  end



########################
## (private) helpers
  def self.build_binary( klass: )
    h = {}
    klass::ALPHABET.each_with_index do |char,index|
      # puts "#{char} => #{index} #{'%05b' % index}"
      h[char] = '%05b' % index
    end
    h
  end

end # class Base
end # module Base32
