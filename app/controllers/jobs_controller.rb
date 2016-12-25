class JobsController < InheritedResources::Base
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

   def index
		@jobs = Job.all.order('created_at DESC')
	end
	
	def new 
		@job = Job.new
		@category = Category.all	
		@japproval = Japproval.new
			
	end
	
	def create
		@job = Job.new(params[:job])
		@job.japproval_id ||= "1"	# To set the default value of japproval_id as pending
		@job.gender_id="4" if @job.gender_id.blank?
		if @job.save
			redirect_to new_job_path, :notice => "Your Job has been posted successfully,Please wait for Admin Approval"
		else
		    render "new"
		end
	end
	
		
	def show
		@job = Job.find(params[:id])
	end
	
	def findjobs
		@jobs = Job.all.order('created_at DESC')
	end
	
	
	
    private

    def record_not_found
		redirect_to root_path
    end

    def job_params
      params.require(:job).permit(:title, :company, :comurl, :designation, :minsalary, :maxsalary, :minexp, :maxexp, :category_id, :location_id, :mode_id, :jtype_id, :nperiod, :gender_id, :contactperson, :contactemail, :contactno, :description, :japproval_id)
    end
end

