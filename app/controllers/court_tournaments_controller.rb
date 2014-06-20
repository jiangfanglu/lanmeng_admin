class CourtTournamentsController < ApplicationController
  # GET /court_tournaments
  # GET /court_tournaments.json
  def index
    @court_tournaments = CourtTournament.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @court_tournaments }
    end
  end

  # GET /court_tournaments/1
  # GET /court_tournaments/1.json
  def show
    @court_tournament = CourtTournament.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @court_tournament }
    end
  end

  # GET /court_tournaments/new
  # GET /court_tournaments/new.json
  def new
    @court_tournament = CourtTournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @court_tournament }
    end
  end

  # GET /court_tournaments/1/edit
  def edit
    @court_tournament = CourtTournament.find(params[:id])
  end

  # POST /court_tournaments
  # POST /court_tournaments.json
  def create
    @court_tournament = CourtTournament.new(params[:court_tournament])

    respond_to do |format|
      if @court_tournament.save
        format.html { redirect_to @court_tournament, notice: 'Court tournament was successfully created.' }
        format.json { render json: @court_tournament, status: :created, location: @court_tournament }
      else
        format.html { render action: "new" }
        format.json { render json: @court_tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /court_tournaments/1
  # PUT /court_tournaments/1.json
  def update
    @court_tournament = CourtTournament.find(params[:id])

    respond_to do |format|
      if @court_tournament.update_attributes(params[:court_tournament])
        format.html { redirect_to @court_tournament, notice: 'Court tournament was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @court_tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /court_tournaments/1
  # DELETE /court_tournaments/1.json
  def destroy
    @court_tournament = CourtTournament.find(params[:id])
    @court_tournament.destroy

    respond_to do |format|
      format.html { redirect_to court_tournaments_url }
      format.json { head :no_content }
    end
  end
end
