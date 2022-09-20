class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
         :lockable, :timeoutable, :trackable

  enum gender: { unanswered: 0, make: 1, female: 2 }

  validates :nickname, presence: true
  validates :gender, presence: true, inclusion: { in: User.genders.keys }

  class << self
    def genders_i18n
      I18n.t('enums.user.gender')
    end
  end
end
