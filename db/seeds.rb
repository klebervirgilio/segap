('a'..'z').to_a.each{|a| Page.create(title:a,content:a*100) }
(1..16).to_a.each{|n| Page.find(n).update_attribute(:published_on, n.month.ago) }
