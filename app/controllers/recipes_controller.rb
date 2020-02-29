class RecipesController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]

    def index
        recipes = Recipe.all()
        render json: {recipes: recipes}
    end

    def show
        if @recipe.blank?
            render json: {message: 'No Recipe found'}
        else
            render json: {message: "Recipe details by id", recipe: [@recipe]}
        end
    end

    def create
        recipe = Recipe.new(post_params)
        if recipe.title.blank? or recipe.serves.blank? or recipe.making_time.blank? or recipe.ingredients.blank? or recipe.cost.blank?
            render json: {message: 'Recipe creation failed!', required: 'title, making_time, serves, ingredients, cost'}
        elsif recipe.save
            render json: {message: 'Recipe successfully created!', recipe: [recipe]}
        else
            render json: {message: 'Recipe creation failed!', required: 'title, making_time, serves, ingredients, cost'}
        end
    end

    def update
        @recipe.update(post_params)
        render json: {message: 'Recipe successfully updated!', recipe: [@recipe]}
    end

    def destroy
        if @recipe.blank?
            render json: {message: 'No Recipe found'}
        elsif @recipe.destroy
            render json: {message: 'Recipe successfully removed!'}
        else
            render json: {message: 'No Recipe found'}
        end
    end

    private
    def set_post
        f = Recipe.find_by_id(params[:id])
        if f.nil?
            return nil
        else
            @recipe = Recipe.find(params[:id])
        end
    end

    def post_params
        params.require(:recipe).permit(:title, :serves, :making_time, :ingredients, :cost)
    end

end
