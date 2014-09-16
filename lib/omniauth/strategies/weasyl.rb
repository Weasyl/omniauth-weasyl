require 'omniauth-oauth2'


module OmniAuth
  module Strategies
    class Weasyl < OmniAuth::Strategies::OAuth2
      option :name, 'weasyl'

      option :client_options, {
        :site => 'https://www.weasyl.com',
        :authorize_url => 'https://www.weasyl.com/api/oauth2/authorize',
        :token_url => 'https://www.weasyl.com/api/oauth2/token',
      }

      uid { raw_info['userid'].to_s }

      info do
        {
          :name => raw_info['login'],
        }
      end

      extra do
        { 'raw_info' => raw_info }
      end

      alias :oauth2_access_token :access_token

      def access_token
        ::OAuth2::AccessToken.new(client, oauth2_access_token.token, {
                                    :mode => :query,
                                    :param_name => 'oauth2_access_token',
                                    :expires_in => oauth2_access_token.expires_in,
                                    :expires_at => oauth2_access_token.expires_at
                                  })
      end

      def raw_info
        @raw_info ||= access_token.get('/api/whoami').parsed
      end
    end
  end
end
