require_relative '../lib/simpleiban.rb'
require 'test/unit'

class TestSimpleIBAN < Test::Unit::TestCase

  def test_detect_valid_IBAN_checksum
    a = IBAN.new 'GB82WEST12345698765432' # from wikipedia
    assert a.valid?
  end

  def test_detect_invalid_IBAN_checksum
    assert !(IBAN.new 'GB00 WEST 000000000000').valid?
  end

  def test_detect_valid_IBAN_with_spaces
    assert (IBAN.new 'G B8 2WE ST12 34569 876543 2').valid?
  end

  def test_creation_does_not_have_side_effects_on_strings
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

  def test_IBAN_with_invalid_characters
    assert_equal false, IBAN.new('GB82WEST|2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST@2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST(2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST)2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST!2345698765432').valid?
    assert_equal false, IBAN.new('GB82WEST,2345698765432').valid?
  end

end
