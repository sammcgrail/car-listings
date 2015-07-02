class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
  end


  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    if @manufacturer.save
      redirect_to manufacturers_path, notice: "Manufacturer was successfully created."
    else
      render :new, notice: "Your manufacturer could not be saved."
    end
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name, :country)
  end

end
