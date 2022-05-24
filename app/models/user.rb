class User < ApplicationRecord
  has_many :party_users
  has_many :parties, through: :party_users

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
  validates_presence_of :name
  has_secure_password


  def invited_parties
    parties.where.not(host: self.id)
  end

  def hosted_parties
    parties.where(host: self.id)
  end

end
