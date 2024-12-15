class Agent < ApplicationRecord
  validates :name, presence: true
  validates :capabilities, presence: true
  
  before_save :downcase_capabilities
  
  private
  
  def downcase_capabilities
    self.capabilities = capabilities.map(&:downcase) if capabilities.is_a?(Array)
  end
end
