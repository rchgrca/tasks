class TasksController < ApplicationController

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def create
    #render :text => params.inspect
    # Task.create params[:task]
    Task.create task_params
    # Task.create :task => 'this is a test'
    redirect_to :back
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    task = Task.find params[:id] #to DB
    if task.update_attributes task_params
      redirect_to tasks_path,
      :notice => 'Your task has been successfully updated'
    else
      redirect_to :back, :notice => 'There was an error updating your task'
    end
  end

  def destroy
    Task.destroy params[:id]
    redirect_to :back, :notice => 'Task has been deleted'
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def task_params
      params.require(:task).permit(:task)
    end
end
