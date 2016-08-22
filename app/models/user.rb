class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assignments
  has_many :roles, :through => :assignments

  after_create :set_default_role

  def has_role?(role_sym)
	  roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  def is_admin?
     self.has_role? :admin
  end


  private
  def set_default_role
    assignment = Assignment.new
    assignment.user = self
    assignment.role = Role.find_by_name('registered') 
    assignment.save
  end
end
