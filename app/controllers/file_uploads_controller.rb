class FileUploadsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_file_upload, only: [:show, :destroy, :share]

  
    def index
      @file_uploads = current_user.file_uploads
    end
  
    def new
      @file_upload = FileUpload.new
    end
    def show
        @file_upload = FileUpload.find(params[:id])
      end
      
    def create
      @file_upload = current_user.file_uploads.build(file_upload_params)
      if @file_upload.file.attached? && invalid_file_type?(@file_upload.file)
        flash.now[:alert] = "Invalid file type. Only images are allowed."
        render :new and return
      end
      if @file_upload.save
        flash[:notice] = "File uploaded successfully!"
        redirect_to file_uploads_path
        
      else
        flash.now[:alert] = "Failed to upload file. Please try again."
        render :new
      end
    end
  
    def destroy
        @file_upload = current_user.file_uploads.find_by(id: params[:id])
        if @file_upload
          @file_upload.destroy
          flash[:notice] = "File deleted successfully."
        else
          flash[:alert] = "File not found."
        end
        redirect_to file_uploads_path
    end
  
    def share
      render plain: "Publicly shared URL: #{request.base_url}/f/#{@file_upload.short_url}"
    end
  
    def public_view
      @file_upload = FileUpload.find_by!(short_url: params[:short_url])
      send_data @file_upload.file.download, filename: @file_upload.file.filename.to_s
    end

    def download
        file_upload = FileUpload.find(params[:id])
        if file_upload.present?
            flash[:notice] = "File downloaded successfully!"
            redirect_to rails_blob_path(file_upload.file, disposition: "attachment")
        end
    end
    private
  
    def set_file_upload
      @file_upload = current_user.file_uploads.find(params[:id])
    end
  
    def file_upload_params
      params.require(:file_upload).permit(:title, :description, :file)
    end

    def invalid_file_type?(file)
        allowed_types = ["image/png", "image/jpeg"]
        !allowed_types.include?(file.content_type)
    end
  end
  