And(/^I submit a manuscript with doi id (.*)$/) do |doi_id|
  populate_and_submit_manuscript_suggest_form(doi_id)
  $app.search.wait_until_name_table_header_visible
end

And(/^I submit a manuscript from an excluded journal with doi id (.*)$/) do |doi_id|
  populate_and_submit_for_excluded_journal_in_suggest_form(doi_id)
  $app.search.wait_until_name_table_header_visible
end

Then(/^the results contain (.*) items$/) do |number_of_items|
  validate_results_table
  verify_number_of_results(number_of_items)
end

Then(/^the megajournals display (.*) items$/) do |number_of_items|
  verify_number_of_megajournals(number_of_items)
end

Then(/^the results contain items within the IF range (.*) and (.*)$/) do |min_IF,max_IF|
  validate_results_table
  verify_impact_factor(min_IF,max_IF)
end

Then(/^the corresponding journal for the manuscript with doi id (.*) is displayed$/) do |doi_id|
  verify_results_contain_journal($articles_data["manuscripts"][doi_id]["journal"])
end

Then(/^the excluded journal for the manuscript with doi id (.*) is not displayed$/) do |doi_id|
  verify_results_excludes_journal($excluded_articles_data["manuscripts"][doi_id]["journal"])
end

And(/^I submit a manuscript$/) do
  @randomly_picked_article=$articles_data["manuscripts"].keys.sample
  populate_and_submit_manuscript_suggest_form(@randomly_picked_article)
  $app.search.wait_until_name_table_header_visible
  if get_number_of_results > 9
    $app.search.show_more_button.click
  end
end

Then(/^the results contain the corresponding journal for the manuscript$/) do
  validate_results_table
  verify_results_contain_journal($articles_data["manuscripts"][@randomly_picked_article]["journal"])
end

And(/^I submit and validate results for all test manuscripts$/) do
  $articles_data["manuscripts"].keys.each do |manuscript_doi|
    populate_and_submit_manuscript_suggest_form(manuscript_doi)
    $app.search.wait_until_name_table_header_visible
    $app.search.wait_until_copy_to_clipboard_button_visible
    if get_number_of_results > 9
      $app.search.show_more_button.click
    end
    verify_results_contain_journal($articles_data["manuscripts"][manuscript_doi]["journal"])
    reload_page
  end
end

And(/^I want to see more suggestions$/) do
  $app.search.show_more_button.click
end

And(/^I select and copy the results (.*)$/) do |rows_to_select|
  rows_to_select.split(",").each do |selection_row|
    $app.search.suggestions_check_boxes[selection_row.to_i-1].click
  end
  step "I copy the results"
end

And(/^I do not select anything and copy the results$/) do

  step "I copy the results"
end


And(/^I copy the results$/) do

  $app.search.copy_to_clipboard_button.click
end

Then(/^the copy button indicates an? (unsuccessful|successful) copy$/) do |copy_button_has_tick|

  copy_button_has_tick == "successful" ? "green" : "red"

  if copy_button_has_tick == "green"
    $app.search.copy_to_clipboard_button.text.to end_with(" \u2705")
  elsif copy_button_has_tick == "red"
    $app.search.copy_to_clipboard_button.text.to end_with(" \u274c")
  end

end

And(/^I search a manuscript and copy some results$/) do
  # step "I navigate to the submit journal info page"
  step "I am on the find journals page"
  step "I submit a manuscript"
  results_count=get_number_of_results-1
  $selected_results_list=Array[*1..results_count].sample(rand(1..results_count))
  step "I select and copy the results #{$selected_results_list.join(",")}"
end

And(/^the message template (has|has no) content$/) do |has_content|

  sleep 2
  $app.search.message_template_button.click
  sleep 2
  expect($app.search).to have_message_template_modal_header

  if has_content == "has no"
    expect($app.search.message_template_text.text).to be_empty
  else
    print $app.search.message_template_text.text
    expect($app.search.message_template_text.text).not_to be_empty
  end

  $app.search.close_message_template_button.click
end

And(/^the link is correct for the corresponding journal for the manuscript with doi id (.*)$/) do |doi_id|
  verify_results_journal_link($articles_data["manuscripts"][doi_id]["journal"],$articles_data["manuscripts"][doi_id]["link"])
end

def reload_page
  $app.search.load
end

def populate_and_submit_manuscript_suggest_form (doi_id)
  $app.search.title_field.set $articles_data["manuscripts"][doi_id]["title"]
  $app.search.body_field.set $articles_data["manuscripts"][doi_id]["body"]
  $app.search.keywords_field.set $articles_data["manuscripts"][doi_id]["keywords"]
  $app.search.minimum_impact_field.set $articles_data["manuscripts"][doi_id]["minimum_impact_factor"]
  $app.search.maximum_impact_field.set $articles_data["manuscripts"][doi_id]["maximum_impact_factor"]
  unless $articles_data["manuscripts"][doi_id]["primary_subject"].nil?
    $app.search.primary_subject_field.select $articles_data["manuscripts"][doi_id]["primary_subject"]
  end
  unless $articles_data["manuscripts"][doi_id]["secondary_subjects"].nil?
    $app.search.secondary_subjects_field.select $articles_data["manuscripts"][doi_id]["secondary_subjects"]
  end
  $app.search.find_journals_button.click
end

def populate_and_submit_for_excluded_journal_in_suggest_form (doi_id)
  $app.search.title_field.set $excluded_articles_data["manuscripts"][doi_id]["title"]
  $app.search.body_field.set $excluded_articles_data["manuscripts"][doi_id]["body"]
  $app.search.keywords_field.set $excluded_articles_data["manuscripts"][doi_id]["keywords"]
  $app.search.maximum_impact_field.set $excluded_articles_data["manuscripts"][doi_id]["maximum_impact_factor"]
  unless $excluded_articles_data["manuscripts"][doi_id]["primary_subject"].nil?
    $app.search.primary_subject_field.select $excluded_articles_data["manuscripts"][doi_id]["primary_subject"]
  end
  unless $excluded_articles_data["manuscripts"][doi_id]["secondary_subjects"].nil?
    $app.search.secondary_subjects_field.select $excluded_articles_data["manuscripts"][doi_id]["secondary_subjects"]
  end
  $app.search.find_journals_button.click
end

def validate_results_table
  expect($app.search.name_table_header.text).to include("Name")
  expect($app.search.impact_factor_table_header.text).to include("Impact Factor")
  expect($app.search.access_type_table_header.text).to include("Open Access")
  expect($app.search).to have_copy_to_clipboard_button
  expect($app.search).to have_message_template_button
end

def verify_number_of_results (expected_number_of_results)
  expect(get_number_of_results).to eq(expected_number_of_results.to_i)
end

def verify_number_of_megajournals (expected_number_of_results)
  expect(get_number_of_mega_journal_results).to eq(expected_number_of_results.to_i)
end

def verify_impact_factor (min_impact_factor,max_impact_factor)
  $app.search.journal_impact_factor_in_results.each do |journal_if_result|
    if journal_if_result.text != ''
      expect(journal_if_result.text.to_f).to be > min_impact_factor.to_f
      expect(journal_if_result.text.to_f).to be < max_impact_factor.to_f
    end
  end
end

def get_number_of_results
  $app.search.results_table_rows.size
end

def get_number_of_mega_journal_results
  $app.search.mega_journals_table_rows.size
end

def verify_results_contain_journal (expected_journal_name)
  journal_names = Array.new
  $app.search.journal_names_in_results.each do |journal_name|
    journal_names.push(journal_name.text)
  end
  expect(journal_names).to include(expected_journal_name), "expected journal name \"#{expected_journal_name}\" in results #{journal_names}"
end

def verify_results_excludes_journal (expected_journal_name)
  journal_names = Array.new
  $app.search.journal_names_in_results.each do |journal_name|
    journal_names.push(journal_name.text)
  end
  expect(journal_names).not_to include(expected_journal_name), "expected journal name \"#{expected_journal_name}\" in results #{journal_names}"
end

def verify_results_journal_link (expected_journal_name,expected_journal_link)
  expect(find_link(expected_journal_name)[:href]).to eq(expected_journal_link), "expected journal link \"#{expected_journal_link}\" in results"
end