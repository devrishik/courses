class SubjectsController < ApplicationController

	before_action :authenticate! , :except => [:addSubject]

	def index
		@subjects = Subject.all
		@user = current_user
	end

	def show
		@subject = Subject.find(params[:id])
		@regUsers = @subject.users
	end

	def addSubject
	  	@check = Attending.where(user_id: current_user.id, subject_id: params[:user][:subject_id] ).first
	  	@attend = Attending.new
	  	@attend.user_id = current_user.id
	  	@attend.subject_id = params[:user][:subject_id]
	  	if @check
	  		if @attend.user_id == @check.user_id && @attend.subject_id == @check.subject_id
	  			flash[:notice] = "Subject Already present in your list"
	  		end
	  	elsif @attend.save
	  		flash[:notice] = "Subject added to you list"
	  	end
	  	respond_to do |format|
	  		format.html { redirect_to subject_path(@attend.subject_id) }
	  		format.js 
	  	end
	  	# redirect_to subject_path(@attend.subject_id)
  	end

  	def new
  		if current_user.admin
  			@subject = Subject.new
  		end  		
  	end

  	def create
  		if current_user.admin
  			@subject =  Subject.new subject_params
  			if @subject.save
  				redirect_to subjects_path, :notce => "New subject created"
  			else
  				render action "new"
  			end
  		end 			
  	end

  	def edit
  		if current_user.admin
  			@subject = Subject.find(params[:id])
  		end
	end


	def update
		if current_user.admin
			@subject = Subject.find(params[:id])
		  	if current_user.admin
			  if @subject.update(params[:subject].permit(:name))
			    redirect_to @subject
			  else
			    render 'edit'
			  end
			else
				redirect_to @subject
			end	
		end
	end

	def destroy
	  @subject = Subject.find(params[:id])
	  if current_user.admin
	 	@subject.destroy
	  end
	  redirect_to @subject
	end

	private

	def subject_params
		params.require(:subject).permit(:name)
	end
end
