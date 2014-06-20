require 'test_helper'

class CourtTournamentsControllerTest < ActionController::TestCase
  setup do
    @court_tournament = court_tournaments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:court_tournaments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create court_tournament" do
    assert_difference('CourtTournament.count') do
      post :create, court_tournament: { court_id: @court_tournament.court_id, tournament_id: @court_tournament.tournament_id }
    end

    assert_redirected_to court_tournament_path(assigns(:court_tournament))
  end

  test "should show court_tournament" do
    get :show, id: @court_tournament
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @court_tournament
    assert_response :success
  end

  test "should update court_tournament" do
    put :update, id: @court_tournament, court_tournament: { court_id: @court_tournament.court_id, tournament_id: @court_tournament.tournament_id }
    assert_redirected_to court_tournament_path(assigns(:court_tournament))
  end

  test "should destroy court_tournament" do
    assert_difference('CourtTournament.count', -1) do
      delete :destroy, id: @court_tournament
    end

    assert_redirected_to court_tournaments_path
  end
end
