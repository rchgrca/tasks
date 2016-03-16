require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "displays some tasks" do
      get tasks_path
      page.should have_content 'go to bed'
      expect(response).to have_http_status(200)
    end
  end
end
