class TodosController < ApplicationController

  def index
    # render plain: Todo.to_displayable_list.join("\n")
    render "index"
  end

  def show
    render plain: Todo.find(params[:id]).to_displayable_string
  end

  def update
    Todo.updateTask(params[:id], params[:completed])

    redirect_to todos_path
  end

  def delete
    Todo.find(params[:id]).destroy

    redirect_to todos_path
  end

  def create
    Todo.createTask({ :text => params[:todo_text], :due => DateTime.parse(params[:due_date]), :completed => false })

    redirect_to todos_path
  end
end
