class SectorsController < ApplicationController
  before_action :set_sector, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:index, :show, :destroy, :create, :update]
  respond_to :html, :json
  # GET /sectors
  # GET /sectors.json
  def index
    @sector = Sector.all
     respond_with(@sectors) do |format|
      format.json { render :json => @sector.as_json }
      format.html
    end
  end

  # GET /sectors/1
  # GET /sectors/1.json
  def show
    respond_with(@sector.as_json)
  end

  # GET /sectors/new
  def new
    @sector = Sector.new
  end

  # GET /sectors/1/edit
  def edit
  end

  # POST /sectors
  # POST /sectors.json
  def create
    @sector = Sector.new(sector_params)
    if @sector.save
      render json: @sector.as_json, status: :ok
    else
      render json: {sector: @sector.errors, status: :no_content}
    end
  end

  # PATCH/PUT /sectors/1
  # PATCH/PUT /sectors/1.json
  def update
     if @sector.update_attributes(sector_params)
      render json: @sector.as_json, status: :ok 
    else
      render json: {sector: @sector.errors, status: :unprocessable_entity}
    end
  end

  # DELETE /sectors/1
  # DELETE /sectors/1.json
  def destroy
    @sector.destroy
    respond_to do |format|
      format.html { redirect_to sectors_url, notice: 'Sector was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sector
      @sector = Sector.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sector_params
      params.require(:sector).permit(:name, :status)
    end
end
