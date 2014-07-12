class CreateMailboxer < ActiveRecord::Migration
  def change
  #Tables

    #Conversations
    create_table :mailboxer_conversations do |t|
      t.string :subject, :default => ""
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
    end

    #Notifications and Messages
    create_table :mailboxer_notifications do |t|
      t.string :type
      t.text :body
      t.string :subject, :default => ""
      t.references :sender, :polymorphic => true
      t.integer :conversation_id, foreign_key: {references: :mailboxer_conversations, name: 'notifications_on_conversation_id'}
      t.boolean :draft, :default => false
      t.string :notification_code, :default => nil
      t.references :notified_object, :polymorphic => true
      t.string :attachment
      t.datetime :updated_at, :null => false
      t.datetime :created_at, :null => false
      t.boolean :global, default: false
      t.datetime :expires
    end

    #Receipts
    create_table :mailboxer_receipts do |t|
      t.references :receiver, :polymorphic => true
      t.integer :notification_id, :null => false, foreign_key: {references: :mailboxer_notifications, name: 'receipts_on_notification_id'}
      t.boolean :is_read, :default => false
      t.boolean :trashed, :default => false
      t.boolean :deleted, :default => false
      t.string :mailbox_type, :limit => 25
      t.datetime :created_at, :null => false
      t.datetime :updated_at, :null => false
    end

  #Indexes
    #Conversations
    #Receipts
    add_index "mailboxer_receipts","notification_id"

    #Messages
    add_index "mailboxer_notifications","conversation_id"
  end
end
