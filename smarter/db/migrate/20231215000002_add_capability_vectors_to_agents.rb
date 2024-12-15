class AddCapabilityVectorsToAgents < ActiveRecord::Migration[7.0]
  def change
    add_column :agents, :capability_vectors, :float, array: true, default: []
    add_index :agents, :capability_vectors, using: :gin
  end
end
