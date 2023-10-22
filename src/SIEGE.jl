module SIEGE

export main

using Pkg
using PackageCompiler

function main(project_folder_name, path = pwd() )

	# Set paths
	parent_directory = path
	@info("Working in:",parent_directory)
	project_directory = joinpath(parent_directory, project_folder_name)
	build_directory = joinpath(parent_directory, "build")

	my_depot = joinpath(build_directory, "depot")
	my_sysimage = joinpath(build_directory, "sysimage.so")

	if isdir(my_depot)
		@info("Depot already exists; using existing depot", my_depot)
	end

	# Set up new environment
	new_environment = copy(ENV)
	delete!(new_environment, "JULIA_LOAD_PATH");
	new_environment["JULIA_DEPOT_PATH"] = my_depot
	new_environment["JULIA_PROJECT"] = project_directory

	run(setenv(`$(Base.julia_cmd()) -e "import Pkg; Pkg.instantiate(); Pkg.precompile()"`, new_environment))

	# Create sysimage
	create_sysimage(String[];
		sysimage_path = my_sysimage,
		project = project_directory,
		incremental = true,
		filter_stdlibs = false,
		include_transitive_dependencies = true,
	)

	# Delete local files from build depot
	rm(joinpath(my_depot, "compiled"), recursive = true, force = true)
	rm(joinpath(my_depot, "logs"), recursive = true, force = true)

	return
end

end # module SIEGE
