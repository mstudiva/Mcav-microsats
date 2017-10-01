# Microsatellite Migrate-n FAU KoKo HPC, version 6/11/17
# Created by Michael Studivan (mstudiva@fau.edu)

# log onto cluster
ssh mstudiva@koko-login.fau.edu
# enter FAU password

#------------------------------
# BEFORE STARTING, replace, in this whole file:
#	- mstudiva@fau.edu by your actual email;
#	- mstudiva with your KoKo user name.

# The idea is to copy the chunks separated by empty lines below and paste them into your cluster 
# terminal window consecutively. 

# The lines beginning with hash marks (#) are explanations and additional instructions - 
# please make sure to read them before copy-pasting. 

#——————————————————————————————
mkdir bin

#install openmpi
cd bin/
wget https://www.open-mpi.org//software/ompi/v2.1/downloads/openmpi-2.1.1.tar.gz
tar vxf openmpi-2.1.1.tar.gz
cd openmpi-2.1.1/
mkdir build
cd build/
../configure
make

#install migrate 3.6.11
wget http://popgen.sc.fsu.edu/currentversions/migrate-3.6.11.src.tar.gz
tar vxf migrate-3.6.11.src.tar.gz
cd migrate-3.6.11/src/
./configure
make clean
make mpis
cp migrate-n-mpi ~/bin/

#——————————————————————————————
# upload Migrate-formatted subset datasets to KOKO: 

#secure copy of sequence files directory to cluster backup directory
#log out of cluster first, must be on local machine first
scp 
scp -r infileCBC infileEFGB infileWFGB infilePRTER infileNWGOM mstudiva@koko-login.fau.edu:~/microsat/
cd /path/to/local/directory/
scp * mstudiva@koko.fau.edu:~/microsat/

#move each subset datafile into a subset directory
mkdir CBC
mv infileCBC CBC/
#etc

echo "mpirun -np 100 /home/mstudiva/bin/migrate-3.6.11/src/migrate-n-mpi parmfileA -nomenu" > migrateA
launcher_creator.py -j migrate -n migrate -q longq7 -e mstudiva@fau.edu

cp migrateA.slurm migrateB.slurm
cp migrateA.slurm migrateC.slurm
cp migrateA.slurm migrateD.slurm
# edit each migrate script to reflect the parmfileA-D

sbatch migrateA.slurm
sbatch migrateB.slurm
sbatch migrateC.slurm
sbatch migrateD.slurm

squeue

#copy the output files to your local machine (scp from the local machine)
cd /path/to/local/directory/
scp mstudiva@koko.fau.edu:~/microsat/GOM/*outfile* .

