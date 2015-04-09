require 'spec_helper'

describe HashArrayMapper do

  it 'should return hash' do
    mapped_hash = HashArrayMapper.map({foo: 'foo', bar: 'bar'})
    expect(mapped_hash).to eq({:foo=>'foo', :bar=>'bar'})
  end

  it 'should return hash with single element array' do
    mapped_hash = HashArrayMapper.map({foo: 'foo', bar: 'bar', foo_1_price: '10', foo_1_name: 'foo 1'})
    expect(mapped_hash).to eq({:foo=>'foo', :bar=>'bar', :foos=>[{:price=>'10', :name=>'foo 1'}]})
  end

  it 'should return hash with two element array' do
    mapped_hash = HashArrayMapper.map({foo: 'foo', bar: 'bar', foo_1_price: '10', foo_1_name: 'foo 1', foo_2_price: '100', foo_2_name: 'foo 2'})
    expect(mapped_hash).to eq({:foo=>'foo', :bar=>'bar', :foos=>[{:price=>'10', :name=>'foo 1'}, {:price=>'100', :name=>'foo 2'}],})
  end

  it 'should return hash with two arrays' do
    mapped_hash = HashArrayMapper.map({foo: 'foo', bar: 'bar', foo_1_price: '10', foo_1_name: 'foo 1', bar_1_name: 'bar 1', bar_1_price: '100'})
    expect(mapped_hash).to eq({:foo=>'foo', :bar=>'bar', :foos=>[{:price=>'10', :name=>'foo 1'}], :bars=>[{:price=>'100', :name=>'bar 1'}]})
  end

  it 'should return hash with two arrays with one empty' do
    mapped_hash = HashArrayMapper.map({foo: 'foo', bar: 'bar', foo_1_price: '10', foo_1_name: 'foo 1', bar_1_name: nil, bar_1_price: nil})
    expect(mapped_hash).to eq({:foo=>'foo', :bar=>'bar', :foos=>[{:price=>'10', :name=>'foo 1'}], :bars=>[]})
  end

end
