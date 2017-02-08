# frozen_string_literal: true
require "active_support/concern"

module Decidim
  # The UserProfile concern must be included in all the controllers
  # that are shown in the user's profile settings. It adds the
  # proper layout, as well as helper methods that help render the
  # side menu, amongst others.
  module UserProfile
    extend ActiveSupport::Concern
    include FormFactory

    delegate :user_groups, to: :current_user, prefix: false

    included do
      layout "layouts/decidim/user_profile"

      helper_method :available_authorization_handlers,
                    :user_groups

      before_action :current_user
      authorize_resource :current_user
    end

    # Public: Available authorization handlers in order to conditionally
    # show the menu element.
    def available_authorization_handlers
      Decidim.authorization_handlers
    end
  end
end
