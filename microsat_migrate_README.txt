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
# add the following lines under "User specific aliases and functions"
module load openmpi/2.0.2
module load migrate-n/3.6.11
# save using ctrl + x, keep name .bashrc
source .bashrc

# you should not need to install migrate-n on your own account, but the instructions are 
# provided just in case
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
cd /Users/Mike/Documents/Grad_School/Dissertation/Data/Microsatellites/Migrate/CBC
scp -r infileMLG_CBC *parmfile* mstudiva@koko-login.fau.edu:~/microsat/MLG/CBC
# There should be one infile and 4 parmfiles

# repeat for all other models
scp -r infileMLG_EFGB *parmfile* mstudiva@koko-login.fau.edu:~/microsat/MLG/EFGB
scp -r infileMLG_WFGB *parmfile* mstudiva@koko-login.fau.edu:~/microsat/MLG/WFGB
scp -r infileMLG_PRTER *parmfile* mstudiva@koko-login.fau.edu:~/microsat/MLG/PRTER
scp -r infileMLG_NWGOM *parmfile* mstudiva@koko-login.fau.edu:~/microsat/MLG/NWGOM
scp -r infileMLG_GOM *parmfile* mstudiva@koko-login.fau.edu:~/microsat/MLG/GOM

# running the models
echo "mpirun -np 100 migrate-n-mpi parmfile -nomenu" > migrate

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
# currently not working
# launcher_creator.py -j migrate -n migrate -q shortq7 -t 2:00:00 -N 5 -e mstudiva@fau.edu

# copy the output files to your local machine (scp from the local machine)
cd /Users/Mike/Documents/Grad_School/Dissertation/Data/Microsatellites/Migrate/GOM
scp mstudiva@koko.fau.edu:~/microsat/GOM/*outfile* .

# repeat for all other models