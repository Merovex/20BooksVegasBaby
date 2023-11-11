require 'yaml'
require 'active_support/core_ext/string/inflections'


# Load YAML file
videos = YAML.load_file('_data/videos.yml')

# Generate main videos page
File.open('videos.md', 'w') do |f|
  f.puts '---'
  f.puts 'title: All Videos'
  f.puts 'description: List of all video recordings'
  f.puts '---'
  f.puts "{% include list-videos.html videos=site.videos %}"
end

# Generate individual video pages
videos.each do |video|
  filename = video['title'].parameterize
  File.open("_videos/#{filename}.md", 'w') do |f|
    f.puts '---'
    f.puts YAML.dump(video).strip
    f.puts '---'
    f.puts '<iframe width="560" height="315" src="{{ page.link }}" frameborder="0" allowfullscreen></iframe>'
  end
end

# Generate category pages
categories = videos.map { |v| v['category'] }.uniq

categories.each do |cat|
  cat_videos = videos.select { |v| v['category'] == cat }
  File.open("videos-#{cat.parameterize}.md", 'w') do |f|
    f.puts '---'
    f.puts "title: '#{cat}' Videos"
    f.puts "description: #{cat} video recordings"
    f.puts '---'
    f.puts "{% include list-videos.html videos=#{cat_videos} %}"
  end
end

puts 'Generated video pages!'
