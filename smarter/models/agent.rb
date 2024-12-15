# models/agent.rb
class Agent < ApplicationRecord
  validates :info,         presence: true
  validates :capabilities, presence: true

  def self.search_by_capability(capability)
    where("capabilities ILIKE ?", "%#{capability}%")
  end
end