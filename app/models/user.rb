class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
         :lockable, :timeoutable, :trackable

  enum gender: { unanswered: 0, male: 1, female: 2 }

  # INFO: ユーザ新規登録時のメールアドレス確認をスキップ
  before_validation :skip_confirmation!, if: :new_record?

  validates :nickname, presence: true
  validates :gender, presence: true

  has_one :user_information, dependent: :destroy
  has_one :user_mobile_phone, dependent: :destroy

  class << self
    def genders_i18n
      I18n.t('enums.user.gender')
    end
  end
end
