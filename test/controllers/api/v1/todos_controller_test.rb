require 'test_helper'

class Api::V1::TodosControllerTest < ActionController::TestCase
	def json_response
		ActiveSupport::JSON.decode @response.body
	end

  context "get todos#index" do
	  setup { get :index }

	  should respond_with(:ok)

		should "respond with all todos" do
			@todos = {}
			@todos["todos"] = Todo.all.as_json
			assert_equal @todos, json_response
		end
  end

	context "post todos#create" do
		setup { post :create, { title: "Test title", order: 1, completed: false } }

		should respond_with(:created)

		should "assign a todo object" do
			assert_not_nil assigns[:todo], "should assign a todo object"
		end

		should "save todo object to db" do
			assert assigns[:todo].persisted?, "should save todo object to db"
		end
	end

	context "delete todos#destroy" do
		setup { delete :destroy, { id: todos(:one).id }}

		should respond_with(:ok)

		should "destroy the todo object" do
			assert_raises ActiveRecord::RecordNotFound do
				Todo.find(todos(:one).id)
			end
		end
	end
end
