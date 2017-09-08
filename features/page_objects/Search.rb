class Search < SitePrism::Page
  set_url "/"

  # Submit Form Elements
  element :title_field, :id, "title"
  element :body_field, :id, "content"
  element :keywords_field, :id, "keywords"
  element :minimum_impact_field, :id, "minImpactFactor"
  element :maximum_impact_field, :id, "maxImpactFactor"
  element :primary_subject_field, "select#primary-subject"
  element :secondary_subjects_field, "select#secondary-subjects"
  element :find_journals_button, :id, "suggest"

  # Journal Suggestion Results Table
  ## Table
  element :results_table, :css, "#suggestions #search-results .table"
  element :name_table_header, :css, "#suggestions #search-results table.table-striped>thead>tr>th:nth-child(1)"
  element :impact_factor_table_header, :css, "#suggestions #search-results table.table-striped>thead>tr>th:nth-child(2)"
  element :access_type_table_header, :css, "#suggestions #search-results table.table-striped>thead>tr>th:nth-child(3)"
  elements :results_table_rows, :css, "#suggestions #search-results table.table-striped>tbody>tr"
  elements :mega_journals_table_rows, :css, "#suggestions #mega-journals-results table.table-striped>tbody>tr"
  elements :journal_names_in_results, :css, "#suggestions #search-results .result-row>td>a"
  elements :journal_impact_factor_in_results, :css, "#suggestions #search-results .result-row>td:nth-child(2)"

  ## Show More Copy Message Template Buttons
  element :show_more_button, :id, "show-more"
  element :copy_to_clipboard_button, :id, "copy-button"


  ## Message Template
  element :message_template_button, :id, "message-template-button"
  element :close_message_template_button, :id, "close-msg-template-button"
  element :message_template_modal_header, :css, "div.modal-header"
  element :message_template_text, :id, "message-text"

  ## Select Check Boxes Journals
  elements :select_checkboxes_table, :css, "#suggestions #search-results [name='selectedJournals']"

  # Header Section
  section :header, HeaderSection, ".nav.navbar-nav"

  # Selected Journals
  elements :suggestions_check_boxes, :css, "#suggestions #search-results [name='selectedJournals']"

end
