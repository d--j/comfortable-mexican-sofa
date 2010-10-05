require File.dirname(__FILE__) + '/../../test_helper'

class PageStringTest < ActiveSupport::TestCase
  
  def test_initialize_tag
    %w(
      <cms:page:content:string/>
      <cms:page:content:string>
    ).each do |tag_signature|
      assert tag = CmsTag::PageString.initialize_tag(cms_pages(:default), tag_signature)
      assert_equal 'content', tag.label
    end
  end
  
  def test_initialize_tag_failure
    %w(
      <cms:page:content:not_string/>
      <cms:page:content/>
      <cms:not_page:content/>
      not_a_tag
    ).each do |tag_signature|
      assert_nil CmsTag::PageString.initialize_tag(cms_pages(:default), tag_signature)
    end
  end
  
  def test_content_and_render
    tag = CmsTag::PageString.initialize_tag(cms_pages(:default), "<cms:page:content:string>")
    assert tag.content.blank?
    tag.content = 'test_content'
    assert_equal 'test_content', tag.content
    assert_equal 'test_content', tag.read_attribute(:content_string)
    assert_equal 'test_content', tag.render
  end
  
end