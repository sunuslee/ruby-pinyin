# encoding: utf-8
require 'test/unit'
require 'ruby-pinyin'

class PinYinTest < Test::Unit::TestCase
  def test_value_initialize
    v = PinYin::Value.new('hello')
    assert_equal 'hello', v
    assert_equal true, v.english?
  end

  def test_value_split
    ary = PinYin::Value.new('hello world').split(/\s/)
    assert_equal PinYin::Value, ary[0].class
  end

  def test_codes_loaded
    assert_equal false, PinYin.codes.empty?
  end

  def test_get_pinyin_of_multiple_pronunciation_character
    assert_equal ['HAO3'], PinYin.of_string('好', true) # code 597D, value HAO3, HAO4
  end

  def test_get_pinyin_of_empty_string
    assert_equal [], PinYin.of_string('')
    assert_equal [], PinYin.of_string(nil)
  end

  def test_get_pinyin_of_chinese_string
    assert_equal ['JIE', 'CAO'], PinYin.of_string('节操')
  end

  def test_get_pinyin_of_chinese_string_with_tone
    assert_equal ['JIE2', 'CAO1'], PinYin.of_string('节操', true)
  end

  def test_get_pinyin_of_english_phrase
    assert_equal %w(And the winner is), PinYin.of_string('And the winner is ...')
  end

  def test_get_pinyin_of_mixed_string
    pinyin = PinYin.of_string '感谢party感谢guo jia'
    assert_equal %w(GAN XIE party GAN XIE guo jia), pinyin
    assert_equal true, pinyin.all? {|word| word.class == PinYin::Value}
  end

  def test_permlink
    assert_equal 'gan-xie-party-gan-xie-guo-jia', PinYin.permlink('感谢party感谢guo jia')
  end

  def test_abbr
    assert_equal 'gxpartygxguojia', PinYin.abbr('感谢party感谢guo jia')
  end

  def test_abbr_except_lead
    assert_equal 'ganxpartygxguojia', PinYin.abbr('感谢party感谢guo jia', true)
  end

  def test_abbr_with_english
    assert_equal 'gxpgxgj', PinYin.abbr('感谢party感谢guo jia', false, false)
  end

  def test_get_pinyin_sentence
    assert_equal 'gan xie party, gan xie guo jia!', PinYin.sentence('感谢party, 感谢guo家!')
  end

  def test_get_pinyin_sentence_with_tone
    assert_equal 'gan3 xie4 party, gan3 xie4 guo jia1!', PinYin.sentence('感谢party, 感谢guo家!', true)
  end
end
