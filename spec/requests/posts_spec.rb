require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user) }
  # let!(:post) { create(:post, user: user) }

  let(:valid_attributes) { { title: 'New Post', content: 'Content for new post', user_id: user.id } }
  let(:invalid_attributes) { { title: '', content: '', user_id: user.id } } # Adjust as needed


  before do
    sign_in user
  end

  describe 'Index' do
    let(:post) { create(:post, user: user) }

    it 'assigns all posts to @posts' do
      get :index
      expect(assigns(:posts)).to eq([post])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'Show' do
    let(:post) { create(:post, user: user) }

    it 'assigns the requested post to @post' do
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end

    it 'renders the show template' do
      get :show, params: { id: post.id }
      expect(response).to render_template(:show)
    end
  end


  describe "POST /posts" do
    context 'with valid attributes' do
      it 'creates a new post' do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)

        expect(response).to redirect_to(Post.last)
        expect(flash[:notice]).to eq('Post was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new post' do
        expect {
          post :create, params: { post: invalid_attributes }
        }.not_to change(Post, :count)

        expect(response).to render_template(:new)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'Update' do
    let(:post) { create(:post, user: user) }

    context 'with valid attributes' do
      let(:new_attributes) { { title: 'Updated Title', content: 'Updated content' } }

      it 'updates the post' do
        patch :update, params: { id: post.id, post: new_attributes }
        post.reload
        expect(post.title).to eq('Updated Title')
        expect(post.content).to eq('Updated content')
      end

      it 'redirects to the show page with a success notice' do
        patch :update, params: { id: post.id, post: new_attributes }
        expect(response).to redirect_to(post)
        expect(flash[:notice]).to eq('Post was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { title: '', content: '' } }

      it 'does not update the post' do
        patch :update, params: { id: post.id, post: invalid_attributes }
        post.reload
        expect(post.title).to_not eq('')
        expect(post.content).to_not eq('')
      end

      it 'renders the edit template with an unprocessable entity status' do
        patch :update, params: { id: post.id, post: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'Destroy' do
    let(:post) { create(:post, user: user) }

    it 'deletes the post' do
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(0)
    end

    it 'redirects to the posts index with a success notice' do
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to eq('Post was successfully destroyed.')
    end
  end
end
