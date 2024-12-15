# db/migrate/20230601000000_create_agents.rb
class CreateAgents < ActiveRecord::Migration[7.0]
  def up
    enable_extension 'pgcrypto'
    enable_extension 'pg_trgm'
    enable_extension 'vector'

    create_table :agents, id: :uuid do |t|
      t.jsonb    :info,         null: false
      t.text     :capabilities, null: false
      t.vector   :vector,       dimensions: 2048

      t.timestamps
    end

    add_index :agents, :capabilities, using: :gin
    add_index :agents, :vector,       using: :ivfflat
  end

  def down
    drop_table :agents

    disable_extension 'vector'
    disable_extension 'pg_trgm'
    disable_extension 'pgcrypto'
  end
end
