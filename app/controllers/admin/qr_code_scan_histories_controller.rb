class Admin::QrCodeScanHistoriesController < AdminController
  before_action :set_qr_code_scan_history, only: [:show, :edit, :update, :destroy]

  # GET /admin/qr_code_scan_histories
  # GET /admin/qr_code_scan_histories.json
  def index
	@count = params[:count]
	@start_date = params[:start_date]
	@end_date = params[:end_date]
  if @count.present?
    @search_type = "search_result"
    @qr_code_scan_histories_search_reasults = QrCodeScanHistory.select("user_id").where("created_at > ? and created_at < ?",@start_date,@end_date).select("user_id, count(1) as count").group("user_id").having("count(1) > ?",@count).order("count DESC").page(params[:page]).per(10)
    @user = Array.new
    for i in 0..@qr_code_scan_histories_search_reasults.length-1
      @user[i] = User.select("id,status,name").find(@qr_code_scan_histories_search_reasults[i].user_id)
    end
    puts @qr_code_scan_histories_search_reasults.to_json
  else
    @search_type = "history_detail"
    @qr_code_scan_histories = QrCodeScanHistory.where("created_at > ? and created_at < ?",@start_date,@end_date).order("created_at DESC").page(params[:page]).per(10)
  end
end
  # GET /admin/qr_code_scan_histories/1
  # GET /admin/qr_code_scan_histories/1.json
  def show
  end

  # GET /admin/qr_code_scan_histories/new
  def new
    @qr_code_scan_history = QrCodeScanHistory.new
  end

  # GET /admin/qr_code_scan_histories/1/edit
  def edit
  end

  # POST /admin/qr_code_scan_histories
  # POST /admin/qr_code_scan_histories.json
  def create
    @qr_code_scan_history = QrCodeScanHistory.new(qr_code_scan_history_params)

    respond_to do |format|
      if @qr_code_scan_history.save
        format.html { redirect_to [:admin, @qr_code_scan_history], notice: 'Qr code scan history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @qr_code_scan_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @qr_code_scan_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/qr_code_scan_histories/1
  # PATCH/PUT /admin/qr_code_scan_histories/1.json
  def update
    respond_to do |format|
      if @qr_code_scan_history.update(qr_code_scan_history_params)
        format.html { redirect_to [:admin, @qr_code_scan_history], notice: 'Qr code scan history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @qr_code_scan_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/qr_code_scan_histories/1
  # DELETE /admin/qr_code_scan_histories/1.json
  def destroy
    @qr_code_scan_history.destroy
    respond_to do |format|
      format.html { redirect_to admin_qr_code_scan_histories_url, notice: 'Qr code scan history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qr_code_scan_history
      @qr_code_scan_history = QrCodeScanHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qr_code_scan_history_params
      params.require(:qr_code_scan_history).permit(:user_id, :good_id, :good_instance_id, :score, :status)
    end
end
