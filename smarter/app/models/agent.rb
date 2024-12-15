class Agent < ApplicationRecord
  validates :name, presence: true
  validates :capabilities, presence: true
  
  before_save :downcase_capabilities
  before_save :update_capability_vectors
  
  def self.search_by_capability(capability, limit: 10)
    vector = vectorize_text(capability)
    neighbors = Neighbors::Index.new
    
    # Load all agents and their vectors
    all.each do |agent|
      neighbors.add(agent.id, agent.capability_vectors) if agent.capability_vectors.present?
    end
    
    # Find nearest neighbors
    nearest = neighbors.nearest(vector, k: limit)
    
    # Return agents in order of similarity
    nearest.map { |id, _distance| find(id) }
  end
  
  private
  
  def downcase_capabilities
    self.capabilities = capabilities.map(&:downcase) if capabilities.is_a?(Array)
  end
  
  def update_capability_vectors
    return unless capabilities_changed?
    
    self.capability_vectors = capabilities.map do |capability|
      self.class.vectorize_text(capability)
    end.flatten
  end
  
  def self.vectorize_text(text)
    # TODO: Replace with actual AI client call once gems are added
    # This is a placeholder that creates a random vector
    Array.new(384) { rand }
  end
end
