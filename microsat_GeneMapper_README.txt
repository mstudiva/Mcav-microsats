Microsatellite Scoring with GeneMapper 3.7, version 12/8/16
Created by Michael Studivan (mstudiva@fau.edu)

------------------------------
Note: Save often (with backup copies) and do not leave GeneMapper open if your computer 
goes to sleep. It will break the link with the database and will not allow you to save.
------------------------------

1.	Open GeneMapper 3.7 using username gm, and password ########
2.	Create new project. 
		a.	Each screened plate shows up as several run folders containing individual 
			wells’ sequence data as .fsa files.
		b.	Individual files or plates can be selected by highlighting each of the desired 
			folders to the left.
		c.	Highlight “Project” to display all the .fsa files associated with the project.
3.	Samples can be imported by clicking Add Samples to Project and locating the .fsa 
	files.
	
------------------------------
Follow step 4 only if you are creating new bin sets. Otherwise, continue to step 5.
------------------------------

4.	Create a new Panel using the Panel Manager or use the existing “Mcav msats.”
		a.	First, create a new Kit.
		b.	Then, create new Panels within the Kit for each of the multiplex groups.
		c.	Create new Markers for each Panel with the locus data and dye type.
		d.	Add Bins to each marker using the Add Bin button. Bins are allele size ranges 
			that correspond to allele lengths seen in reference samples and will allow 
			GeneMapper to automatically assign allele calls to your samples.
5.	Open the GeneMapper Manager.
		a.	Import project (.ser file), select Import… under Projects.
		b.	Import analysis method (Mcav msats), select Import… under Analysis Methods.
		c.	Import table settings (Mcav msats).
		d.	Import plot settings (Mcav msats).
		e.	Import size standard (Mcav msats ROX500).
6.	Once all samples are imported, the metadata will be displayed for each 
	sample/well.
		a.	Analysis Method: Mcav msats
		b.	Leave Panel blank for now
		c.	Size Standard: Mcav msats ROX500
7.	If you multiplexed loci, select all samples and sort using these two columns:
		a.	Run Date & Time, Ascending
		b.	Sample Name, Ascending
		c.	This will sort all the samples in chronological order, BUT DOES NOT ALWAYS 
			ORDER THE WELLS CORRECTLY.
		d.	Click within the Panel cell for each sample and select the appropriate Plex.
8.	Check the status of each run by looking at the color-coded shapes under columns SFNF, 
	MNF, SNF, OS, and SQ.
		a.	The main one to look at is SQ, which relates to the quality of the size ladder 
			calls.
		b.	Sort all by SQ to group all the ones that failed or have yellow triangles 
			(check).
		c.	Check each and every run ladder by using the Size Match Editor. 
		d.	Change any errors in the ladder.
		e.	For the samples where the ladder is correct, highlight all the samples and 
			select Edit, Override all SQ.
9.	When any changes are made to the Panel, Analysis Method, or SQ, or if you are ready to 
	analyze samples, you press the green play button labeled Analyze.
		a.	GeneMapper will autosave every 10 samples.
10.	Check each and every run using the Display Plots button to examine and modify allele 
	base calls if necessary. A list of bins will show up when you go to change the call.
		a.	There seems to be instrument shift from 1-2bp to the right. The bins have been 
			extended to capture most of these skewed lengths, but double check everything 
			just in case. In most cases, you will not be rounding up peak lengths to the 
			next allele, rather rounding down to the previous allele.
11.	When all the data is ready to export for statistical analyses, use Export Table to 
	export as .txt or .csv.
12.	To backup the project file, open GeneMapper Manager, and select Export on a 
	highlighted project.
