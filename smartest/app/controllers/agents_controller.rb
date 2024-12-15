class AgentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    render json: Agent.all
  end
  
  def healthcheck
    render json: { agent_count: Agent.count }
  end
  
  def create
    agent = Agent.new(
      name: agent_params[:name],
      capabilities: agent_params[:capabilities]
    )
    
    if agent.save
      render json: { uuid: agent.id }, status: :created
    else
      render json: { error: agent.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def discover
    capability = params[:capability].downcase
    matching_agents = Agent.where("capabilities @> ?", [capability].to_json)
    render json: matching_agents
  end
  
  def destroy
    agent = Agent.find_by(id: params[:id])
    
    if agent
      agent.destroy
      head :no_content
    else
      render json: { error: "Agent with UUID #{params[:id]} not found." }, status: :not_found
    end
  end
  
  private
  
  def agent_params
    params.require(:agent).permit(:name, capabilities: [])
  end
end
