class Post < ApplicationRecord
    validates :title, presence: true, length: { maximum: 20 }
    validates :start_at, presence: true
    validates :end_at, presence: true
    validates :memo, length: { maximum: 500 }

    validate  :not_before_today

    def not_before_today
        errors.add(:end_at, "は今日以降の日付で選択してください") if end_at.nil? || end_at < Date.today
    end
end
