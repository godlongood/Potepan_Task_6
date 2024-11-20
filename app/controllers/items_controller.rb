class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: "スケジュールを作成しました" #成功したら一覧ページへ
    else
      flash.now[:alert] = "スケジュール作成に失敗しました"
      render new_item_path ,status: :unprocessable_entity #失敗したら作成ページへ エラー422ユーザー登録エラーを表示
    end
  end

  def show
    @item = Item.find(params[:id]) #1つのIDのデータを取得
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(params.require(:item).permit(:title,:start,:end,:allday,:memo))
    flash[:notice] = "ID「#{@item.id}」の情報を更新しました"
    redirect_to items_path #一覧ページへ
    else
    render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "ID「#{@item.id}」の情報を削除しました"
    redirect_to items_path #一覧ページへ
  end

  def item_params #フォームで入力した値を渡すメソッド
    params.require(:item).permit(:title,:start,:end,:allday,:memo)
  end
end

