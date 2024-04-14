module Api
  class FeaturesController < ApplicationController
    rescue_from StandardError, with: :handle_error

    def index
      begin
        features = Feature.all

        if params[:mag_type].present?
          mag_types = sanitize_mag_types(params[:mag_type])
          features = features.where(mag_type: mag_types)
        end

        page_number = params[:page].to_i
        page_number = [page_number, 1].max 
        per_page = params[:per_page].to_i
        per_page = [per_page, 1000].min 
        features = features.paginate(page: page_number, per_page: per_page)

        if features.present?
          per_page = features.size < per_page ? features.size : per_page
        else
          per_page = 0
        end


        formatted_features = features.map do |feature|
          {
            id: feature.id,
            type: 'feature',
            attributes: {
              external_id: feature.feature_id,
              magnitude: feature.magnitude,
              place: feature.place,
              time: feature.time.to_s,
              tsunami: feature.tsunami,
              mag_type: feature.mag_type,
              title: feature.title,
              coordinates: {
                longitude: feature.longitude,
                latitude: feature.latitude
              }
            },
            links: {
              external_url: feature.url
            }
          }
        end

        json_response = {
          data: formatted_features,
          pagination: {
            current_page: features.current_page,
            total: features.total_entries,
            per_page: per_page
          }
        }

        render json: json_response
      rescue StandardError => e
        handle_error(e)
      end
    end

    private

    def handle_error(exception)

      Rails.logger.error("Error en el controlador de features: #{exception.message}")

      render json: { error: 'Error interno del servidor' }, status: :internal_server_error
    end

    def sanitize_mag_types(mag_types_param)
      mag_types = Array(mag_types_param)
      mag_types.map { |type| type.gsub(/[^a-zA-Z0-9]/, '') }
    end
  end
end
