class Company < ApplicationRecord
  has_many :employees, dependent: :destroy
  validates :name,presence: true, uniqueness: true

  after_create :expire_cache
  after_update :expire_cache
  before_destroy :expire_cache
  
  def to_s
    name
  end

  def expire_cache
    ActionController::Base.new.expire_fragment('table_of_all_companies')
  end
end
