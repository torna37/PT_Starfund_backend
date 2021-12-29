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
      "likes_counter": post_params[:likes_counter]
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
      "user_id": post[:user_id],
      "likes_counter": post_params[:likes_counter]
    }
    if post.update(post_params)
      render json: { status: 'SUCCESS', message: 'Updated post', data: post }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Post not updated', data: post.errors }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.permit(:title, :content, :username, :likes_counter)
  end
end
