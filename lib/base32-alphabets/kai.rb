# encoding: utf-8

#####################
# why kai?
#  in honor of Kaigani who deciphered the genes - thanks!
#    see https://medium.com/@kaigani/the-cryptokitties-genome-project-on-dominance-inheritance-and-mutation-b73059dcd0a4


module Base32
class Kai < Base

# See https://en.wikipedia.org/wiki/Base58
## Note: aplpabet used for encoding
ALPHABET = %w[ 1 2 3 4 5 6 7 8
               9 a b c d e f g
               h i j k m n o p
               q r s t u v w x]

def self.alphabet() ALPHABET; end    ## add alpha / char aliases - why? why not?



## Note:
##   for decoding allow (misspelled) l/L for 1
##    and               (misspelled)  0  for o/O - why? why not?
##    and UPPERCASE letters - why? why not?

NUMBER = {    ## rename INTEGER /INT - why? why not??
  '1' => 0, 'l' => 0, 'L'=> 0,
  '2' => 1,
  '3' => 2,
  '4' => 3,
  '5' => 4,
  '6' => 5,
  '7' => 6,
  '8' => 7,
  '9' => 8,
  'a' => 9,  'A' => 9,
  'b' => 10, 'B' => 10,
  'c' => 11, 'C' => 11,
  'd' => 12, 'D' => 12,
  'e' => 13, 'E' => 13,
  'f' => 14, 'F' => 14,
  'g' => 15, 'G' => 15,
  'h' => 16, 'H' => 16,
  'i' => 17, 'I' => 17,
  'j' => 18, 'J' => 18,
  'k' => 19, 'K' => 19,
  'm' => 20, 'M' => 20,
  'n' => 21, 'N' => 21,
  'o' => 22, 'O' => 22, '0' => 22,
  'p' => 23, 'P' => 23,
  'q' => 24, 'Q' => 24,
  'r' => 25, 'R' => 25,
  's' => 26, 'S' => 26,
  't' => 27, 'T' => 27,
  'u' => 28, 'U' => 28,
  'v' => 29, 'V' => 29,
  'w' => 30, 'W' => 30,
  'x' => 31, 'X' => 31
}


=begin
BINARY = {
  '1' => '00000',    # 0
  '2' => '00001',    # 1
  '3' => '00010',    # 2
  '4' => '00011',    # 3
  '5' => '00100',    # 4
  '6' => '00101',    # 5
  '7' => '00110',    # 6
  '8' => '00111',    # 7
  '9' => '01000',    # 8
  'a' => '01001',    # 9
  'b' => '01010',    # 10
  'c' => '01011',    # 11
  'd' => '01100',    # 12
  'e' => '01101',    # 13
  'f' => '01110',    # 14
  'g' => '01111',    # 15
  'h' => '10000',    # 16
  'i' => '10001',    # 17
  'j' => '10010',    # 18
  'k' => '10011',    # 19
  'm' => '10100',    # 20
  'n' => '10101',    # 21
  'o' => '10110',    # 22
  'p' => '10111',    # 23
  'q' => '11000',    # 24
  'r' => '11001',    # 25
  's' => '11010',    # 26
  't' => '11011',    # 27
  'u' => '11100',    # 28
  'v' => '11101',    # 29
  'w' => '11110',    # 30
  'x' => '11111'     # 31
}
=end

## simple hash map (helper) for conversion to binary string
BINARY = build_binary()
## add special cases too
BINARY['l'] = BINARY['1']   ## 1 == l / L
BINARY['L'] = BINARY['1']
BINARY['0'] = BINARY['o']   ## o / O == 0


CODE   = build_code()
## add special cases too
CODE['l'] = CODE['1']   ## 1 == l / L
CODE['L'] = CODE['1']
CODE['0'] = CODE['o']   ## o / O == 0


## add shortcuts (convenience) aliases
BIN = BINARY
NUM = NUMBER

def self.number() NUMBER; end        ## add num alias - why? why not?
def self.code() CODE; end
def self.binary() BINARY; end        ## add bin alias - why? why not?

end # class Kai
end # module Base32
