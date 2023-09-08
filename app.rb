# frozen_string_literal: true

require 'awesome_print'
require 'thor'
require_relative 'app/client_explorer'

class App < Thor
  desc 'list', 'List all clients'
  option :file_path, type: :string, default: File.join('app', 'data', 'clients.json'),
                     desc: 'Specify the JSON file to use'
  def list
    file_path = determine_file_path(options[:file_path])
    options = { file_path: }
    ap ClientExplorer.new(options).list
  end

  desc 'search [FIELD] VALUE', 'Search clients by a specific field and value (default: full_name)'
  option :file_path, type: :string, default: File.join('app', 'data', 'clients.json'),
                     desc: 'Specify the JSON file to use'
  option :search_field, type: :string, default: 'full_name', desc: 'Specify the search field'
  def search(value = '')
    file_path = determine_file_path(options[:file_path])
    search_field = determine_search_field(options[:search_field])
    options = { file_path:, search_field: }
    ap ClientExplorer.new(options).search(value)
  end

  desc 'list_duplicates', 'List clients with duplicate emails'
  option :file_path, type: :string, default: File.join('app', 'data', 'clients.json'),
                     desc: 'Specify the JSON file to use'
  def list_duplicates
    file_path = determine_file_path(options[:file_path])
    options = { file_path: }
    ap ClientExplorer.new(options).list_duplicates
  end

  private

  def determine_file_path(default_path)
    return default_path if default_path

    file_path = ask('Enter the JSON file path (or press Enter to use default):')
    file_path.empty? ? default_path : file_path
  end

  def determine_search_field(default_search_field)
    return default_search_field if default_search_field

    search_field = ask('Enter the search field (or press Enter to use default):')
    search_field.empty? ? default_search_field : search_field
  end
end

App.start
