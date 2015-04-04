require 'spec_helper'

module Spree
  describe Spree::Api::LineItemsController do
    render_views

    before do
      stub_authentication!
      Spree.user_class.stub :find_by_spree_api_key => current_api_user
    end

    def self.make_simple_data!
      let!(:order) { FactoryGirl.create(:order, state: 'complete', completed_at: Time.now) }
      let!(:line_item) { FactoryGirl.create(:line_item, order: order, unit_value: 500) }
    end

    #test that when a line item is updated, an order's fees are updated too
    context "as an admin user" do
      sign_in_as_admin!
      make_simple_data!

      context "as a line item is updated" do
        it "apply enterprise fees on the item" do
          line_item_params = { order_id: order.number, id: line_item.id, line_item: { id: line_item.id, unit_value: 520 }, format: :json}
          controller.should_receive(:apply_enterprise_fees).and_return(true)
          spree_post :update, line_item_params
        end
      end
    end
  end
end
