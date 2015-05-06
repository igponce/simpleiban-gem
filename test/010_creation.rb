require_relative '../lib/simpleiban.rb'
require 'test/unit'

class TestSimpleIBAN < Test::Unit::TestCase

  def test_detectValidIBANChecksum
    a = IBAN.new 'GB82WEST12345698765432' # from wikipedia
    assert a.is_valid?
  end

  def test_detectInvalidIBANChecksum
    assert !(IBAN.new 'GB00 WEST 000000000000').is_valid?
  end

  def test_detectValidIBAN_withspaces
    assert (IBAN.new 'GB 8 2 WE ST 12345 698 765 432').is_valid?
  end

  def test_creationDoesNotHaveSideEffectsOnStrings
    str1 = 'GB82 WEST 1234 5698 7654 32'
    str2 = String.new str1
    i = IBAN.new str2
    assert str1 == str2
  end

  def test_IBAN_to_s_formatting_in_blocks_of_4_characters # (except the last one)
    i = IBAN.new 'GB82WEST12345698765432'
    assert_match /([A-Z0-9]{4}\s)+[A-Z0-9]{1,3}/, i.to_s
  end

  def test_IBANWithInvalidCharacters
    assert_equal false, IBAN.new('GB82WEST|2345698765432').is_valid?
    assert_equal false, IBAN.new('GB82WEST@2345698765432').is_valid?
    assert_equal false, IBAN.new('GB82WEST(2345698765432').is_valid?
    assert_equal false, IBAN.new('GB82WEST)2345698765432').is_valid?
    assert_equal false, IBAN.new('GB82WEST!2345698765432').is_valid?
    assert_equal false, IBAN.new('GB82WEST,2345698765432').is_valid?
  end

end
