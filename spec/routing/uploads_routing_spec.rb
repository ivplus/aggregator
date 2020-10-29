require "rails_helper"

RSpec.describe UploadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/organizations/1/uploads").to route_to("uploads#index", organization_id: "1")
    end

    it "routes to #new" do
      expect(get: "/organizations/1/uploads/new").to route_to("uploads#new", organization_id: "1")
    end

    it "routes to #show" do
      expect(get: "/organizations/1/uploads/1").to route_to("uploads#show", id: "1", organization_id: "1")
    end

    it "routes to #edit" do
      expect(get: "/organizations/1/uploads/1/edit").to route_to("uploads#edit", id: "1", organization_id: "1")
    end


    it "routes to #create" do
      expect(post: "/organizations/1/uploads").to route_to("uploads#create", organization_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/organizations/1/uploads/1").to route_to("uploads#update", id: "1", organization_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/organizations/1/uploads/1").to route_to("uploads#update", id: "1", organization_id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/organizations/1/uploads/1").to route_to("uploads#destroy", id: "1", organization_id: "1")
    end
  end
end