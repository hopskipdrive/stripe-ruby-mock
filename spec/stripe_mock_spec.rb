require 'spec_helper'

describe StripeMock do

  it "overrides stripe's request method" do
    StripeMock.start
    Stripe.request(:xtest, '/', 'abcde') # no error
    StripeMock.stop
  end

  it "reverts overriding stripe's request method" do
    StripeMock.start
    Stripe.request(:xtest, '/', 'abcde') # no error
    StripeMock.stop
    expect { Stripe.request(:x, '/', 'abcde') }.to raise_error
  end

  it "does not persist data between mock sessions" do
    StripeMock.start
    StripeMock.instance.customers[:x] = 9

    StripeMock.stop
    StripeMock.start

    expect(StripeMock.instance.customers[:x]).to be_nil
    expect(StripeMock.instance.customers.keys.length).to eq(0)
    StripeMock.stop
  end

end
