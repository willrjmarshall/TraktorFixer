require 'nokogiri'
require 'sinatra'


get "/" do
  haml :index
end

post "/upload" do
  #begin
    playlist = params[:playlist][:tempfile]
    updated_file = parse_file(playlist)
    send_file(updated_file, :disposition => 'attachment', :filename => "test.nml")
  #rescue
   # "Your file was broken or something. Try exporting another one!"
  #end
end


def parse_file(file)
  n = Nokogiri::XML(file.read)

  tempfile = Tempfile.new("temporary_file.txt", "/tmp")
  
  n.xpath("//LOUDNESS").length.to_s

  n.xpath("//LOUDNESS").each do |loudness|
    adjusted_db = (loudness.attributes["PEAK_DB"].value.to_f - 3.0).to_s
    loudness.attributes["PEAK_DB"].value =  adjusted_db

    adjusted_db = (loudness.attributes["PERCEIVED_DB"].value.to_f - 3.0).to_s
    loudness.attributes["PERCEIVED_DB"].value =  adjusted_db

    adjusted_db = (loudness.attributes["ANALYZED_DB"].value.to_f - 3.0).to_s
    loudness.attributes["ANALYZED_DB"].value =  adjusted_db
  end

  File.open(tempfile, "w") { |f| f.write(n.to_xml) }
  tempfile
end
