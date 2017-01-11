class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /posts/:post_id/comments
  # GET /posts/:post_id/comments.json
  def index
    #@comments = Comment.all
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you get all the comments of this post
    @comments = post.comments

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render json: @comments }
    end

  end

  # GET /posts/:post_id/comments/:id
# GET /comments/:id.json
  def show
    #1st you retrieve the post thanks to params[:post_id]
   post = Post.find(params[:post_id])
   #2nd you retrieve the comment thanks to params[:id]
   @comment = post.comments.find(params[:id])

   respond_to do |format|
     format.html # show.html.erb
     format.json  { render json: @comment }
   end
  end

  # GET /posts/:post_id/comments/new
  # GET /posts/:post_id/comments/new.json
  def new
    #@comment = Comment.new
    #1st you retrieve the post thanks to params[:post_id]
   post = Post.find(params[:post_id])
   #2nd you build a new one
   @comment = post.comments.build

   respond_to do |format|
     format.html # new.html.erb
     format.json  { render json: @comment }
   end

  end

  # GET /posts/:post_id/comments/:id/edit
  def edit
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])
  end

  # POST /posts/:post_id/comments
   # POST /posts/:post_id/comments.json
  def create
    #@comment = Comment.new(comment_params)

    #1st you retrieve the post thanks to params[:post_id]
   post = Post.find(params[:post_id])
   #2nd you create the comment with arguments in params[:comment]
   @comment = post.comments.create(params[:comment])


    respond_to do |format|
      if @comment.save
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        #format.json { render :show, status: :created, location: @comment }

        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource comment
        format.html { redirect_to([@comment.post, @comment], notice: 'Comment was successfully created.') }
        #the key :location is associated to an array in order to build the correct route to the nested resource comment
        format.json  { render json: @comment, status: :created, location: [@comment.post, @comment] }

      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/:post_id/comments/:id
 # PUT /posts/:post_id/comments/:id.json
  def update
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])

    respond_to do |format|
      #if @comment.update(comment_params)
       #format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        #format.json { render :show, status: :ok, location: @comment }
      if @comment.update_attributes(params[:comment])
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource comment
        format.html { redirect_to([@comment.post, @comment], notice: 'Comment was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/:post_id/comments/1
  # DELETE /posts/:post_id/comments/1.json
  def destroy
    #1st you retrieve the post thanks to params[:post_id]
     post = Post.find(params[:post_id])
     #2nd you retrieve the comment thanks to params[:id]
     @comment = post.comments.find(params[:id])
     @comment.destroy
    respond_to do |format|
      #format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.html { redirect_to(post_comments_url) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:commenter, :body, :post_id)
    end
end
