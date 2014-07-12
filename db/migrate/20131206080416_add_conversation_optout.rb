# This migration comes from mailboxer_engine (originally 20131206080416)
class AddConversationOptout < ActiveRecord::Migration
  def change
    create_table :mailboxer_conversation_opt_outs do |t|
      t.references :unsubscriber, :polymorphic => true
      t.references :conversation, foreign_key: {references: :mailboxer_conversations, name: 'mb_opt_outs_on_conversations_id'}
    end
  end
end
