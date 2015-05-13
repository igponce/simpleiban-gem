require_relative '../lib/simpleiban.rb'
require 'test/unit'

class TestSimpleIBAN < Test::Unit::TestCase

  def test_detectValidIBANChecksum
    a = IBAN.new 'GB82WEST12345698765432' # from wikipedia
    assert a.valid?
  end

  def test_detectInvalidIBANChecksum
    assert !(IBAN.new 'GB00 WEST 000000000000').valid?
  end

  def test_detectValidIBAN_withspaces
    assert (IBAN.new 'G B8 2WE ST12 34569 876543 2').valid?
  end

  def test_creationDoesNotHaveSideEffectsOnStrings
    str1 = 'GB82 WEST 1234 5698 7654 32'
    str2 = String.new str1
    i = IBAN.new str2
    assert str1 == str2
  end

  def test_IBAN_to_s_formatting
    # Iban formatting in blocks of 4 characters
    # Using only uppercase characters on output
    # No leading or trailing characters allowed
    assert_match /^([A-Z0-9]{4}\s)+[A-Z0-9]{1,4}?$/, IBAN.new('gb82 wEst 12345698765432').to_s
  end

  def test_IBANWithInvalidCharacters
    assert_equal false, IBAN.new('GB82WEST|2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST@2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST(2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST)2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST!2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST,2345698765432').valid?
  end

end
