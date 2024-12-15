class CreateAgentsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :agents, id: :uuid do |t|
      t.string :name, null: false
      t.jsonb :capabilities, null: false, default: []
      
      t.timestamps
    end
    
    add_index :agents, :capabilities, using: :gin
  end
end
