# IBAN class
# For cheching IBAN account string

class IBAN

   # simple iban cheksum checker
   # Example:
   #
   # foo = 'GB82WEST12345698765432'
   # foo.valid?
   #
   # Can also "pretty display" IBAN numbers:
   # foo.to_s


   @iban = ''

   def initialize (ibanstr)
     @iban = ibanstr.tr(' ', '').upcase # internal operation: no whitespace, upcase
     @iban.freeze
     return self
   end

   def self.check
     # Checks validity of IBAN, alias for valid?
     return valid?
   end

   def valid?

     # Checks if the IBAN checksum is correct and
     # Good to detect typos in the IBAN

     return (@iban.split('').rotate(4).map { |e|
       case e
       when 'A'..'Z'
         10 -'A'.ord + e.ord
       else
         e
       end
     }.join.to_i % 97) == 1

   end

   def to_s
     # Returns a normalized IBAN string: 4-block characters
     # with uppercase characters when needed.

     retval = String.new @iban
     (@iban.length/4).times { |i| retval.insert 4*(@iban.length)/4-4*i, ' ' }
     return retval
   end

end
