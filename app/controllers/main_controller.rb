class MainController < ApplicationController

  # GET /
  def index
    @trade = Trade.order("quality").reverse.first
  end

  # GET /play
  def play
    randomize = Team.first(30).shuffle
    team1 = randomize.first
    team2 = randomize.second
    team1_players= []
    team2_players= []
    trade_ratio = (rand(20)*5)+10
    team1_total_ratio = 0
    t1_players = team1.players.order("rand()")
    c = 0
    puts trade_ratio
    while team1_total_ratio < (trade_ratio + 10)
      if c < t1_players.length
        if t1_players[c].rating < 8
          c+=1
        elsif team1_total_ratio + t1_players[c].rating < (trade_ratio + 10)
          team1_total_ratio += t1_players[c].rating
          team1_players << t1_players[c]
        end
        c+=1
      else
        break
      end
    end
    team2_total_ratio = 0
    t2_players = team2.players.order("rand()")
    c = 0
    while team2_total_ratio < (trade_ratio + 10)
      if c < t2_players.length
        if t2_players[c].rating < 8
          c+=1
        elsif team2_total_ratio + t2_players[c].rating < (trade_ratio + 10)
          team2_total_ratio += t2_players[c].rating
          team2_players << t2_players[c]
        end
        c+=1
      else
        break
      end
    end
    if team1_players.length<1 or team2_players.length<1
      redirect_to '/play'
      return
    end
    t1 = Team.create("name"=>team1.name)
    t1.players = team1_players

    t2 = Team.create("name"=>team2.name)
    t2.players = team2_players
    @trade = Trade.new
    @trade.teams << t1
    @trade.teams << t2
    @trade.save
  end

  # GET /play/:id
  def trade
    @trade = Trade.find(params[:id])
    @votes = @trade.get_upvotes.size - @trade.get_downvotes.size
    render :play
  end

  # POST /vote/:id
  def vote
    if !current_user
        flash[:not_signed_in] = true
        redirect_to :back
      return
    end
    @trade = Trade.find(params[:id])
    index = 1
    @trade.teams.each do |team|
      if params[:commit] == team.name
        break
      else
        index+=1
      end
    end
    if index == 1
      @trade.team1_votes+=1
    elsif index == 2
      @trade.team2_votes+=1
    elsif params[:commit] == "Both"
      @trade.both_votes+=1
    else
      @trade.neither_votes+=1
    end
    @trade.save
    redirect_to "/results/#{params[:id]}"
  end

  # POST /voteq/:id
  def vote_quality
    response.headers['Content-Type'] = 'text/javascript'
    if !current_user
      render :not_signed_in
      return
    end
    @trade = Trade.find(params[:id])
    if params[:commit] == "downvote"
      if current_user.voted_down_on? @trade
        @trade.undisliked_by current_user
        @trade.quality +=1
        @trade.save
        render :un_quality
      else
        @trade.downvote_from current_user
        @trade.quality -=1
        @trade.save
        render :partial=>"down_quality.js.erb"
      end
    else
      if current_user.voted_up_on? @trade
        @trade.unliked_by current_user
        @trade.quality -=1
        @trade.save
        render :un_quality
      else
        @trade.upvote_from current_user
        @trade.quality +=1
        @trade.save
        render :partial=>"up_quality.js.erb"
      end
    end
  end

  # GET /results/:id
  def results
    @trade = Trade.find(params[:id])
  end

  # GET /trades
  def trades
    @trades = Trade.order("quality").reverse.first(30)
  end

  # GET /trades/new
  def new_trades
    @trades = Trade.order("created_at").reverse.first(30)
    render :trades
  end
end
