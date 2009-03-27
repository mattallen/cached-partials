module CachedPartialsHelper
  def cp_cache(*args, &block)
    if RAILS_ENV == "test"
      concat(capture(&block))
    else
      concat(Rails.cache.fetch(*args) { capture(&block) })
    end
  end
end