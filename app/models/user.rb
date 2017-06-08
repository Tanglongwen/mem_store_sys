class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :score_histories
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
