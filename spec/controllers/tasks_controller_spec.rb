require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all tasks as @tasks" do
      get :index
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: task.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: task.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) {
        { title: "New Task", description: "Task description", state: "Backlog", deadline: 1.day.from_now }
      }

      it "creates a new Task" do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to(Task.last)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) {
        { title: "", state: "Invalid", deadline: 1.day.ago }
      }
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: "Updated Task", state: "In-progress" }
      }

      it "updates the requested task" do
        put :update, params: { id: task.to_param, task: new_attributes }
        task.reload
        expect(task.title).to eq("Updated Task")
        expect(task.state).to eq("In-progress")
      end

      it "redirects to the task" do
        put :update, params: { id: task.to_param, task: new_attributes }
        expect(response).to redirect_to(task)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) {
        { title: "", state: "Invalid" }
      }

    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = create(:task, user: user)
      expect {
        delete :destroy, params: { id: task.to_param }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete :destroy, params: { id: task.to_param }
      expect(response).to redirect_to(tasks_url)
    end
  end
end