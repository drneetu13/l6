class TodosController < ApplicationController

  def index
    @todos = Todo.of_user(current_user)
    render "index"
  end

  def show
    render plain: Todo.of_user(current_user).find(params[:id]).to_displayable_string
  end

  def update
    begin
      todo = Todo.of_user(current_user).updateTask(params[:id], params[:completed])
    rescue => exception
    end

    redirect_to todos_path
  end

  def delete
    begin
      todo = Todo.of_user(current_user).find(params[:id])
      todo.destroy
    rescue => exception
    end

    redirect_to todos_path
  end

  def create
    newTodo =  Todo.new(todo_text: params[:todo_text], due_date: params[:due_date], completed: false, user_id: current_user.id)
    if !newTodo.save
      flash[:error] = newTodo.errors.full_messages.join(', ')
    end
    redirect_to todos_path
  end
end
