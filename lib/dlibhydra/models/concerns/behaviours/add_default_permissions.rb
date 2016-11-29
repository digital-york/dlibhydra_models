module Dlibhydra
  module AddDefaultPermissions
    extend ActiveSupport::Concern

    included do
      def apply_depositor
        self.depositor = dlibhydra.depositor
        self.edit_users += self.depositor
      end
    end

  end
end