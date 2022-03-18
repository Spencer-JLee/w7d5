class PostsController < ApplicationController
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    post_params[:sub_id].each do |id|
      @post = Post.new
      @post.title = post_params[:title]
      @post.url = post_params[:url]
      @post.content = post_params[:content]
      @post.author_id = current_user.id
      @post.sub_id = id

      if @post.save
        
      else
        flash.now[:errors] = @post.errors.full_messages
      end
      redirect_to subs_url
    end
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
    params.require(:post).permit(:title, :url, :content, *:sub_id)
  end
end
