class CommentsController < ApplicationController
  # before_action :authenticate_user!
  # Deviseを使用している場合に、ユーザーがログインしていないとコメント投稿アクション（create）を実行できないようにするためのもの

  def create
    @comment = Comment.new(comment_params) # プロトタイプに関連付けて新しいコメントを作成
    if @comment.save
      # コメントが保存された場合、プロトタイプの詳細ページにリダイレクト
      redirect_to prototype_path(@comment.prototype)
    else
      # コメントの保存に失敗した場合、詳細ページを再表示
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
      
    end
  end

  private

  # コメントのストロングパラメーターを定義
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
