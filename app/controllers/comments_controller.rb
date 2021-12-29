# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    comments = Comment.order('created_at DESC')
    render json: { status: 'SUCCESS', message: 'Loaded comments', data: comments }, status: :ok
  end

  def show
    comment = Comment.find(params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded post', data: comment }, status: :ok
  end

  def create
    user = User.where(username: params[:username]).first_or_create
    comment_params2 = {
      "content": comment_params[:content],
      "post_id": comment_params[:post_id],
      "user_id": user[:id],
      "likes_counter": comment_params[:likes_counter]
    }
    comment = Comment.new(comment_params2)
    if comment.save
      render json: { status: 'SUCCESS', message: 'Saved comment', data: comment }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Comment not saved', data: comment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: { status: 'SUCCESS', message: 'Deleted comment', data: comment }, status: :ok
  end

  def update
    comment = Comment.find(params[:id])
    comment_params2 = {
      "content": comment_params[:content],
      "post": comment[:post_id],
      "user_id": comment[:user_id],
      "likes_counter": post_params[:likes_counter]
    }
    if comment.update(comment_params2)
      render json: { status: 'SUCCESS', message: 'Updated comment', data: comment }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Comment not updated', data: comment.errors }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:title, :content, :post_id, :likes_counter)
  end
end