class Admin::LotteriesController < AdminController
  before_action :set_lottery, only: [:show, :edit, :update, :destroy]

  # GET /admin/lotteries
  # GET /admin/lotteries.json
  def index
    @lotteries = Lottery.order("created_at DESC").page(params[:page]).per(10)
  end

  # GET /admin/lotteries/1
  # GET /admin/lotteries/1.json
  def show
  end

  # GET /admin/lotteries/new
  def new
    @lottery = Lottery.new
  end

  # GET /admin/lotteries/1/edit
  def edit
  end

  # POST /admin/lotteries
  # POST /admin/lotteries.json
  def create
    @lottery = Lottery.new(lottery_params)

    respond_to do |format|
      if @lottery.save
        format.html { redirect_to [:admin, @lottery], notice: 'Lottery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lottery }
      else
        format.html { render action: 'new' }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/lotteries/1
  # PATCH/PUT /admin/lotteries/1.json
  def update
    respond_to do |format|
      if @lottery.update(lottery_params)
        format.html { redirect_to [:admin, @lottery], notice: 'Lottery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lottery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/lotteries/1
  # DELETE /admin/lotteries/1.json
  def destroy
    @lottery.destroy
    respond_to do |format|
      format.html { redirect_to admin_lotteries_url, notice: 'Lottery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lottery
      @lottery = Lottery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lottery_params
      params.require(:lottery).permit(:activity_id, :activity_name, :winning, :activity_award_id, :activity_award_cfg_id, :activity_award_cfg_name, :user_id)
    end
end