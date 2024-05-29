require 'rails_helper'

describe 'Inn Room API' do
  context "GET /api/v1/inn_rooms/:inn_room_id" do
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
        daily_rate_cents: 10_000
      )
      #act
      get "/api/v1/inn_rooms/#{inn_room.id}"
      #assert
      expect(response.status).to eq 200
      expect(response.content_type).to include "application/json"
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response.first["name"]).to eq inn_room.name
      expect(json_response.first["size"]).to eq inn_room.size
      expect(json_response.first["guest_limit"]).to eq inn_room.guest_limit
      expect(json_response.first["daily_rate_cents"]).to eq inn_room.daily_rate_cents
    end
  end
end
