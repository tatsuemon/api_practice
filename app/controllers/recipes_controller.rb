class RecipesController < ApplicationController
    def index
        recipes = Recipe.all()
        render json: {recipes: recipes}
    end

    def show
        recipe = Recipe.find(params[:id])
        render jdon: {message: "Recipe details by id", recipe: recipe}
    end

    def create
        recipe = Recipe.new(post_params)
        if recipe.save
            render json: {message: 'Recipe successfully created!', recipe: recipe}
        else
            render json: {message: 'Recipe create failed!', required: 'title, making_time, serves, ingredients, cost'}
        end
    end

    def update
        recipe = Recipe.find(params[:id])
        recipe = recipe.update(post_params)
        render json: {message: 'Recipe successfully updated!', recipe: recipe}
    end

    def destroy
        recipe = Recipe.find(params[:id])
        if recipe.destroy
            render json: {message: 'Recipe successfully removed!'}
        else
            render json: {message: 'No Recipe found'}
        end
    end
    private

    def post_params
        params.require(:recipe).permit(:title, :making_time, :ingredients, :cost)
    end

end
