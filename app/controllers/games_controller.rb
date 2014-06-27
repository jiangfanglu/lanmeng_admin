class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    @games = Game.order("created_at desc").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  def stats
    @game = Game.find params[:id]
  end

  def newgame
    @tournaments = Tournament.includes(:city).order("cities.name asc").all
  end

  def newgameform
    @game = Game.new

    @tournament = Tournament.includes(:referees).includes(:courts).includes(:teams).find params[:id]

    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save

        @game_tournament = GameTournament.new(
            game_id: @game.id, 
            tournament_id: params[:post][:tournament_id].to_i
          )

        @game_tournament.save

        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  def viewstats
    @game = Game.find params[:id]

    @team_a_player_ids = @game.team_a.players.collect{|p|p.id}
    @team_b_player_ids = @game.team_b.players.collect{|p|p.id}

    @player_game_stats_team_a = PlayerGameStat.includes(:player).where("game_id = ? and player_id in (?)", @game.id, @team_a_player_ids)
    @player_game_stats_team_b = PlayerGameStat.includes(:player).where("game_id = ? and player_id in (?)", @game.id, @team_b_player_ids)
  
  end

  def addgamestats
    team_a_score = params[:team][:team_a_score].to_i
    team_b_score = params[:team][:team_b_score].to_i 

    @game_team_a = GameStat.new(
        game_id: params[:team][:game_id].to_i,
        team_id: params[:team][:team_a_id].to_i,
        score: team_a_score         
      )
    @game_team_a.save
    @game_team_b = GameStat.new(
        game_id: params[:team][:game_id].to_i,
        team_id: params[:team][:team_b_id].to_i,
        score: team_b_score      
      )
    @game_team_b.save

    @team_a_stat = TeamStat.find_by_team_id params[:team][:team_a_id].to_i
    @team_a_stat.win += 1 if team_a_score > team_b_score
    @team_a_stat.lose += 1 if team_a_score < team_b_score
    @team_a_stat.save

    @team_b_stat = TeamStat.find_by_team_id params[:team][:team_b_id].to_i
    @team_b_stat.win += 1 if team_a_score < team_b_score
    @team_b_stat.lose += 1 if team_a_score > team_b_score
    @team_b_stat.save

    n=0
    params[:team][:player_id].each do |player_id|
      player_game_stats = PlayerGameStat.new(
          :assist=>params[:team][:assist][n].to_i, 
          :block=>params[:team][:block][n].to_i, 
          :dunk=>params[:team][:dunk][n].to_i, 
          :player_id=>player_id.to_i, 
          :rebound=>params[:team][:rebound][n].to_i, 
          :score=>params[:team][:score][n].to_i, 
          :steal=>params[:team][:steal][n].to_i,
          :game_id=>params[:team][:game_id].to_i
        )
      player_game_stats.save

      player = Player.find player_id.to_i
      player.total_assist += player_game_stats.assist
      player.total_block += player_game_stats.block
      player.total_dunk += player_game_stats.dunk
      player.total_rebound += player_game_stats.rebound
      player.total_score += player_game_stats.score
      player.total_steal += player_game_stats.steal
      player.save
      n+=1
    end
    
    redirect_to "/games"
  end
end
