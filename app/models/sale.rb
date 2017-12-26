class Sale < ApplicationRecord
  belongs_to :client #pertenço_a
  belongs_to :user
  belongs_to :discount
  has_many :product_quantities #tenho_varios
  has_one :comission #tenho_um

  after_save do #depois que salvar faça isso
    calc = 0
    # Soma o preço dos produtos vezes a quantidade deles
    self.product_quantities.each {|p| calc += p.product.price * p.quantity}
    # Verifica se existe um desconto e aplica caso exista
    if self.discount
      if self.discount.kind == "porcent"
        calc -= calc / self.discount.value
      elsif self.discount.kind == "money"
        calc -= self.discount.value
      end
    end

    # Verifica se já existe uma comissão, caso sim atualiza, caso não cria uma nova.
    if self.comission.present?
      self.comission.update(value: (calc * 0.1), status: :pending) #self.user.comission
    else
      Comission.create(value: (calc * 0.1), user: self.user, sale: self, status: :pending)
    end
  end
end
