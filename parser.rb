require 'rubygems'
require 'nokogiri'

filename = ARGV[0]

puts "No file found" unless filename

begin
  f = File.open(filename)
rescue
  puts "Error reading filename #{filename}"
  exit
end

savefile = File.open("parsed.txt}", "w+")

doc = Nokogiri::XML(f)
smses = doc.xpath("//sms")
smses.each do |sms|
  body = sms['body']
  date = sms['readable_date']
  from = sms['address']
  contact_name = sms['contact_name']

  sms_message = "date: #{date}\n"
  sms_message += "from: '#{contact_name}'\n"
  sms_message += "number: #{from}\n"
  sms_message += "message: #{body}\n"
  sms_message += "\n----------------------------------------\n"

  savefile.write(sms_message)
end
f.close
savefile.close

exit