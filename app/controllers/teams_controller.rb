class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @projects = Project.active
    if params[:project_id].present?
      @project = Project.find(params[:project_id])
      @teams = @project.teams.active
    else
      @teams = Team.active
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @projects = Project.active
    if params[:project_id].present?
      @project = Project.find(params[:project_id])
      @team = @project.teams.new
    else
      @team = Team.new
    end
  end

  # GET /teams/1/edit
  def edit
    @projects = Project.active
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @projects = Project.active
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    @projects = Project.active
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:name, :code, :description, :project_id, :members_count, :managers_count, :is_deleted, :pending_tasks, :status)
  end
end