class Node
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields
  belongs_to :node_group
   field :num, :type => Integer, :default => 1
  

  # field <name>, :type => <type>, :default => <value>
  

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
