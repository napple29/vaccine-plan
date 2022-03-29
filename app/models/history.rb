# frozen_string_literal: true

class History < ApplicationRecord
  belongs_to :child
  belongs_to :vaccination

  validates :vaccination_id, presence: true
  validate :history_before_today
  validate :bigger_than_before_history
  validate :smaller_than_after_history

  def history_before_today
    errors.add(:date, 'は今日より前の日付にしてください') if date > Date.current
  end

  def bigger_than_before_history
    vaccination = Vaccination.find(vaccination_id)
    return if vaccination.key[-1] == '1'

    before_history = History.find(id - 1)
    return if before_history.date.nil?

    errors.add(:date, 'が前回の期より後の日付になっています') unless before_history.date < date
  end

  def smaller_than_after_history
    vaccination = Vaccination.find(vaccination_id)
    return if vaccination.key[-1] == '4'

    after_history = History.find(id + 1)
    return if after_history.date.nil?

    errors.add(:date, 'が次回の期より後の日付になっています') unless date < after_history.date
  end
end
