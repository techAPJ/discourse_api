require 'csv'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require File.expand_path('../../lib/discourse_api', __FILE__)

client = DiscourseApi::Client.new("http://localhost:3000")
client.api_key = "API_KEY"
client.api_username = "API_USERNAME"

# response = client.groups
# puts response
GROUP_ID = 41
USERNAME_ARRAY = []

# read CSV file
CSV.foreach(File.expand_path("../users.csv", __FILE__)) do |row|
  user_details = client.get_user_details_by_email(row[0])
  USERNAME_ARRAY << user_details[0]["username"]
end

client.group_add(GROUP_ID, usernames: USERNAME_ARRAY)
