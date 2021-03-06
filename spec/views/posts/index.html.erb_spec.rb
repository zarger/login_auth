require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/posts/index.html.erb" do
  include PostsHelper
  
  before(:each) do
    assigns[:posts] = [
      stub_model(Post,
        :title => "value for title",
        :body => "value for body",
        :user_id => 1
      ),
      stub_model(Post,
        :title => "value for title",
        :body => "value for body",
        :user_id => 1
      )
    ]
  end

  it "should render list of posts" do
    render "/posts/index.html.erb"
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for body".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end

