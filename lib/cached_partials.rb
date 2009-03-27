module CachedPartials
  def update_cache
    spawn do
      Net::HTTP.post_form(URI.parse("#{CACHE_URL}/cached_partials/render_partials"),{"cache_key" => CACHE_KEY, "class_name" => self.class.to_s, "id" => self.id.to_s})
    end
  end
  ActiveRecord::Base.class_eval { after_save :update_cache }
  
end
class CachedPartials::InvalidKey < StandardError;  end
class CachedPartials::ClassRequired < StandardError;  end
class CachedPartials::IdRequired < StandardError;  end
class CachedPartials::RecordNotFound < StandardError; end

