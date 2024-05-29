require 'rails_helper'

describe 'Inn owner register group booking' do
  it 'and view creation form from inn management screen' do
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
    #act
    login_as(inn_owner, scope: :inn_owner)
    visit root_path
    within("nav") do
      click_on "Gestão de Pousadas"
    end
    within("div#inn-actions") do
      click_on "Fazer reserva de grupo"
    end
    #assert
    expect(page).to have_field "Nome"
    expect(page).to have_field "Data de entrada"
    expect(page).to have_field "Data de saída"
  end
end
