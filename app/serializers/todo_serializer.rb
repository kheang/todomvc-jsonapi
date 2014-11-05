class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :order, :completed
end
