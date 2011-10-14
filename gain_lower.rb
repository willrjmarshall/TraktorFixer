require 'nokogiri'
require 'sinatra'


get "/" do
  haml :index
end

post "/upload" do
  if params[:playlist]
    begin
      playlist = params[:playlist][:tempfile]
      new_filename = generate_filename(params[:playlist][:filename])
      gain_adjust = params[:gain].to_f

      updated_file = parse_file(playlist, gain_adjust)

      send_file(updated_file, :disposition => 'attachment', :filename => new_filename)
    rescue
      "Your file was broken or something. Try exporting another one!"
    end
  else
    "You need to upload a playlist!"
  end
end

def generate_filename(filename)
  "Updated" + filename
end

def parse_file(file, gain_adjust)
  n = Nokogiri::XML(file.read)

  tempfile = Tempfile.new("temporary_file.txt", "/tmp")
  
  n.xpath("//LOUDNESS").length.to_s

  n.xpath("//LOUDNESS").each do |loudness|
    adjusted_db = (loudness.attributes["PEAK_DB"].value.to_f - gain_adjust).to_s
    loudness.attributes["PEAK_DB"].value =  adjusted_db

    adjusted_db = (loudness.attributes["PERCEIVED_DB"].value.to_f - gain_adjust).to_s
    loudness.attributes["PERCEIVED_DB"].value =  adjusted_db

    adjusted_db = (loudness.attributes["ANALYZED_DB"].value.to_f - gain_adjust).to_s
    loudness.attributes["ANALYZED_DB"].value =  adjusted_db
  end

  File.open(tempfile, "w") { |f| f.write(n.to_xml) }
  tempfile
end
