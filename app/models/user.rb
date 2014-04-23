class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]
  def self.find_or_create_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
    end
  end

has_many :datees, :through => :relationships, :conditions => "status = 'accepted'"
has_many :requested_datees, :through => :relationships, :source => :datee, :conditions => "status = 'requested'", :order => :created_at
has_many :pending_datees, :through => :relationships, :source => :datee, :conditions => "status = 'pending'", :order => :created_at
has_many :relationships, :dependent => :destroy

has_many :surveys
has_many :experiences


end
