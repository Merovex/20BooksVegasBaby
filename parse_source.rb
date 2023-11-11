require 'csv'
require 'yaml'
require 'fileutils'

def get_year(s)
  results = s.match(/\d{4}/)
  return "" if results.nil?
  results[0]
end
def prune_title(s)
  s.gsub(/Vegas \d{4}\s+-\s+/,'')
end

# Define the file path
file_path = 'source.csv'

# Create a directory for the Jekyll data
Dir.mkdir('_data') unless Dir.exist?('_data')

# Initialize a hash to store the categorized data
categorized_data = {}

# Read and parse the CSV file
data = []
CSV.foreach(file_path, col_sep: "\t", headers: true) do |row|
  category = row['Category']
  categorized_data[category] ||= []

  next if category.nil? || category.strip.empty?

  categorized_data[category] << {'category' => category, 'title' => prune_title(row.to_h['Title']), 'link' => row.to_h['Link'], 'year' =>  get_year(row.to_h['Title']) }
  categorized_data[category] << {'category' => category, 'title' => prune_title(row.to_h['Title1']), 'link' => row.to_h['Link1'], 'year' =>  get_year(row.to_h['Title1'])}
  categorized_data[category] << {'category' => category, 'title' => prune_title(row.to_h['Title2']), 'link' => row.to_h['Link2'], 'year' =>  get_year(row.to_h['Title2'])}


  # Process each pair of title and link in the row, skipping the 'Category' field
  # row.to_h.each_slice(2).each do |(title_key, title), (link_key, link)|
  #   next if title.nil? || link.nil? || title.strip.empty? || link.strip.empty?

  #   # Append the data to the category array
  #   categorized_data[category] << { 'title' => title, 'link' => link }
  # end
end

# Convert the hash to YAML
yaml_data = categorized_data.to_yaml

# Write the YAML data to a file in the _data directory
File.open('_data/videos-1.yml', 'w') { |file| file.write(yaml_data) }

puts 'YAML file for Jekyll created successfully.'
