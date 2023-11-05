using Pkg
path_to_SIEGE = "Path/To/SIEGE"
project_folder_name = "ssm_hz"
Pkg.activate(temp=true)
Pkg.develop(path=path_to_SIEGE)
using SIEGE
main(project_folder_name, path_to_SIEGE)
