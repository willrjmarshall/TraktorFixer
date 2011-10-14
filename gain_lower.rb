require 'nokogiri'
require 'sinatra'


get "/" do
  "Hello world"
end

get "/upload" do
  # Parse file, return a download link
end


def parse_file(file)
  "hello world"
  #n = Nokogiri::XML(File.open("Psybreaks.nml"))

  #n.xpath("//LOUDNESS").each do |loudness|
  #  adjusted_db = (loudness.attributes["PEAK_DB"].value.to_f - 3.0).to_s
  #  loudness.attributes["PEAK_DB"].value =  adjusted_db

  #  adjusted_db = (loudness.attributes["PERCEIVED_DB"].value.to_f - 3.0).to_s
  #  loudness.attributes["PERCEIVED_DB"].value =  adjusted_db

  #  adjusted_db = (loudness.attributes["ANALYZED_DB"].value.to_f - 3.0).to_s
  #  loudness.attributes["ANALYZED_DB"].value =  adjusted_db
  #end

  #File.open("adjusted_playlist.nml", "w") { |f| f.write(n.to_xml) }

end
