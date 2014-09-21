#!/usr/bin/python3
#given 2 files in this format: <filetype>:<filename>:<last modification time(unix timestamp)>
#finds the files that differ i.e.	1. Exist in one file but not the other
#							2. Have a newer modification date in one of the files
#outputs a file containg the name of the file and the what to do with it.
#i.e.	1. Update(Files only)
#		2. Create(Directories too)
#		3. Delete(Directories too)
#Output Format:
#		<filename>:<type>:<Action>
#		/home/shit/some/dir:DIR:CREATE
#		/home/shit/some/file:FILE:UPDATE


#Info about a file
class fileinfo:
	def __init__(self, infostr):
		tmp = infostr.split(":")
		self.type = tmp[0]
		self.filename = tmp[1]
		self.lmdate = int(tmp[2])
	
	def __str__(self):
		s = "" + self.filename + " is a " + self.type + " last modified on " + str(self.lmdate)
		return s
		
		
if __name__  == "__main__":
	import sys
	try:
		if len(sys.argv) < 5:
			raise Exception("I do not have all the shit I need to do my thing!")
		
		pwd = sys.argv[1]
		
		cur_file = open(sys.argv[2], "r")
		prev_file = open(sys.argv[3], "r")
		action_file = open(sys.argv[4], "a")
		
	except:
		print("You done fucked up, man")
		sys.exit()
	else:
		print("Continuing")
		
	#list of files in current state
	curlist = [fileinfo(line) for line in cur_file.readlines()]
	#list of files in previous state
	prevlist = [fileinfo(line) for line in prev_file.readlines()]
	
	bd_hash = {}
	
	#Adding both to a hash using the list name and the filename as key
	for it in curlist:
		bd_hash["cur" + it.filename] = it
		
	for it in prevlist:
		bd_hash["prev" + it.filename] = it
		
	#check entries in curlist against itself in prevlist
	for it in curlist:
		checker = "prev" + it.filename
		if checker in bd_hash:
			if it.type != "DIR":
				#in both, so add to last modification checking list, if it's not a directory
				if it.lmdate > bd_hash[checker].lmdate:
					action_file.write(pwd + it.filename + ":" + it.type + ":UPDATE\n")
					#print(pwd + pair[0].filename + ":" + pair[0].type + ":UPDATE")
		else:
			#in cur, but not in prev => creation event
			if it.type == "DIR":
				pass
				#special handling for directory creation
				#import subprocess
				#subprocess.call("./dirinit.sh " + pwd + it.filename, shell=True)
			action_file.write(pwd + it.filename + ":" + it.type + ":CREATE\n")
			#print(pwd + it.filename + ":" + it.type + ":CREATE")
	
	#check entries in prevlist against itself in curlist
	for it in prevlist:
		checker = "cur" + it.filename
		if not checker in bd_hash:
			#in prev, but not in cur => deletion event
			action_file.write(pwd + it.filename + ":" + it.type + ":DELETE\n")
			#print(pwd + it.filename + ":" + it.type + ":DELETE")
		#no need to handle if it is in cur, cause already handled in last for loop
				
	#done
