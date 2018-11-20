# Trajectories-data-WRR-2018
This data repository contains the raw PET data (Figure 5), onset arrival time (Figure 6), permeability inversion results (Figure 7), and trajectory data (Figure 8) for the paper titled 'Calculating trajectories associated with solute transport in a heterogeneous medium'. Matlab codes for data plotting may be made available upon request.

"figure5_ASCII_data" data file is written such that:
col 1 = y (up-down looking down the axis of the core), y = 0 is top of core
col 2 = x (left-right looking down axis of core), x = 0 is left side
col 3 = z (parallel to the axis of the core), z = 0 is inlet
col 4 = time (sec)
col 5 = raw radioactivity concentration

Spatial data is in units of cm, time is in seconds, radioactivity
concetration is in unscaled microcurries

The default delimiter is comma, this can be changed to space, or tab
(just change commenting in 'Data write to file' section of the 
ascii_data_conversion.m script).

"figure6_onset_time_ASCII_data" and "figure7_perm_ASCII_data" data files are written such that:
The file headers have nx, ny, nz and 
xmin, xmax, ymin, ymax [the maximum and minimum for z are the same as for x].
The files are written in the loop with nx fastest, ny intermediate, and nz in the
outer loop.  The indices for ix and jy are included in each line of the file. 
Units are meters, seconds, and m^2


"figure8_traj_ASCII_data" is written so that every line is a trajectory coordinate

matlab data files are same data as ASCII files, just formated so that the data are
3D or 4D matrices with voxel size of 2.3291 mm x 2.3291 mm x 2.388 mm
