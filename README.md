# calendar_sniper

calendar_sniper adds date related scopes to ActiveRecord models

## Installation

Add this line to your application's Gemfile:

    gem 'calendar_sniper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install calendar_sniper

## Usage

calendar_sniper adds ```with_date_range```, ```with_to_date```, ```with_from_date```, and ```in_date_range``` scopes to ActiveRecord models that it is included into.

```with_date_range``` takes a number that is the number of days
```in_date_range``` takes a start and end date
```with_to_date``` and ```with_from_date``` each take a single date as an argument

These scopes integrate with ActiveRecord's created_at or you can select a custom column to filter on by calling ```filterable_by_date_range``` with the name of the column you want to be the date column.

These scopes take into considering time in their scopes allowing you to search from the beginning of one day until the end of another.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
