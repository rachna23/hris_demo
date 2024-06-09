# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
