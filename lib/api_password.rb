# frozen_string_literal: true

require 'digest/md5'

module ApiPassword
  def self.create(secret, token)
    Digest::MD5.hexdigest("#{token}#{secret}")
  end
end