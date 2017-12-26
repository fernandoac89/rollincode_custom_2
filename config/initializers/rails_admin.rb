RailsAdmin.config do |config|

  require Rails.root.join('lib', 'rails_admin', 'rails_admin_pdf.rb')
    RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::Pdf)

config.main_app_name = ["WebRep","Unifik Tecnologia"]

config.navigation_static_links = { #adiciona links ao projeto
  'Unifik Tecnologia' => 'http://www.unifik.com.br'
}
config.navigation_static_label = "Links úteis"

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan
#  config.authorize_with do
  #if current_user.kind != 'salesman' and current_user.kind != 'manager'
#    reset_session
 #end
# end

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true



  config.model Sale do
    navigation_icon 'fa fa-money '
  create do
    field  :client
    field  :sale_date
    field  :discount
    field  :notes
    field  :product_quantities

    field :user_id, :hidden do
      default_value do
        bindings[:view]._current_user.id #vai buscar o usuario logado e colocar na venda
      end
    end
  end

  edit do
    field  :client
    field  :sale_date
    field  :discount
    field  :notes
    field  :product_quantities

    field :user_id, :hidden do
      default_value do
        bindings[:view]._current_user.id
      end
    end
  end
end

config.model Product do
create do
  field  :name
  field  :description
  field  :status
  field  :price
  field  :photo


end

edit do
  field  :name
  field  :description
  field  :status
  field  :price
  field  :photo


end
end

config.model Client do
  navigation_icon 'fa fa-users '
  create do
    field  :name
    field  :company_name
    field  :document
    field  :email
    field  :phone
    field  :notes
    field  :status
    field  :address

    field :user_id, :hidden do
      default_value do
        bindings[:view]._current_user.id
      end
    end
  end

  edit do
    field  :name
    field  :company_name
    field  :document
    field  :email
    field  :phone
    field  :notes
    field  :status
    field  :address


    field :user_id, :hidden do
      default_value do
        bindings[:view]._current_user.id
      end
    end
  end

  list do
    field  :name
    field  :company_name
    field  :document
    field  :email
    field  :phone
    field  :notes
    field  :status
    field  :address

  end
end


config.model Discount do #config do model. Parent (pai) é o Produto. Produto dentro de desconto
  navigation_icon 'fa-percent '
  parent Product
end

config.model Sale do #pai é o User
  parent User
  weight -2 #ajuda a organizar a ordem. é o peso. Quanto mais negativo, mais pra cima ele fica no menu
end

config.model Comission do
  navigation_icon 'fa-usd '
  parent User
  weight -1
end

config.model Client do
  parent User
end

config.model ProductQuantity do
  visible false
end

config.model Address do
  visible false
end




config.model ProductQuantity do
  visible false
end

config.model Address do
  visible false
end

config.model ProductQuantity do
  edit do
    field :product
    field :quantity

    field :user_id, :hidden do
      default_value do
        bindings[:view]._current_user.id
      end
    end
  end
end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    pdf do
      only User
    end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
