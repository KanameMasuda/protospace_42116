class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      # 保存成功時にルートパスにリダイレクト
      redirect_to root_path
    else
      # 保存失敗時には新規投稿ページに戻る
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    @prototype = Prototype.find(params[:id])  # 既存のプロトタイプを取得

      if @prototype.update(prototype_params)  # 更新処理を実行
        # 更新成功時に詳細ページにリダイレクト
        redirect_to prototype_path(@prototype)
      else
        # 更新失敗時に編集ページに戻る
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @prototype.destroy
    redirect_to prototypes_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image) .merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    @prototype = Prototype.find_by(id: params[:id])
    if @prototype.nil? || current_user != @prototype.user
      redirect_to root_path
    end
  end
end