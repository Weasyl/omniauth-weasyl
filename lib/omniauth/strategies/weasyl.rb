require 'omniauth-oauth2'


module OmniAuth
  module Strategies
    class Weasyl < OmniAuth::Strategies::OAuth2
      def initialize(app, consumer_key = nil, consumer_secret = nil, options = {}, &block)
        site = options[:site] || 'https://www.weasyl.com'
        opts = {
          :client_options => {
            :site => site,
            :authorize_url => site + '/api/oauth2/authorize',
            :token_url => site + '/api/oauth2/token',
          },
        }
        super(app, consumer_key, consumer_secret, opts, &block)
      end

      uid { raw_info['userid'].to_s }

      info do
        raw = raw_info
        {
          :name => raw['login'],
          :username => raw['login'],
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      alias :oauth2_access_token :access_token

      def access_token
        ::OAuth2::AccessToken.new(client, oauth2_access_token.token, {
                                    :mode => :header,
                                    :param_name => 'oauth2_access_token',
                                    :expires_in => oauth2_access_token.expires_in,
                                    :expires_at => oauth2_access_token.expires_at,
                                  })
      end

      def raw_info
        MultiJson.load access_token.get('/api/whoami').body
      end
    end
  end
end
