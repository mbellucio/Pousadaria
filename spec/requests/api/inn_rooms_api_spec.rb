require 'rails_helper'

describe 'Inn Room API' do
  context "GET /api/v1/inn_rooms/:id" do
    it 'get inn room by id successfully' do
      #arrange
      inn_owner = InnOwner.create!(
        first_name: 'Joao',
        last_name: 'Almeida',
        document: '53783222001',
        email: 'joao@email.com',
        password: '123456'
      )
      inn = inn_owner.create_inn!(
        name: 'Pousada do Almeidinha',
        registration_number: '30638898000199',
        description: 'Um bom lugar',
        address_attributes: {
          address: 'Rua X',
          number: '100',
          city: 'Manaus',
          state: 'AM',
          postal_code: '69067-080',
          neighborhood: 'Centro'
      })
      inn_room = inn.inn_rooms.create!(
        name: 'Quarto Térreo',
        size: 30,
        guest_limit: 3,
        daily_rate_cents: 10000
      )
      #act
      get "/api/v1/inn_rooms/#{inn_room.id}"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq inn_room.name
      expect(json_response["size"]).to eq inn_room.size
      expect(json_response["guest_limit"]).to eq inn_room.guest_limit
      expect(json_response["daily_rate_cents"]).to eq inn_room.daily_rate_cents
    end

    it 'fails if id do not exists' do
      #arrange
      inn_owner = InnOwner.create!(
        first_name: 'Joao',
        last_name: 'Almeida',
        document: '53783222001',
        email: 'joao@email.com',
        password: '123456'
      )
      inn = inn_owner.create_inn!(
        name: 'Pousada do Almeidinha',
        registration_number: '30638898000199',
        description: 'Um bom lugar',
        address_attributes: {
          address: 'Rua X',
          number: '100',
          city: 'Manaus',
          state: 'AM',
          postal_code: '69067-080',
          neighborhood: 'Centro'
      })
      inn_room = inn.inn_rooms.create!(
        name: 'Quarto Térreo',
        size: 30,
        guest_limit: 3,
        daily_rate_cents: 10_000
      )
      #act
      get "/api/v1/inn_rooms/99999"
      #assert
      expect(response.status).to eq 404
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq "Unable to find a room with the given id"
    end
  end
end
