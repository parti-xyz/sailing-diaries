class ItemsController < ApplicationController
  def index
    @item = Item.order('RAND()').first
  end

  def show
    @item = Item.find(params[:id])
  end

  def random
    @item = Item.order('RAND()').where.not(id: params[:current_item_ids]).first
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    params[:item][:emotions].reject { |e| e.blank? }.each do |title|
      @item.emotions.build(title: title)
    end
    if @item.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to :index
  end

  private

  def item_params
    params.require(:item).permit(:content)
  end

end
