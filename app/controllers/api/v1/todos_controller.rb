class Api::V1::TodosController < ApplicationController
	before_filter :load_todo, only: [:destroy, :update]

	def index
		@todos = Todo.all
		render json: @todos, status: :ok
	end

	def create
		@todo = Todo.new(todo_params)
		if @todo.save
			render json: @todo, status: :created
		else
			render json: {errors: @todo.errors}, status: :bad_request
		end
	end

	def destroy
		if @todo.destroy
			render nothing: true, status: :ok
		else
			render json: {errors: @todo.errors}, status: :bad_request
		end
	end

	def update
		if @todo.update(todo_params)
			render json: @todo, status: :ok
		else
			render json: {errors: @todo.errors}, status: :bad_request
		end
	end

	private

	def todo_params
		params.permit(:title, :order, :completed)
	end

	def load_todo
		@todo = Todo.find(params[:id])
	end
end
