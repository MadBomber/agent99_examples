#!/usr/bin/env ruby
# examples/AI/registry_ai.rb

require 'debug_me'
include DebugMe

require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'securerandom'

# Health check endpoint
get '/healthcheck' do
  agent_count = Agent.count
  content_type :json
  { agent_count: }.to_json
end

# Endpoint to register an agent
post '/register' do
  request.body.rewind
  request_data = JSON.parse(request.body.read, symbolize_names: true)
  agent        = Agent.new(
    info:         request_data,
    capabilities: request_data[:capabilities].join(', ')
  )
  agent.vector = vectorize_capabilities(agent.capabilities)

  if agent.save
    status 201
    content_type :json
    { uuid: agent.id }.to_json
  else
    status 400
    content_type :json
    { error: agent.errors.full_messages }.to_json
  end
end

# Endpoint to discover agents by capability
get '/discover' do
  capability = params['capability'].downcase
  matching_agents = Agent.search_by_capability(capability)

  content_type :json
  matching_agents.map do |agent|
    {
      uuid:         agent.id,
      name:         agent.info['name'],
      capabilities: agent.capabilities.split(', ')
    }
  end.to_json
end

# Withdraw an agent from the registry
delete '/withdraw/:uuid' do
  uuid   = params['uuid']
  agent  = Agent.find_by(id: uuid)

  if agent
    agent.destroy
    status 204 # No Content
  else
    status 404 # Not Found
    content_type :json
    { error: "Agent with UUID #{uuid} not found." }.to_json
  end
end

# Display all registered agents
get '/' do
  agents = Agent.all
  content_type :json
  agents.map do |agent|
    {
      uuid:         agent.id,
      name:         agent.info['name'],
      capabilities: agent.capabilities.split(', ')
    }
  end.to_json
end

# Helper method to vectorize capabilities (placeholder implementation)
def vectorize_capabilities(capabilities, vector_size: 2048)
  # This is a placeholder implementation. In a real-world scenario,
  # you would use a proper vectorization algorithm here.
  vector = Array.new(vector_size, 0.0)
  capabilities.each_char.with_index do |char, index|
    vector[index % vector_size] = char.ord / 255.0
  end
  vector
end

# Start the Sinatra server
if __FILE__ == $PROGRAM_NAME
  Sinatra::Application.run!
end
