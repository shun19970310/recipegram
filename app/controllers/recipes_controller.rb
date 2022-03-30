class RecipesController < ApplicationController
  def index
  end

  def show
  end

  def new
    # recipeモデルから空のモデルを持ってくる
    @recipe = Recipe.new
  end


  # データベースに登録するアクション
  def create
    @recipe = Recipe.new(recipe_params)
    # 誰が投稿したのか、user_id（カラム）に今ログインしている人のid（current_user.id）を持たせる必要がある
    @recipe.user_id = current_user.id
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def edit
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title,:body, :image)
  end
end
