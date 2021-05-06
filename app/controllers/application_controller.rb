class ApplicationController < ActionController::API

  def success_response(data={})
    render status: 200, json: {data: data}
  end

  def error_response(key, error_message=nil)
    render_content = ErrorResponse.to_api(key, error_message).deep_dup
    render(render_content)
  end

  rescue_from Exception do |e|
    error_response(:internal_server_error, "#{e.message} (#{e.backtrace.first})")
  end
end
