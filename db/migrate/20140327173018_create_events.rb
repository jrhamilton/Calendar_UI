class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :description, :varchar
      t.column :location, :varchar
      t.column :start, :datetime
      t.column :end, :datetime
    end
  end
end
