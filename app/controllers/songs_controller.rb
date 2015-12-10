class SongsController < ApplicationController
  #Necessary?
  #include AWS::S3

  def index
  	#@songs = AWS::S3::Bucket.find(ENV['BUCKET']).objects
    sc_client = SoundCloud.new( :client_id => '3ee351e7ff8a40cc7558c785b58b91e1' )
    @tracks = sc_client.get( '/tracks', :limit => 10, :genres => 'djent', :order => 'hotness' )

    @song_comments = []
    @tracks.each do |track|
        @song_comments << sc_client.get( "/tracks/#{track.id}/comments", :limit => 1 )
    end
  end

  def upload
  	begin
		AWS::S3::S3Object.store(sanitize_filename(params[:mp3file].original_filename), params[:mp3file].read, ENV['BUCKET'], :access => :public_read)
  		redirect_to root_path
  	rescue
  		render :text => "Couldn't complete the upload"
  	end
  end

  def delete
  	if (params[:song])
  		AWS::S3::S3Object.find(params[:song], ENV['BUCKET']).delete
  		redirect_to root_path
  	else
  		render :text => "No song was found to delete!"
  	end
  end

  private

  def sanitize_filename(file_name)
  	just_filename = File.basename(file_name)
  	just_filename.sub(/[^\w\.\-]/, '_')
  end
end
