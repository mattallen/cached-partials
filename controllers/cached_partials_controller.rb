class CachedPartialsController < ApplicationController
  protect_from_forgery :except => [:render_partials]
  def render_partials
    raise CachedPartials::InvalidKey if params[:cache_key] != CACHE_KEY
    raise CachedPartials::ClassRequired if params[:class_name].blank?
    raise CachedPartials::IdRequired if params[:id].blank?
    params[FORCE_KEY] = "1"
    @record = params[:class_name].constantize.find(params[:id])
    # re-render the member pages
    out = ""
    partials = File.join("app","views",@record.class.to_s.tableize,"member", "*")
    if partials
      Dir.glob(partials).each do |partial|
        render_to_string(:partial => partial.to_s.gsub(/\/_/,"/"),:locals => {:record => @record})
        out << partial.to_s
      end
    end
    # re-render the collection
    partials = File.join("app","views",@record.class.to_s.tableize,"collection", "*")
    if partials
      Dir.glob(partials).each do |partial|
        render_to_string(:partial => partial.to_s.gsub(/\/_/,"/"))
        out << partial.to_s
      end
    end
    render :text => out
  end
end
