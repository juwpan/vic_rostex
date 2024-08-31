class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.string :body
      t.jsonb :answer, default: {}

      t.timestamps
    end

    add_index :questions, :answer, using: :gin
  end
end
