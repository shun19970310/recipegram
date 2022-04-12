class RecipesController < ApplicationController
  # devise導入で使えるヘルパーメソッド：ログインしていないユーザーのアクセス制限を実行（一覧画面は許可）
  before_action :authenticate_user!, except: [:index]
  def index
    # 登録されているデータを全て取得
    @recipes = Recipe.all
  end

  def show
    # 一つのレシピの情報を取得し、@recipeに代入している
    # params[:id]はカーソルを合わせた時に出てくるusers/1といった各々のidを持ってきている
    @recipe = Recipe.find(params[:id])
  end

  def new
    # recipeモデルから空のモデルを持ってくる
    @recipe = Recipe.new
  end
  # データベースに登録するアクション
  def create
    @recipe = Recipe.new(recipe_params)
    # 誰が投稿したのか(投稿した人の情報を取得)、user_id（カラム）に今ログインしている人のid（current_user.id）を持たせる必要がある
    @recipe.user_id = current_user.id
    # バリデーションをかけるときはcreateとupdate
    # バリデーションをかけることでセーブされる時とされない時の条件が発生する
    if @recipe.save
    # レシピの詳細画面に遷移（どのレシピに遷移するかを指定）
     redirect_to recipe_path(@recipe), notice: "投稿に成功しました"
    # バリデーションに引っかかった場合はnewページに遷移
    else
      # newアクションを介さずにrecipes/newページに遷移
      # recipes/newで使われる@recipeは同じcreateアクション内の@recipe = Recipe.new(recipe_params)が採用される
     render :new
    end
  end

  def edit
    # 編集したいレシピを一つ取得し、代入
    @recipe = Recipe.find(params[:id])
    # @recipeに結びついているユーザーとログインしている人が等しくない場合は編集させたくない
    if @recipe.user != current_user
      redirect_to recipes_path, alert:'不正なアクセスです'
    end
  end

  def update
    # 更新する一つのデータを取得
    @recipe = Recipe.find(params[:id])
    # どのカラムをアップデートするのかを許可
    if @recipe.update(recipe_params)
    # レシピの詳細画面に遷移（どのレシピに遷移するかを指定）
    # update内の@recipeとパスの引数である@recipeは一致している
     redirect_to recipe_path(@recipe), notice: "更新に成功しました"
    else
     render :edit
    end
  end
  def destroy
    # 削除するデータを一つ取得
    recipe = Recipe.find(params[:id])
    # それを削除
    recipe.destroy
    # 削除後、レシピの一覧に遷移
    redirect_to recipes_path

  end

  private
  def recipe_params
    params.require(:recipe).permit(:title,:body, :image)
  end
end
