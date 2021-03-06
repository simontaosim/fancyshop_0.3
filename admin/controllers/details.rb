Fancyshpv2::Admin.controllers :details do
  get :index do
    @title = "Details"
    @details = Detail.all
    render 'details/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'detail')
    @detail = Detail.new
    render 'details/new'
  end

  post :create do
    @detail = Detail.new(params[:detail])
    if @detail.save
      @title = pat(:create_title, :model => "detail #{@detail.id}")
      flash[:success] = pat(:create_success, :model => 'Detail')
      params[:save_and_continue] ? redirect(url(:details, :index)) : redirect(url(:details, :edit, :id => @detail.id))
    else
      @title = pat(:create_title, :model => 'detail')
      flash.now[:error] = pat(:create_error, :model => 'detail')
      render 'details/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "detail #{params[:id]}")
    @detail = Detail.find(params[:id])
    if @detail
      render 'details/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'detail', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "detail #{params[:id]}")
    @detail = Detail.find(params[:id])
    if @detail
      if @detail.update_attributes(params[:detail])
        flash[:success] = pat(:update_success, :model => 'Detail', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:details, :index)) :
          redirect(url(:details, :edit, :id => @detail.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'detail')
        render 'details/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'detail', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Details"
    detail = Detail.find(params[:id])
    if detail
      if detail.destroy
        flash[:success] = pat(:delete_success, :model => 'Detail', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'detail')
      end
      redirect url(:details, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'detail', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Details"
    unless params[:detail_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'detail')
      redirect(url(:details, :index))
    end
    ids = params[:detail_ids].split(',').map(&:strip)
    details = Detail.find(ids)
    
    if details.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Details', :ids => "#{ids.to_sentence}")
    end
    redirect url(:details, :index)
  end

   get :get_country_select do
    if params[:planet_id]!=''
      @countries = Country.where(:planet_id =>Planet.find(params[:planet_id]).id).to_json
    else
      nil.to_json
    end
  end

    get :get_province_select do
    if params[:country_id]!=''
      @provinces = Province.where(:country_id => Country.find(params[:country_id]).id).to_json
    else
      nil.to_json
    end
  end

    get :get_city_select do
        if params[:province_id]!=''
      @cities = City.where(:province_id => Province.find(params[:province_id]).id).to_json
      else
      nil.to_json
      end
    end

     get :get_area_select do
      if params[:city_id]!=''
        @areas = Area.where(:city_id => City.find(params[:city_id]).id).to_json
      else
        nil.to_json
      end
    end

    get :get_street_select do
     if params[:area_id]!=''
        @streets = Street.where(:area_id => Area.find(params[:area_id]).id).to_json
      else
        nil.to_json
      end
    end
    
    get :create_remote do
    end
end
