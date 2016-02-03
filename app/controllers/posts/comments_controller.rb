class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:new, :create, :edit, :update]
  before_action :set_comment, only: [:edit, :update]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'Your comment has been added'
    else
      render 'new'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
