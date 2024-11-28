class SquareNumbers
  def initialize(input_file, output_file)
    @input_file = input_file
    @output_file = output_file
    @threads = []
  end

  def process
    File.open(@input_file, 'r') do |reader|
      reader.each_line do |line|
        @threads << Thread.new(line.strip.to_i) do |number|
          square = calculate_square(number)
          write_to_file(square)
        end
      end
    end

    @threads.each(&:join)
  end

  private

  def calculate_square(number)
    number ** 2
  end

  def write_to_file(square)
    File.open(@output_file, 'a') do |writer|
      writer.puts(square)
    end
  end
end

input_file = 'nums.txt'
output_file = 'res.txt'

File.open(input_file, 'w') do |file|
  (1..10).each { |n| file.puts(n) }
end

p = SquareNumbers.new(input_file, output_file)
p.process

puts "Результат записано #{output_file}."
