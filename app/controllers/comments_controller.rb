class CommentsController < ApplicationController
  before_action :set_post
  
  def create
    comment = @post.comments.create! comments_params
    CommentsMailer.submitted(comment).deliver_later
    CommentsChannel.broadcast(comment)

    redirect_to @post
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def comments_params
      params.required(:comment).permit(:body)
    end
end
