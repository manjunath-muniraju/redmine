class PopulateEmailAddresses < ActiveRecord::Migration[4.2]
  def self.up
    t = EmailAddress.connection.quoted_true
    n = EmailAddress.connection.quoted_date(Time.now)
    temp_id = 0
    sql1 = "INSERT INTO #{EmailAddress.table_name} (id, user_id, address, is_default, notify, created_on, updated_on) "
    sql2 = "SELECT #{temp_id}, id, mail, #{t}, #{t}, '#{n}', '#{n}' FROM #{User.table_name} WHERE type = 'User' ORDER BY id"
    sql = sql1+sql2
    # p sql
    # p EmailAddress.connection.exec_query(sql2)
    EmailAddress.connection.execute(sql)
  end

  def self.down
    EmailAddress.delete_all
  end
end
