module ProposalsHelper
  # Return link with a +label+ for sorting records by +field+. The optional
  # +kind+ (e.g., :sessions or :proposals) determines what URLs to generate, if
  # one isn't specified, then the @kind instance variable will be used.
  def sort_link_for(label, field, kind=nil)
    kind ||= @kind

    opts = {:sort => field}
    opts[:dir] = 'desc' if ( field == params[:sort] && params[:dir] != 'desc' )

    link = link_to(label, self.send("event_#{kind}_path", @event, opts))
    link += ( params[:dir] == 'desc' ? ' &or;' : ' &and;' ) if field == params[:sort]

    return link
  end

  # Return a link path for the given +object+. The optional +kind+ (e.g.,
  # :sessions or :proposals) determines what kind of links to make, if one
  # isn't specified, then the @kind instance variable will be used.
  def record_path(object, kind=nil)
    kind = (kind || @kind).to_s.singularize
    return self.send("#{kind}_path", object)
  end
end
