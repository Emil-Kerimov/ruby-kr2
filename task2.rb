require 'net/http'
require 'uri'
require 'thread'

def fetch_url(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  puts "Запит до #{url} успішно виконано. Розмір відповіді: #{response.length} байт."
rescue StandardError => e
  puts "Помилка при запиті до #{url}: #{e.message}"
end

urls = [
  'http://www.youtube.com/',
  'http://google.com',
  'https://www.netflix.com/ua/'
]

threads = urls.map do |url|
  Thread.new do
    fetch_url(url)
  end
end

threads.each(&:join)

puts 'Запити виконано.'
