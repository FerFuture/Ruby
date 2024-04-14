module Api
  class CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token
    rescue_from StandardError, with: :handle_error

    def create
      feature = Feature.find(params[:feature_id])
      comment = feature.comments.new(comment_params)

      if comment.save
        render json: { message: 'Comentario creado exitosamente', comment: comment }, status: :created
      else
        render json: { error: comment.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: 'Feature no encontrado' }, status: :not_found
    rescue StandardError => e
      handle_error(e)
    end

    def index
      feature = Feature.find(params[:feature_id])
      comments = feature.comments

      render json: comments, only: [:body], status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: 'Feature no encontrado' }, status: :not_found
    rescue StandardError => e
      handle_error(e)
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def handle_error(exception)
      Rails.logger.error("Error en el controlador de comentarios: #{exception.message}")
      render json: { error: 'Error interno del servidor' }, status: :internal_server_error
    end
  end
end
