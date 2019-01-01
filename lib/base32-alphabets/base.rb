# encoding: utf-8

#########
## shared code for formats / variants with single char alphabets
##   e.g. Kai, Crockford, ...

module Base32
class Base

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
      ## puts "num=#{num}"
      mod = num % BASE
      ## puts "  mod=#{mod} == #{klass::ALPHABET[mod]}"
      buf = alphabet[mod] + buf
      ## puts "buf=#{buf}"
      num = (num - mod) / BASE
    end
    alphabet[num] + buf
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


  def self.clean( str )
    ## note: remove space ( ), dash (-), slash (/) for now as "allowed / supported" separators
    str.tr( ' -/', '' )
  end

  # Converts a base32 string to a base10 integer.
  def self.decode( str )
    str = clean( str )

    num = 0
    str.reverse.each_char.with_index do |char,index|
      code = number[char]
      raise ArgumentError, "Value passed not a valid base32 string - >#{char}< not found in alphabet"  if code.nil?
      num += code * (BASE**(index))
    end
    num
  end



  def self.fmt( str, group: 4, sep: ' ' )
    str = clean( str )

    ## format in groups of four (4) separated by space
    ##  e.g.  ccac7787fa7fafaa16467755f9ee444467667366cccceede
    ##     :  ccac 7787 fa7f afaa 1646 7755 f9ee 4444 6766 7366 cccc eede
    str.reverse.gsub( /(.{#{group}})/, "\\1#{sep}" ).reverse.sub( /^#{sep}/, '' )
  end



########################
## (private) helpers
  def self.build_binary
    ## e.g. '00000', '00001', '00010', '00011', etc.
    alphabet.each_with_index.reduce({}) do |h, (char,index)|
      # note: also (auto-)add upcase letter (e.g. aA, bB, etc.)
      h[char]        = '%05b' % index
      h[char.upcase] = '%05b' % index   if char =~ /[a-z]/
      h
    end
  end

  def self.build_code
    ## e.g. '00', '01', '02', '03', '04', etc.
    alphabet.each_with_index.reduce({}) do |h, (char,index)|
      # note: also (auto-)add upcase letter (e.g. aA, bB, etc.)
      h[char]        = '%02d' % index
      h[char.upcase] = '%02d' % index   if char =~ /[a-z]/
      h
    end
  end


end # class Base
end # module Base32
