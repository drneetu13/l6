class TodosController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render plain: Todo.to_displayable_list.join("\n")
  end

  def show
    id = params[:id]
    render plain: Todo.find(id).to_displayable_string
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = Todo.find(id)
    todo.completed = completed
    todo.save!

    render plain: "Update todo completed status #{completed}"
  end

  def create
    text = params[:todo_text]
    due = DateTime.parse(params[:due_date])


    newTodo = Todo.create!(todo_text: text, due_date: due, completed: false)
    render plain: "Hey, Your new todo is created with the id #{newTodo.id}"

  end
end
