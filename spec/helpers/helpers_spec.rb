require File.expand_path('../spec_helper', File.dirname(__FILE__))
include Kaminari::Helpers

describe 'Kaminari::Helpers::PaginationRenderer' do
  let :renderer do
    stub(r = Object.new) do
      render.with_any_args
      params { {} }
      url_for {|h| "/foo?page=#{h[:page]}"}
    end
    r
  end
  describe '#tagify_links' do
    def tags_with(options)
      PaginationRenderer.new(renderer, options).tagify_links
    end

    context 'first page' do
      subject { tags_with :num_pages => 10, :current_page => 1 }
      it { should_not contain_tag PrevLink }
      it { should contain_tag PrevSpan }
      it { should contain_tag CurrentPage }
      it { should_not contain_tag FirstPageLink }
      it { should contain_tag LastPageLink }
      it { should contain_tag PageLink }
      it { should contain_tag NextLink }
      it { should_not contain_tag NextSpan }
      it { should contain_tag TruncatedSpan }
    end

    context 'second page' do
      subject { tags_with :num_pages => 10, :current_page => 2 }
      it { should contain_tag PrevLink }
      it { should_not contain_tag PrevSpan }
      it { should contain_tag CurrentPage }
      it { should contain_tag FirstPageLink }
      it { should contain_tag LastPageLink }
      it { should contain_tag PageLink }
      it { should contain_tag NextLink }
      it { should_not contain_tag NextSpan }
      it { should contain_tag TruncatedSpan }
    end

    context 'third page' do
      subject { tags_with :num_pages => 10, :current_page => 3 }
      it { should contain_tag PrevLink }
      it { should_not contain_tag PrevSpan }
      it { should contain_tag CurrentPage }
      it { should contain_tag FirstPageLink }
      it { should contain_tag LastPageLink }
      it { should contain_tag PageLink }
      it { should contain_tag NextLink }
      it { should_not contain_tag NextSpan }
      it { should contain_tag TruncatedSpan }
    end

    context 'fourth page(no truncation)' do
      subject { tags_with :num_pages => 10, :current_page => 4 }
      it { should contain_tag PrevLink }
      it { should_not contain_tag PrevSpan }
      it { should contain_tag CurrentPage }
      it { should contain_tag FirstPageLink }
      it { should contain_tag LastPageLink }
      it { should contain_tag PageLink }
      it { should contain_tag NextLink }
      it { should_not contain_tag NextSpan }
      it { should_not contain_tag TruncatedSpan }
    end

    context 'seventh page(no truncation)' do
      subject { tags_with :num_pages => 10, :current_page => 7 }
      it { should contain_tag PrevLink }
      it { should_not contain_tag PrevSpan }
      it { should contain_tag CurrentPage }
      it { should contain_tag FirstPageLink }
      it { should contain_tag LastPageLink }
      it { should contain_tag PageLink }
      it { should contain_tag NextLink }
      it { should_not contain_tag NextSpan }
      it { should_not contain_tag TruncatedSpan }
    end

    context 'eighth page' do
      subject { tags_with :num_pages => 10, :current_page => 8 }
      it { should contain_tag PrevLink }
      it { should_not contain_tag PrevSpan }
      it { should contain_tag CurrentPage }
      it { should contain_tag FirstPageLink }
      it { should contain_tag LastPageLink }
      it { should contain_tag PageLink }
      it { should contain_tag NextLink }
      it { should_not contain_tag NextSpan }
      it { should contain_tag TruncatedSpan }
    end

    context 'last page' do
      subject { tags_with :num_pages => 10, :current_page => 10 }
      it { should contain_tag PrevLink }
      it { should_not contain_tag PrevSpan }
      it { should contain_tag CurrentPage }
      it { should contain_tag FirstPageLink }
      it { should_not contain_tag LastPageLink }
      it { should contain_tag PageLink }
      it { should_not contain_tag NextLink }
      it { should contain_tag NextSpan }
      it { should contain_tag TruncatedSpan }
    end
  end
end