require 'spec_helper'

describe "Editing todo lists" do
	let(:todo_list) {TodoList.create title: "Todo", description: "Todo stuff here"}

	def update_todo_list(options={})
		options[:title] ||= "Todo"
		options[:description] ||= "description"

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: "New Title"
		fill_in "Description", with: "New description"
		click_button "Update Todo list"
	end

	it "updates a todo list with correct info" do	

		expect(page).to have_content("updated")

		todo_list.reload

		expect(todo_list.title).to eq("New Title")
		expect(todo_list.description).to eq("New description")
	end
end