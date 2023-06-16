class MyApp < InsalesApi::App
  class << self
    def install(shop, token, insales_id)
      return true if existed_account(shop)

      password = ApiPassword.create(::API_SECRET, token)
      Account.new(
        insales_subdomain: shop,
        password:,
        insales_id:
      ).save
    end

    def uninstall(shop, password)
      account = existed_account(shop)
      return true unless account
      return if account.password != password

      account.destroy
    end

    def prepared_domain(shop_domain)
      self.prepare_domain(shop_domain)
    end

    def existed_account(shop)
      Account.find_by(insales_subdomain: prepared_domain(shop))
    end
  end
end
