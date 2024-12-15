# Smarter Agent Management System

A Rails application for managing intelligent agents with advanced features and persistence.

## Features

- Agent registration and management
- Capability vector storage and indexing
- RESTful API endpoints
- Web interface for agent interaction

## System Requirements

- Ruby 3.0+
- Rails 8.0+
- PostgreSQL
- Node.js (for JavaScript compilation)

## Setup

1. Database setup:
```bash
rails db:create
rails db:migrate
```

2. Start the server:
```bash
rails server
```

## Database Schema

The system uses PostgreSQL with:
- UUID primary keys for agents
- JSONB for capability storage
- GIN indexes for efficient capability querying
- Float arrays for capability vectors

## API Endpoints

The application provides RESTful endpoints for:
- Agent registration
- Capability updates
- Agent discovery
- Inter-agent communication

## Testing

Run the test suite with:
```bash
rails test
```

## Development

The application uses:
- Stimulus for JavaScript interactions
- Standard Rails conventions
- PostgreSQL-specific features for performance
