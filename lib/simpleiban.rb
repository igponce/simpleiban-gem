# IBAN class
# For cheching IBAN account string

class IBAN

   @iban = ''

   def initialize (ibanstr)
     @iban = ibanstr.tr(' ', '').upcase # internal operation: no whitespace, upcase
     @iban.freeze
     return self
   end

   def self.check
     return is_valid?
   end

   def is_valid?

     return (@iban.split('').rotate(4).map { |e|
       case e
       when 'A'..'Z'
         10 -'A'.ord + e.ord
       else
         e
       end
     }.join.to_i % 97) == 1

   end

   # Returns a normalized IBAN string:
   # alphanimerica characters coverted to uppercase,
   def to_s
     retval = String.new @iban
     (@iban.length/4).times { |i| retval.insert 4*(@iban.length)/4-4*i, ' ' }
     return retval
   end

end


a = IBAN.new (' GB82 WEST 1234 5698 7654 32 ')
print a.is_valid?
print a.to_s
