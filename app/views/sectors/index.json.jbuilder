json.array!(@sectors) do |sector|
  json.extract! sector, :id, :name, :status
  json.url sector_url(sector, format: :json)
end
