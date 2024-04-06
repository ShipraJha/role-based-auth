class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
    @resources = Resource.all
  end

  def show
    unless @current_user.has_access?('READ')
      flash[:alert] = "You don't have access to view this resource."
      redirect_to resources_path
    end
  end

  def new
    @resource = Resource.new
    unless @current_user.has_access?('WRITE')
      flash[:alert] = "You don't have access to create a new resource."
      redirect_to resources_path
    end
  end

  def edit
    unless @current_user.has_access?('WRITE')
      flash[:alert] = "You don't have access to edit this resource."
      redirect_to resources_path
    end
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to @resource, notice: 'Resource was successfully created.'
    else
      render :new
    end
  end

  def update
    if @resource.update(resource_params)
      redirect_to @resource, notice: 'Resource was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    unless @current_user.has_access?('DELETE')
      flash[:alert] = "You don't have access to delete this resource."
      redirect_to resources_path
    else
      @resource.destroy
      redirect_to resources_url, notice: 'Resource was successfully destroyed.'
    end
  end

  private
  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:name)
  end
end
