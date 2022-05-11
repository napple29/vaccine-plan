# frozen_string_literal: true

class ChildrenController < ApplicationController
  before_action :set_child, only: %i[edit update]

  def new
    @child = Child.new
    @child.user_id = current_user.id
  end

  def edit
    @child.user_id = current_user.id
  end

  def create
    @child = Child.new(child_params)
    @child.user_id = current_user.id

    respond_to do |format|
      if @child.save
        format.html { redirect_to child_histories_path(@child), notice: '家族が増えました！' }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @child.user_id = current_user.id

    respond_to do |format|
      if @child.update(child_params)
        format.html { redirect_to child_histories_path(@child), notice: 'お子さんの情報を編集しました' }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def child_params
    params.require(:child).permit(:name, :birthday, :avatar)
  end
end
