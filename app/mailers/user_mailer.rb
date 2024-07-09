class UserMailer < ApplicationMailer
  def deadline_approaching
    @task = params[:task]
    mail(to: @task.user.email, subject: 'Task deadline approaching')
  end
end
