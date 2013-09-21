# Compiler flags...
CPP_COMPILER = g++
C_COMPILER = gcc

# Include paths...
Release_Include_Path=-I"/usr/local/include/opencv"

# Library paths...
Release_Library_Path=-L"/usr/local/lib"

# Additional libraries...
Release_Libraries=-Wl,--start-group -lopencv_core -lopencv_imgproc -lopencv_calib3d -lopencv_video -lopencv_features2d -lopencv_ml -lopencv_highgui -lopencv_objdetect -lopencv_contrib -lopencv_legacy -Wl,--end-group

# Preprocessor definitions...
Release_Preprocessor_Definitions=-D GCC_BUILD -D NDEBUG -D _CONSOLE

# Implictly linked object files...
Release_Implicitly_Linked_Objects=

# Compiler flags...
Release_Compiler_Flags=-O2

# Builds all configurations for this project...
.PHONY: build_all_configurations
build_all_configurations: Release

# Builds the Release configuration...
.PHONY: Release
Release: create_folders gccRelease/AniDiff.o
	g++ gccRelease/AniDiff.o   $(Release_Library_Path) $(Release_Libraries) -Wl,-rpath,./ -o ../gccRelease/AniDiff.exe

# Compiles file AniDiff.cpp for the Release configuration...
-include gccRelease/AniDiff.d
gccRelease/AniDiff.o: AniDiff.cpp
	$(CPP_COMPILER) $(Release_Preprocessor_Definitions) $(Release_Compiler_Flags) -c AniDiff.cpp $(Release_Include_Path) -o gccRelease/AniDiff.o
	$(CPP_COMPILER) $(Release_Preprocessor_Definitions) $(Release_Compiler_Flags) -MM AniDiff.cpp $(Release_Include_Path) > gccRelease/AniDiff.d

# Creates the intermediate and output folders for each configuration...
.PHONY: create_folders
create_folders:
	mkdir -p gccRelease
	mkdir -p ../gccRelease

# Cleans intermediate and output files (objects, libraries, executables)...
.PHONY: clean
clean:
	rm -f gccRelease/*.o
	rm -f gccRelease/*.d
	rm -f ../gccRelease/*.a
	rm -f ../gccRelease/*.so
	rm -f ../gccRelease/*.dll
	rm -f ../gccRelease/*.exe