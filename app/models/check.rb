class Check < ApplicationRecord
 
  def self.search(search)
      if search
        Check.where(['nickname LIKE ?', "%#{search}%"])
      else
        redirect_to @check, notice: "対象者はいません"
      end
  end
  
  
  has_many :questions
  has_many :comments
  belongs_to :user
  has_many :likes, dependent: :destroy
    
    def like_user(user_id)
        likes.find_by(user_id: user_id)
    end

  validates :pre_score, presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 20,
      less_than_or_equal_to: 100, 
      allow_blank: true
    }
  
  validates :chk_score1, :chk_score2, :chk_score3, :chk_score4, :chk_score5, presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 4,
      less_than_or_equal_to: 20, 
      allow_blank: true
    } 
  
  before_save do
    self.chk_score = chk_score1 + chk_score2 + chk_score3 + chk_score4 + chk_score5
    self.dif_score = (chk_score1 + chk_score2 + chk_score3 + chk_score4 + chk_score5 - pre_score)
  end
  
  def show_last_comment
    last_comment = comments.last
  if last_comment.present?
      last_comment.text 
  else
    'まだコメントはありません。'
  end
end


end