class PrototypesController < ApplicationController
  # 「authenticate_user!」でログインしていない人をログインページに遷移させる。
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy ]
  before_action :move_to_index, only: [:edit]
  

  def index
    # すべてのプロトタイプを取得してインスタンス変数に代入
    @prototypes = Prototype.all
  end

  def new
    # 新しいPrototypeオブジェクトを生成
    @prototype = Prototype.new
  end

  def create
    # フォームのデータを元に新しいPrototypeオブジェクトを作成
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    # 保存が成功した場合、ルートパスにリダイレクト
    redirect_to root_path
    # , notice: 'プロトタイプを作成しました！'必要だったらroot_pathの後ろにつける
    else
    # 保存が失敗した場合、新規投稿ページを再表示
    # flash.now[:alert] = 'プロトタイプの作成に失敗しました。入力内容を確認してください。'
    redirect_to prototype_path(@prototype)
    end
  end

  def show
  

    # 新しいCommentオブジェクトを作成（フォームで使用）
    @comment = Comment.new
    # プロトタイプに紐づくコメントと関連ユーザーをまとめて取得
    @comments = @prototype.comments.includes(:user)
  end

  def edit
   
  end

  def update
   
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
      # , notice: 'プロトタイプを更新しました！'
    else
      # flash.now[:alert] = 'プロトタイプの更新に失敗しました。入力内容を確認してください。'
      render :edit
    end
  end

  def destroy
 
    @prototype.destroy
    redirect_to root_path
  end

  private

  # ストロングパラメーターの定義
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  # def check_user
  #   @prototype = Prototype.find(params[:id])
    
  # end
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    # 投稿者以外だったらトップページに遷移する。残った投稿者のみが該当アクションに入れるようにする。
    if current_user.id != @prototype.user_id
      redirect_to action: :index
    end
  end
  
end
