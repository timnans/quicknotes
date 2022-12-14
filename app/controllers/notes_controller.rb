class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /notes or /notes.json
  def index
    @notes = current_user.notes.all.order(created_at: :desc)
  end

  def search
    if params[:query].present?
      @notes = current_user.notes.where("name LIKE ?", "%#{params[:query]}%").order(created_at: :desc)
    else
      @notes = current_user.notes.all.order(created_at: :desc)
    end

    render turbo_stream: turbo_stream.replace(
      "notes",
      partial: "list",
      locals: {
        notes: @notes,
      }
    )
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = current_user.notes.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = current_user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        @notes = current_user.notes.all.order(created_at: :desc)
        format.turbo_stream
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        # format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        @notes = current_user.notes.all.order(created_at: :desc)

        format.turbo_stream
        # format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        # format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = current_user.notes.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:name, :content)
  end
end
