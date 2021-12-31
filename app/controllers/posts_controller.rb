# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    posts = Post.order('created_at DESC')
    render json: { status: 'SUCCESS', message: 'Loaded posts', data: posts }, status: :ok
  end

  def show
    post = Post.find(params[:id])
    render json: { status: 'SUCCESS', message: 'Loaded post', data: post }, status: :ok
  end

  def create
    user = User.where(username: params[:username]).first_or_create
    post_params2 = {
      "title": post_params[:title],
      "content": post_params[:content],
      "user_id": user[:id],
      "likes_counter": 0
    }
    post = Post.new(post_params2)
    if post.save
      render json: { status: 'SUCCESS', message: 'Saved post', data: post }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Post not saved', data: post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    render json: { status: 'SUCCESS', message: 'Deleted post', data: post }, status: :ok
  end

  def update
    post = Post.find(params[:id])
    post_params2 = {
      "title": post_params[:title],
      "content": post_params[:content],
    }
    if post.update(post_params2)
      render json: { status: 'SUCCESS', message: 'Updated post', data: post }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Post not updated', data: post.errors }, status: :unprocessable_entity
    end
  end

  def upvote
    post = Post.find(params[:id])
    likes = post[:likes_counter] + 1
    if post.update({ "likes_counter": likes })
      render json: { status: 'SUCCESS', message: 'Upvoted post', data: post }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Post not upvoted', data: post.errors }, status: :unprocessable_entity
    end
  end

  def downvote
    post = Post.find(params[:id])
    likes = post[:likes_counter] - 1
    if post.update({ "likes_counter": likes })
      render json: { status: 'SUCCESS', message: 'downvoted post', data: post }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Post not downvoted', data: post.errors }, status: :unprocessable_entity
    end
  end

  def comments
    post = Post.find(params[:id])
    comments = post.comments.load
    render json: { status: 'SUCCESS', message: 'Loaded comments of post', data: comments }, status: :ok
  end

  private

  def post_params
    params.permit(:title, :content, :username)
  end
end
