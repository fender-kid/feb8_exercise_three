require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    before do
      create_list(:post, 10) # Creates 10 sample posts
      get posts_path
    end

    it "returns all posts" do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe "GET /posts/:id" do
    let(:post) { create(:post) } # Creates a sample post
  
    before do
      get post_path(post)
    end
  
    it "returns the specified post" do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(post.id)
    end
  end

  describe "POST /posts" do
    let(:valid_attributes) { { title: "Valid Title", content: "Valid Content" } }
    let(:invalid_attributes) { { title: "", content: "" } }
  
    context "with valid parameters" do
      it "creates a new Post" do
        expect {
          post posts_path, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
  
        expect(response).to have_http_status(:created)
      end
    end
  
    context "with invalid parameters" do
      it "does not create a new Post" do
        expect {
          post posts_path, params: { post: invalid_attributes }
        }.not_to change(Post, :count)
  
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
end
