class CreateAttendings < ActiveRecord::Migration
  def change
    create_table :attendings do |t|
      t.belongs_to :subject, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
