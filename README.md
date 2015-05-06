# simpleiban-gem
Simple IBAN checker

# Usage

Load the lib:

    require 'simpleiban'

Create a new IBAN to check:

    a = IBAN.new 'GB82 West 12345 69876 5432' # from wikipedia

Is it valid (according to the rules)?

    a.is_valid?

And pretty_print it (as a string):

    str = a.to_s
    # str = "GB82 WEST 1234 5698 7654 32"
