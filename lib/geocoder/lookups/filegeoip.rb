require 'geocoder/lookups/base'
require 'geocoder/results/filegeoip'

module Geocoder::Lookup
  class Filegeoip < Base

    def name
      "FileGeoIP"
    end

    private # ---------------------------------------------------------------

    ##
    # Return the name of the configured service, or raise an exception.
    #
    def configured_service!
      if s = configuration[:service] and services.include?(s)
        return s
      else
        raise(
          Geocoder::ConfigurationError,
          "When using a MaxMind geo file you MUST specify a service name: " +
          "Geocoder.configure(:filegeoip => {:service => ...}), " +
          "where '...' is one of: #{services.inspect}"
        )
      end
    end

    def service_code
      configured_service!
    end

    def services
      [:country, :city]
    end

    def results(query)
      unless defined?(GeoIP)
        begin
          require 'geoip'
        rescue LoadError
          raise LoadError, "Please install the 'geoip' gem to read the geo file."
        end
      end

      @geo_ip ||= GeoIP.new(configuration[:file_path])

      [@geo_ip.send(service_code, query.text)]
    end
  end
end
