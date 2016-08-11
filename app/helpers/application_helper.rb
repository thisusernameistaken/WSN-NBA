module ApplicationHelper
  def load_database
    require 'net/http'
    team_ids = (1..17).to_a + (19..26).to_a + [28,29,30,33,38]

    url = "http://basketball.realgm.com/tradechecker/select_player"
    uri = URI(url)
    ctr = 0
    while ctr < team_ids.length - 1
      response = Net::HTTP.post_form(uri,'team1'=>team_ids[ctr],'team2'=>team_ids[ctr+1])
      html = Nokogiri::HTML(response.body)
      data = html.css("td",:class=>"bluebody")
      c = 0
      teams = html.css("div[class='bluehead']").text.gsub("Team One: ","").split("Team Two: ")
      while c < data.css("a[target='_blank']").length
        player = data.css("a[target='_blank']")[c].text
        rating = data.css("span")[c].text
        begin
         if c < html.css("div[class='tablewrap']")[0].css("tr").length - 1
           Team.find_by_name(teams[0]).players.create("name"=>player,"rating"=>rating)
         else
            Team.find_by_name(teams[1]).players.create("name"=>player,"rating"=>rating)
         end
        rescue NoMethodError
          Team.find_by_name("Philadelphia 76ers").players.create("name"=>player,"rating"=>rating)
        end
        c+=1
      end
      ctr += 2
    end
  end
end
