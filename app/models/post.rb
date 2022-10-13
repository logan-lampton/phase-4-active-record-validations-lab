class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction),
        message: "is not included in the list" }

    validate :title_clickbaity

    CLICKBAIT_TITLES = [
        /Won't Believe/i,
        /Secret/i,
        /Top \d/i,
        /Guess/i
      ]
    
    def title_clickbaity
        if CLICKBAIT_TITLES.none? { |t| t.match title }
            errors.add(:title, "must be clickbait")
        end
    end
end
