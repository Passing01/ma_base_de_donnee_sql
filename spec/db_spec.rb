require 'sqlite3'
require_relative '../db/setup'

describe 'users table' do 
  it 'should exist' do 
    expect(db.table_info('users').length).to be > 0
  end

  it 'should have a name column' do
    expect(db.table.info('users').any? { |column| column['name'] == 'name' }).to be true
  end

  it 'should have a unique name comlumn' do
    expect(db.table.info('users').find { |column| column['name'] == 'name' }['type']).to eq 'TEXT'
    expect(db.table.info('users').find { |column| column['name'] == 'name' }['notnull']).to eq 1
    expect(db.table.info('users').find { |column| column['name'] == 'name' }['dflt_value']).to eq 'NULL'
    expect(db.table.info('users').find { |column| column['name'] == 'name' }['pk']).to eq 0