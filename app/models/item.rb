class Item < ApplicationRecord
  #タイトルは必須項目かつ、20文字上限
  validates :title, presence: true, length: {maximum: 20}
  validates :start, presence: true
  validates :end, presence: true
  validates :memo, length: {maximum: 500}

  validate :start_end_over #カスタムはvalidate

  private
  #開始日が終了日よりも後にならないように
  def start_end_over
    if self.start.present? && self.end.present? && self.start >= self.end #startとendはカラム名としてアクセスするため、self.startとself.endを使用し、dateのためpresent
      errors.add(:base, "終了日は、開始日以降の日付としてください") #:startだと、Start開始日は終了日時より前で選択してくださいと表示されてしまうため、全体的なエラーメッセージとして表示
    end
  end
end
