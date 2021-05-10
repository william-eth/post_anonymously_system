class Api::V1::MessagesController < ApplicationController
  def index
    result = MessageBoard.display_info(params[:order_by], params[:page], params[:per_page])
    success_response(result)
  end

  def create
    message = MessageBoard.new
    message.update(message_params)
    success_response(MessageBoard.display_info(:date))
  end

  def approve
    return error_response(:action_not_allow) if params[:act].nil? || MessageBoard::ALLOW_ACTS.exclude?(params[:act])
    return error_response(:type_not_allow) if params[:type].nil? || MessageBoard::ALLOW_TYPES.exclude?(params[:type])

    target = MessageBoard.find_by(id: params[:id])
    return error_response(:message_not_found) if target.nil?
    target.calculate_approved(params[:act], params[:type])

    success_response(MessageBoard.display_info(:date))
  end

  def top_ten
    result = MessageBoard.order_by_top_ten.map(&:display)
    success_response(result)
  end

  private

  def message_params
    params.permit(:nick_name, :content)
  end
end