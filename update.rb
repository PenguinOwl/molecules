# This program updates molecules from GitHub
unless ARGV[0] == '--noupdate' or ARGV[0] == '-nu'
  require 'open-uri'
  st = Time.now
  puts "Download started at " + st.to_s
  file = open('https://raw.githubusercontent.com/PenguinOwl/molecules/master/source.rb')
  et = Time.now
  puts "Download stopped at " + et.to_s
  contents = file.read
  Dir.chdir(ARGV[0])
  f2o = File.open('source.rb',"w+")
  curfile = []
  f.each_line do |line|
    curfile << line
  end
  curfile = curfile.join
  if curfile == contents
    puts "Up to date. Starting engine."
    system 'sudo #{ARGV[0]}source.rb'
    exit
  else
    curfile.truncate(0)
    f.each_line do |line|
      curfile.write(line)
    end
    puts "Updated. Starting engine."
    system 'sudo #{ARGV[0]}source.rb'
    exit
  end
end
system 'sudo #{ARGV[1]}source.rb'
