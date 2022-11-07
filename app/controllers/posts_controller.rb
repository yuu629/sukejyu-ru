class PostsController < ApplicationController
  
 before_action :today_date

  def today_date
   @today_date = Time.zone.now
  end  

  def index
   @page_title = "スケジュール一覧"
   @posts = Post.all
  end

  def new
   @page_title = "スケジュール新規作成"
   @post = Post.new
  end

  def create
   @post = Post.new(params.require(:post).permit(
    :title, #タイトル
    :start_at, #開始日
    :end_at, #終了日
    :is_all_day, #終日
    :memo #スケジュールメモ
   ))
   if @post.save
     flash[:success] = "スケジュールを登録しました"
     redirect_to :posts
   else
     flash[:failure] = "スケジュールを登録できませんでした"
     render "new"  
   end 
  end

  def show
   @page_title = "スケジュール詳細"
   @post = Post.find(params[:id]) 
  end

  def edit
   @page_title = "スケジュール編集"
   @post = Post.find(params[:id]) 
  end

  def update
   @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(
       :title, #タイトル
       :start_at, #開始日
       :end_at, #終了日
       :is_all_day, #終日
       :memo #スケジュールメモ
    )) 
    flash[:success] = "スケジュールを更新しました"
    redirect_to :posts
    else
     flash[:failure] = "スケジュールを更新できませんでした"
     render "edit" 
    end
  end

  def destroy
   @post = Post.find(params[:id])
   @post.destroy
   flash[:delete] = "スケジュールを削除しました"
   redirect_to :posts
  end

end
