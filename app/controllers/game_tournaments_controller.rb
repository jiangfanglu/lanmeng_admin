class GameTournamentsController < ApplicationController
  # GET /game_tournaments
  # GET /game_tournaments.json
  def index
    @game_tournaments = GameTournament.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_tournaments }
    end
  end

  # GET /game_tournaments/1
  # GET /game_tournaments/1.json
  def show
    @game_tournament = GameTournament.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_tournament }
    end
  end

  # GET /game_tournaments/new
  # GET /game_tournaments/new.json
  def new
    @game_tournament = GameTournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_tournament }
    end
  end

  # GET /game_tournaments/1/edit
  def edit
    @game_tournament = GameTournament.find(params[:id])
  end

  # POST /game_tournaments
  # POST /game_tournaments.json
  def create
    @game_tournament = GameTournament.new(params[:game_tournament])

    respond_to do |format|
      if @game_tournament.save
        format.html { redirect_to @game_tournament, notice: 'Game tournament was successfully created.' }
        format.json { render json: @game_tournament, status: :created, location: @game_tournament }
      else
        format.html { render action: "new" }
        format.json { render json: @game_tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_tournaments/1
  # PUT /game_tournaments/1.json
  def update
    @game_tournament = GameTournament.find(params[:id])

    respond_to do |format|
      if @game_tournament.update_attributes(params[:game_tournament])
        format.html { redirect_to @game_tournament, notice: 'Game tournament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_tournaments/1
  # DELETE /game_tournaments/1.json
  def destroy
    @game_tournament = GameTournament.find(params[:id])
    @game_tournament.destroy

    respond_to do |format|
      format.html { redirect_to game_tournaments_url }
      format.json { head :no_content }
    end
  end
end
