class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :state, presence: true
  validates :deadline, presence: true

  belongs_to :user

  def self.send_deadline_notifications
    tasks = Task.where(state: 'Backlog').where('deadline < ?', 1.day.from_now)
    tasks.each do |task|
      UserMailer.with(task: task).deadline_approaching.deliver_now if task.deadline > Time.now
    end
  end
end
