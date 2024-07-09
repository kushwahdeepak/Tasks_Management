FactoryBot.define do
    factory :task do
      title { "Sample Task" }
      description { "Sample Description" }
      state { "Backlog" }
      deadline { 1.day.from_now }
      association :user
    end
  end