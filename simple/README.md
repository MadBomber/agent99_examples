# Simple Agent Implementation

This directory contains a basic implementation of the Agent99 framework with several example agents.

## Available Agents

- **BadAgent**: A simple example agent with rubber stamp and yes-man capabilities
- **ChiefAgent**: A client-type agent acting as Chief of Control
- **ExampleAgent**: A server agent demonstrating basic capabilities
- **MaxwellAgent86**: A server agent with greeting capabilities

## Usage

Each agent implements the Agent99::Base interface and provides:
- Capability declarations
- Request/response handling
- Schema definitions (where applicable)

## Setup

```ruby
require_relative 'path/to/agent'

# Initialize an agent
agent = MaxwellAgent86.new

# Get agent info
puts agent.info
```

## Agent Capabilities

Agents declare their capabilities in their `info` method. For example:

```ruby
def info
  {
    name: self.class.to_s,
    type: :server,
    capabilities: ['specific_capability']
  }
end
```
