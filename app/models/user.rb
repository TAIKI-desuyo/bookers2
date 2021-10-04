class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  validates :name, presence: true, uniqueness: true,
      length: { minimum: 2, maximum: 20 }
  validates :introduction,length: {maximum: 50 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :books, dependent: :destroy
         has_many :book_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy

         has_many :relationships, foreign_key: :followed_id, dependent: :destroy
         has_many :followeds, through: :relationships, source: :follower

         has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
         has_many :followers, through: :reverse_of_relationships, source: :followed


         def is_followed_by?(user)
             reverse_of_relationships.find_by(followed_id: user.id).present?
         end
         
         attachment :profile_image


end
