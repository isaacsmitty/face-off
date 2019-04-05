class FaceoffResultsController < ApplicationController

  def create
    @season = 20182019
    @team1_id = params[:team1_id]
    @team2_id = params[:team2_id]
    @team1_percent_chance_win = 0
    @team2_percent_chance_win = 0
    @mean_absolute_error = 0

    calculation = python(@season, @team1_id, @team2_id)

    @faceoff_result = FaceoffResult.new
    @faceoff_result.team1_id = @team1_id
    @faceoff_result.team2_id = @team2_id
    @faceoff_result.team1_percent_chance_win = calculation[0]
    @faceoff_result.team2_percent_chance_win = calculation[1]
    @faceoff_result.mean_absolute_error = calculation[2]

    @faceoff_result.save

    redirect_to faceoff_result_path(@faceoff_result.id)
  end

  def show
    @faceoff_result = FaceoffResult.find (params[:id])
    @teams = Team.all
    @games = Game.where(status: 'Final')
  end

  private

  def python (season, team1_id, team2_id)
    calcArr = [0.9, 0.1, 0.2]
  end
end