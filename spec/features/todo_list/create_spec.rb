require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})
		options[:title] ||= "Todo"
		options[:description] ||= "description"

		visit "/todo_lists"
		click_link "New Todo list"

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]

		click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do

		create_todo_list title: "My todo list"

		expect(page).to have_content("My todo list")

		expect(TodoList.count).to eq(1)
	end

	it "will display an error if title is blank" do

		create_todo_list title: ""

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("What i have to do today")


		expect(TodoList.count).to eq(0)
	end

	it "will display an error if the title is too short" do

		create_todo_list title: "hi"
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("hi")

		expect(TodoList.count).to eq(0)
		
	end

	it "will display an error if description is blank" do

		create_todo_list description: ""

		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("What i have to do today")


		expect(TodoList.count).to eq(0)
	end

	it "will display an error if the description is too short" do

		create_todo_list description: "hi"
		expect(page).to have_content("error")

		expect(TodoList.count).to eq(0)
		
	end
end