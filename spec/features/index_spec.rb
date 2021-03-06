require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe "Index Page" do
	let(:content)  { "this is the content" }
	let(:title)    { "this is the title" }
	let!(:question) { Question.create(content: content, title: title) }
	let(:email) {"test@test.com"}
	let(:password) {"12345678"}

	before(:each) do
		visit new_user_registration_path
		fill_in 'Email', with: email
		fill_in 'Password', with: password
		fill_in 'Confirm Password', with: password
		click_button "Sign up"
	end

	context "link to create new question" do 
		it "should have the link to create a new question" do 
			expect(page).to have_link "New Question"
		end

		it "should take you to the new question route" do
			visit questions_path
			click_link('New Question')
			expect(page).to have_content "New Question Form"
		end
	end

	context "link to view the question show page" do 
		it "should have the link for the question created" do 
			visit questions_path
			page.should have_selector(:link, title)
		end

		it "should take you to the question show page" do 
			visit questions_path
			click_link(title)
			expect(page).to have_content "this is the content"
			expect(page).to have_content "this is the title"
		end
	end

	context "form to create a new question" do 
		it "should fill out the form and show the new question page" do
			visit new_question_path
			fill_in 'title', :with => "this is the title"
			fill_in 'content', :with => "this is the content"
			attach_file 'image', Rails.root.join('app', 'assets', 'images', 'rails.png')
			click_on 'Submit Question'
			expect(page).to have_content "this is the title"
			expect(page).to have_content "this is the content"
		end
	end

	context "Index page layout" do
		before(:each) do
			visit new_question_path
		end

		it "should have awesome header" do
			expect(page).to have_content("DO I LOOK FAT IN DIS??")
		end

		it "should have subheader of form" do
			expect(page).to have_content("New Question Form")
		end
	end

end
