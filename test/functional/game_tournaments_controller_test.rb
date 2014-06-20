require 'test_helper'

class GameTournamentsControllerTest < ActionController::TestCase
  setup do
    @game_tournament = game_tournaments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_tournaments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_tournament" do
    assert_difference('GameTournament.count') do
      post :create, game_tournament: { game_id: @game_tournament.game_id, tournament_id: @game_tournament.tournament_id }
    end

    assert_redirected_to game_tournament_path(assigns(:game_tournament))
  end

  test "should show game_tournament" do
    get :show, id: @game_tournament
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_tournament
    assert_response :success
  end

  test "should update game_tournament" do
    put :update, id: @game_tournament, game_tournament: { game_id: @game_tournament.game_id, tournament_id: @game_tournament.tournament_id }
    assert_redirected_to game_tournament_path(assigns(:game_tournament))
  end

  test "should destroy game_tournament" do
    assert_difference('GameTournament.count', -1) do
      delete :destroy, id: @game_tournament
    end

    assert_redirected_to game_tournaments_path
  end
end
