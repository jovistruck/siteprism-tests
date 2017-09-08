require 'capybara'

case ENV['TARGET']
  when 'journal-suggester-live' then
    Capybara.app_host = 'http://journal-suggester-web.live.cf.private.springer.com/'
    puts "\n>>>> ENVIRONMENT = transfer-desk-live <<<<\n\n"
  when 'transfer-desk-live' then
    Capybara.app_host = 'http://transfer-desk.live.cf.private.springer.com/'
    puts "\n>>>> ENVIRONMENT = journal-suggester-live <<<<\n\n"
  when 'transfer-desk-staging' then
    Capybara.app_host = 'http://transfer-desk-staging.live.cf.private.springer.com/'
    puts "\n>>>> ENVIRONMENT = transfer-desk-staging <<<<\n\n"
end


$articles_data=YAML.load_file(File.dirname(__FILE__) + '/../../resources/test-data/journals/' + "articles.yml")
$excluded_articles_data=YAML.load_file(File.dirname(__FILE__) + '/../../resources/test-data/excluded_journals/' + "articles.yml")