include ApplicationHelper
teams ="Atlanta Hawks

Boston Celtics

Brooklyn Nets

Charlotte Hornets

Chicago Bulls

Cleveland Cavaliers

Dallas Mavericks

Denver Nuggets

Detroit Pistons

Golden State Warriors

Houston Rockets

Indiana Pacers

Los Angeles Clippers

Los Angeles Lakers

Memphis Grizzlies

Miami Heat

Milwaukee Bucks

Minnesota Timberwolves

New Orleans Pelicans

New York Knicks

Oklahoma City Thunder

Orlando Magic

Philadelphia 76ers

Phoenix Suns

Portland Trail Blazers

Sacramento Kings

San Antonio Spurs

Toronto Raptors

Utah Jazz

Washington Wizards"

teams = teams.split("\n\n")

teams.each do |team|
  Team.create("name"=>team)
end

load_database