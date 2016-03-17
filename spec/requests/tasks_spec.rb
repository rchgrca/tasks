require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  before do
    @task = Task.create :task => 'go to bed'
  end

  describe "GET /tasks" do
    it "displays some tasks" do
      visit tasks_path
      expect(page).to have_content 'go to bed'
      # expect(response).to have_http_status(200)
    end

    it "creates a new task" do
      visit tasks_path
      fill_in 'Task', :with => 'go to work'
      click_button 'Create Task'
      expect(current_path).to eq(tasks_path)
      # current_path.should == tasks_path
      save_and_open_page
    end
  end

  describe "PUT /tasks" do
    it "edits a task" do
      visit tasks_path
      click_on 'Edit'
      #current_path.should == edit_tasks_path()
      expect(current_path).to eq(edit_task_path(@task))

      save_and_open_page
      #expect(page).to have_content 'go to bed'
      #find_field(’Task’).value.should == ‘go to bed’
      expect(find_field('Task').value).to eq('go to bed')

      fill_in 'Task', :with => 'updated task'
      click_button 'Update Task'

      expect(current_path).to eq(tasks_path)
      expect(page).to have_content 'updated task'
    end

    it "should not update an empty task"  do
      visit tasks_path
      click_on 'Edit'

      fill_in 'Task', :with => ''
      click_on 'Update Task'

      expect(current_path).to eq(edit_task_path(@task))
      expect(page).to have_content 'There was an error updating your task'
    end
  end

  describe "DELETE /tasks" do
    it "should delete a task" do
      visit tasks_path
      find('#task_' + @task.id.to_s).click_on 'Delete'
      expect(page).to have_content 'Task has been deleted'
      expect(page).to_not have_content 'go to bed'
    end
  end

end
