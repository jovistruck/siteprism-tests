Given(/^I am on the find journals page$/) do
  $app = App.new
  $app.search.load
end

