require "calendar_sniper/version"

module CalendarSniper
  extend ActiveSupport::Concern

  included do
    scope :with_date_range, lambda { |num_days| with_from_date(num_days.to_f.days.ago) }
    scope :with_to_date, lambda { |date| search_in_date_range :<, date }
    scope :with_from_date, lambda { |date| search_in_date_range :>, date }
    scope :in_date_range, lambda { |from,to| with_from_date(from).with_to_date(to) }
  end

  module ClassMethods
    attr_reader :_filterable_by_date_range_field

    # Set the field to search date range on in your model.
    #
    # Example:
    #
    #   filterable_by_date_range :internal_lead_received_at
    #
    def filterable_by_date_range with_name=:created_at
      @_filterable_by_date_range_field = with_name.to_s
    end

    # Search through the date range in a given direction. Uses the
    # field given in the +filterable_by_date_range+ macro that you
    # can add to ActiveRecord, otherwise it defaults to 'created_at'.
    def search_in_date_range by_direction, with_date
      logger.debug "Searched #{date_field} on #{self.class.name} with a scope"
      where("#{table_name}.#{date_field} #{by_direction}= ?", coalesce_date(with_date, by_direction))
    end

    private

    def coalesce_date(from_date_or_string, by_direction)
      if from_date_or_string.is_a?(String)
        date_from_string = DateTime.strptime(from_date_or_string, date_format_for_string(from_date_or_string))
        set_time_for_direction(date_from_string, by_direction)
      else
        set_time_for_direction(from_date_or_string, by_direction)
      end
    end

    def set_time_for_direction(date_from_string, by_direction)
      case by_direction.to_sym
      when :<
        date_from_string.end_of_day
      when :>
        date_from_string.beginning_of_day
      else
        date_from_string
      end
    end

    def date_format_for_string(str)
      if /^\d{1,2}\/\d{1,2}\/\d{4}/ =~ str
        '%m/%d/%Y'
      elsif /^\d{4}-\d{1,2}-\d{1,2}/ =~ str
        if /^\d{4}-\d{1,2}-\d{1,2} \S+/ =~ str
          '%Y-%m-%d %Z'
        elsif /^\d{4}-\d{1,2}-\d{1,2} \d{1,2}:\d{2}:\d{2}+/
          '%Y-%m-%d %k:%M:%S'
        else
          '%Y-%m-%d'
        end
      else
        raise "Date string in unknown format: #{str}"
      end
    end

    def date_field
      @date_field ||= @_filterable_by_date_range_field || 'created_at'
    end
  end
end
