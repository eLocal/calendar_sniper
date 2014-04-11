require 'spec_helper'
describe CalendarSniper::ClassMethods do
  class TestSniper
    extend CalendarSniper::ClassMethods
  end

  [
    [ '%m/%d/%Y', '1/1/2013'  ],
    [ '%m/%d/%Y', '01/1/2013' ],
    [ '%m/%d/%Y', '1/01/2013' ],
    [ '%m/%d/%Y', '01/01/2013'],
    [ '%Y-%m-%d', '2013-01-01'],
    [ '%Y-%m-%d %Z', '2013-01-01 +01:00' ],
    [ '%Y-%m-%d %k:%M:%S', '2013-01-01  3:00:00' ]
  ].each do |format, example|
    it "can parse #{example} as #{format}" do
      expect(TestSniper.send(:coalesce_date, example, '=')).to eq(DateTime.strptime(example, format))
    end
  end

  it 'fails when there is an invalid string' do
    expect { TestSniper.send(:date_format_for_string, 'bogus') }.to raise_error
  end
end