class AddType1TypeToType1s < ActiveRecord::Migration[5.0]
  def change
    add_reference :type1s, :type1_type, foreign_key: true
    add_index :type1s, [:name, :type1_type_id, :description, :deleted_at], length: { description: 255 }, unique: true, name: 'index_t1s_on_n_t1_t_id_deleted_at'
  end
end