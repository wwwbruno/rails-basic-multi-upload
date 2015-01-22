class UploadsController < ApplicationController

  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
    end
  end

  def create
    @upload = Upload.new(upload_params)

    respond_to do |format|
      if @upload.save
        format.html {
          render :json => [@upload.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@upload.to_jq_upload]}, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_params
    params.require(:upload).permit(:upload)
  end
end
