class PostsController < ApplicationController
  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:id]

    if @post.save
      
    else
      flash.now[:errors] = @post.errors.full_messages
    end
    redirect_to sub_url(@post.sub_id)
  end

  def show
    @post = Post.find(params[:id])
    
    render :show
  end

  def edit
    @post = Post.find(params[:id])

    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)

    else
      flash.now[:errors] = @post.errors.full_messages
    end
    redirect_to post_url(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
