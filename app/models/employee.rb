class Employee < ApplicationRecord
  belongs_to :company, touch: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company, presence: true
  
  after_create :expire_cache
  after_update :expire_cache
  before_destroy :expire_cache

  def to_s
    "#{first_name} #{last_name}"
  end

  def expire_cache
    ActionController::Base.new.expire_fragment('table_of_all_companies')
  end
end
