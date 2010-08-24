# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090621073012) do

  create_table "bse_companies", :primary_key => "sc_code", :force => true do |t|
    t.string "company_name",     :limit => 40, :default => "", :null => false
    t.string "company_fullname", :limit => 60, :default => "", :null => false
  end

  create_table "bse_company_group_history", :id => false, :force => true do |t|
    t.integer "sc_code"
    t.integer "group_id"
    t.date    "changed_on"
  end

  create_table "bse_company_group_map", :id => false, :force => true do |t|
    t.integer "group_id", :null => false
    t.integer "sc_code",  :null => false
  end

  create_table "bse_corp_actions", :primary_key => "action_id", :force => true do |t|
    t.string "action_code",  :limit => 4,  :default => "", :null => false
    t.string "action_label", :limit => 40, :default => "", :null => false
  end

  create_table "bse_corp_actions_map", :id => false, :force => true do |t|
    t.integer "eod_id",    :null => false
    t.integer "action_id", :null => false
  end

  create_table "bse_eod_data", :primary_key => "eod_id", :force => true do |t|
    t.integer "sc_code",      :null => false
    t.integer "type_id",      :null => false
    t.date    "eod_date",     :null => false
    t.float   "open",         :null => false
    t.float   "high",         :null => false
    t.float   "low",          :null => false
    t.float   "close",        :null => false
    t.float   "last",         :null => false
    t.float   "prevclose",    :null => false
    t.float   "trades_count", :null => false
    t.float   "shares_count", :null => false
    t.float   "net_turnover", :null => false
  end

  create_table "bse_groups", :primary_key => "group_id", :force => true do |t|
    t.string "sc_group", :limit => 4, :default => "", :null => false
  end

  create_table "bse_scriptypes", :primary_key => "type_id", :force => true do |t|
    t.string "type_code",  :limit => 4,  :default => "", :null => false
    t.string "type_label", :limit => 40, :default => "", :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title",      :limit => 100
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "preview"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stickers", :force => true do |t|
    t.text     "sticker",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
