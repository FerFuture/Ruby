namespace :fetch_sismic_data do
  desc "Fetch and persist sismic data"
  task fetch_and_persist_data: :environment do
    puts "Iniciando tarea para obtener y persistir datos sísmicos..."

    begin
      Feature.reset_column_information
      response = HTTParty.get("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")

      if response.success?
        puts "¡Datos sísmicos obtenidos exitosamente!"

        data = JSON.parse(response.body)

        data["features"].each do |feature|
          event_time = Time.at(feature["properties"]["time"] / 1000)
          if event_time >= 30.days.ago
            Feature.create!(
              feature_id: feature["id"],
              magnitude: feature["properties"]["mag"],
              place: feature["properties"]["place"],
              time: event_time,
              url: feature["properties"]["url"],
              tsunami: feature["properties"]["tsunami"],
              mag_type: feature["properties"]["magType"],
              title: feature["properties"]["title"],
              longitude: feature["geometry"]["coordinates"][0],
              latitude: feature["geometry"]["coordinates"][1]
            )
          end
        end

        puts "Datos sísmicos persistidos en la base de datos."

      else
        puts "Error al obtener datos sísmicos. Código de respuesta: #{response.code}"
      end

    rescue StandardError => e
      puts "Error durante la ejecución de la tarea: #{e.message}"
    end
  end
end
