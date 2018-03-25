# Base32 Encoding / Decoding - 5-Bit Kai Notation/Alphabet

Encode / decode numbers in 5-bit groups (2^5=32)
with the kai notation/alphabet (`123456789abcdefghijkmnopqrstuvwx`)

Note: Following base56 - the digit-0 and the letter-l
are NOT used in the kai alphabet/notation.


* home  :: [github.com/openblockchains/base32.kai.rb](https://github.com/openblockchains/base32.kai.rb)
* bugs  :: [github.com/openblockchains/base32.kai.rb/issues](https://github.com/openblockchains/base32.kai.rb/issues)
* gem   :: [rubygems.org/gems/base32-kai](https://rubygems.org/gems/base32-kai)
* rdoc  :: [rubydoc.info/gems/base32-kai](http://rubydoc.info/gems/base32-kai)


## Usage


### Kai (Base32) Notation

|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|
|-------|-------|---|-------|-------|---|-------|-------|---|-------|-------|---|
| **1** | 00000 | 0 | **9** | 01000 | 8 | **h** | 10000 |16 | **q** | 11000 |24 |
| **2** | 00001 | 1 | **a** | 01001 | 9 | **i** | 10001 |17 | **r** | 11001 |25 |
| **3** | 00010 | 2 | **b** | 01010 | 10| **j** | 10010 |18 | **s** | 11010 |26 |
| **4** | 00011 | 3 | **c** | 01011 | 11| **k** | 10011 |19 | **t** | 11011 |27 |
| **5** | 00100 | 4 | **d** | 01100 | 12| **m** | 10100 |20 | **u** | 11100 |28 |
| **6** | 00101 | 5 | **e** | 01101 | 13| **n** | 10101 |21 | **v** | 11101 |29 |
| **7** | 00110 | 6 | **f** | 01110 | 14| **o** | 10110 |22 | **w** | 11110 |30 |
| **8** | 00111 | 7 | **g** | 01111 | 15| **p** | 10111 |23 | **x** | 11111 |31 |

Note: The digit-0 and the letter-l are NOT used in kai.



### Encode / Decode

``` ruby
require 'base32-kai'


binary = 0b0000000000000000010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110  # binary
hex    = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a_1295_b9ce   # hex

kai    = "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff".gsub( ' ', '' )

pp binary == hex
# => true

kai2 = Kai.encode( hex )   ## (binary) number to text
pp kai
# => "aaaa788522f2agff16617755e979244166677664a9aacfff"
pp kai2
# => "aaaa788522f2agff16617755e979244166677664a9aacfff"
pp Kai.fmt( kai2 )
# => "aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"

hex2 = Kai.decode( kai2 )   ## text to (binary) number
pp hex2
# => 512955438081049600613224346938352058409509756310147795204209859701881294
pp hex == hex2
# => true
pp kai == kai2
# => true
```



### Why Kai?

The Kai notation/alphabet is named in honor of Kaigani
who first deciphered the CryptoKitty 256-bit genes in 5-bit groups - thanks!.
See [The CryptoKitties Genome Project: On Dominance, Inheritance and Mutation](https://medium.com/@kaigani/the-cryptokitties-genome-project-on-dominance-inheritance-and-mutation-b73059dcd0a4).



## License

The `base32-kai` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.
