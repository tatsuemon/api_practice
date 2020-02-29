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
        if params[:title].blank? or params[:serves].blank? or params[:making_time].blank? or params[:ingredients].blank? or params[:cost].blank?
            render json: {message: 'Recipe creation failed!', required: 'title, making_time, serves, ingredients, cost'}
        else
            recipe = Recipe.new(post_params)
            if recipe.save
                render json: {message: 'Recipe successfully created!', recipe: [recipe]}
            else
                render json: {message: 'Recipe creation failed!', required: 'title, making_time, serves, ingredients, cost'}
            end
        end
    end

    def update
        if params[:title].blank? or params[:serves].blank? or params[:making_time].blank? or params[:ingredients].blank? or params[:cost].blank?
            render json: {message: 'Recipe update failed!', required: 'title, making_time, serves, ingredients, cost'}
        elsif @recipe.blank?
            render json: {message: 'No Recipe found'}
        else
            @recipe.update(post_params)
            render json: {message: 'Recipe successfully updated!', recipe: [@recipe]}
        end
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
        if params.nil?
            return nil
        else
            params.require(:recipe).permit(:title, :serves, :making_time, :ingredients, :cost)
        end
    end

end
