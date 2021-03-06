require "digest/md5"

module RubyChina
  module APIEntities
    class User < Grape::Entity
      expose :_id, :name, :login, :location, :website, :bio, :tagline, :github_url
      expose(:gravatar_hash) { |model, opts| Digest::MD5.hexdigest(model.email || "") }
      expose(:avatar_url) { |model, opts| model.avatar? ? model.avatar.url(:normal) : "" }
    end

    class Reply < Grape::Entity
      expose :_id, :body, :body_html, :message_id, :created_at, :updated_at
      expose :user, :using => APIEntities::User
    end

    class Topic < Grape::Entity
      expose :_id, :title, :body, :body_html, :created_at, :updated_at, :replied_at, :replies_count, :node_name, :node_id, :last_reply_user_login
      expose :user, :using => APIEntities::User
      # replies only exposed when a single topic is fetched
      expose :replies, :using => APIEntities::Reply, :unless => { :collection => true }
    end

    class Node < Grape::Entity
      expose :_id, :name
    end
  end
end
