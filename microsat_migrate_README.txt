# Microsatellite Migrate-n FAU KoKo HPC, version 10/8/17
# Created by Michael Studivan (mstudiva@fau.edu)

# log onto cluster
ssh mstudiva@koko-login.fau.edu
# enter FAU password

#------------------------------
# BEFORE STARTING, replace, in this whole file:
#	- mstudiva@fau.edu by your actual email;
#	- mstudiva with your KoKo user name.

# The idea is to copy the chunks separated by empty lines below and paste them into your 
# cluster terminal window consecutively. 

# The lines beginning with hash marks (#) are explanations and additional instructions - 
# please make sure to read them before copy-pasting. 

#——————————————————————————————
# adding modules to your .bashrc so they load each time you login
cd
nano .bashrc
# add the following line under "User specific aliases and functions"
module load openmpi/2.0.2
# save using ctrl + x, keep name .bashrc
source .bashrc

mkdir bin 
cd bin
# install migrate 3.6.11
# wget http://popgen.sc.fsu.edu/currentversions/migrate-3.6.11.src.tar.gz
# tar vxf migrate-3.6.11.src.tar.gz
# cd migrate-3.6.11/src/
# ./configure
# make mpis
# cp migrate-n-mpi ~/bin/

#——————————————————————————————
# make folders for each model location
mkdir microsat
cd microsat

mkdir CBC
# etc

# upload Migrate-formatted subset datasets to KOKO: 
# log out of cluster first, must be on local machine first
cd /path/to/local/directory
scp -r infileMLG_CBC *parmfile* mstudiva@koko-login.fau.edu:~/path/to/model/directory
# There should be one infile and 4 parmfiles

# repeat for all other models

# running the models
echo "mpirun -np 100 migrate-n-mpi parmfileA -nomenu" > migrate

# to run the migrate commands, first you need to modify the file so it appears as a job 
# script in SLURM
nano migrate
# use return to add a line at the beginning and add the following text (including the #):

#!/bin/sh
#SBATCH --partition longq7
#SBATCH --nodes 5
#SBATCH --exclusive
#SBATCH --mail-type=all
#SBATCH --mail-user=mstudiva@fau.edu

# modify parmfile to parmfileA
# exit using Ctrl+X, save using ‘y’ and overwrite as migrate

cp migrate migrateB
cp migrate migrateC
cp migrate migrateD
mv migrate migrateA
# edit each migrate script to reflect the parmfileA-D

sbatch migrateA
sbatch migrateB
sbatch migrateC
sbatch migrateD

squeue -u mstudiva

# launcher creator is a job submission script and will automatically spread tasks across
# cores and nodes evenly
# does not appear to work with openmpi
# launcher_creator.py -j migrate -n migrate -q shortq7 -t 2:00:00 -N 5 -e mstudiva@fau.edu

# copy the output files to your local machine (scp from the local machine)
cd /path/to/local/directory
scp mstudiva@koko.fau.edu:~/path/to/model/directory/* .

# repeat for all other models