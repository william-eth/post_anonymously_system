class MessageBoard < ApplicationRecord

  ALLOW_ACTS = %w[add cancel].freeze
  ALLOW_TYPES = %w[like unlike].freeze

  scope :order_by_date, -> { order(created_at: :desc) }
  scope :order_by_top, -> { order(total_approved: :desc, created_at: :desc) }

  def self.display_info(order_by = 'date', page = 1, per_page = 10)
    case order_by
    when 'date'
      messages = MessageBoard.all.order_by_date.page(page).per(per_page)
    when 'top'
      messages = MessageBoard.all.order_by_top.page(page).per(per_page)
    end
    {
      messages: messages.map(&:display),
      current_page: messages.current_page,
      total_pages: messages.total_pages
    }
  end

  def display
    {
      id: id,
      nick_name: nick_name,
      content: content,
      like:  like,
      unlike: unlike,
      total_approved: total_approved,
      created_at: created_at.to_i,
      updated_at: updated_at.to_i
    }
  end

  def calculate_approved(act, type)
    if act == 'cancel'
      case type
      when 'like'
        self.like -= 1 if self.like > 0
      when 'unlike'
        self.unlike -= 1 if self.unlike > 0
      end
    elsif act == 'add'
      case type
      when 'like'
        self.like = self.like + 1
      when 'unlike'
        self.unlike += 1
      end
    end
    self.total_approved = self.like - self.unlike
    self.save!
  end
end
