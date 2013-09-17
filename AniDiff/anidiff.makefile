# Compiler flags...
CPP_COMPILER = g++
C_COMPILER = gcc

# Include paths...
Debug_Include_Path=-I"/usr/local/include/opencv"
Release_Include_Path=-I"/usr/local/include/opencv"

# Library paths...
Debug_Library_Path=-L"/usr/local/lib"
Release_Library_Path=-L"/usr/local/lib"

# Additional libraries...
Debug_Libraries=-Wl,--start-group -lopencv_core -lopencv_imgproc -lopencv_calib3d -lopencv_video -lopencv_features2d -lopencv_ml -lopencv_highgui -lopencv_objdetect -lopencv_contrib -lopencv_legacy -Wl,--end-group
Release_Libraries=-Wl,--start-group -lopencv_core -lopencv_imgproc -lopencv_calib3d -lopencv_video -lopencv_features2d -lopencv_ml -lopencv_highgui -lopencv_objdetect -lopencv_contrib -lopencv_legacy -Wl,--end-group

# Preprocessor definitions...
Debug_Preprocessor_Definitions=-D GCC_BUILD -D _DEBUG -D _CONSOLE
Release_Preprocessor_Definitions=-D GCC_BUILD -D NDEBUG -D _CONSOLE

# Implictly linked object files...
Debug_Implicitly_Linked_Objects=
Release_Implicitly_Linked_Objects=

# Compiler flags...
Debug_Compiler_Flags=-O0 -g
Release_Compiler_Flags=-O2

# Builds all configurations for this project...
.PHONY: build_all_configurations
build_all_configurations: Debug Release

# Builds the Debug configuration...
.PHONY: Debug
Debug: create_folders gccDebug/AniDiff.o
	g++ gccDebug/AniDiff.o   $(Debug_Library_Path) $(Debug_Libraries) -Wl,-rpath,./ -o ../gccDebug/AniDiff.exe

# Compiles file AniDiff.cpp for the Debug configuration...
-include gccDebug/AniDiff.d
gccDebug/AniDiff.o: AniDiff.cpp
	$(CPP_COMPILER) $(Debug_Preprocessor_Definitions) $(Debug_Compiler_Flags) -c AniDiff.cpp $(Debug_Include_Path) -o gccDebug/AniDiff.o
	$(CPP_COMPILER) $(Debug_Preprocessor_Definitions) $(Debug_Compiler_Flags) -MM AniDiff.cpp $(Debug_Include_Path) > gccDebug/AniDiff.d

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
	mkdir -p gccDebug
	mkdir -p ../gccDebug
	mkdir -p gccRelease
	mkdir -p ../gccRelease

# Cleans intermediate and output files (objects, libraries, executables)...
.PHONY: clean
clean:
	rm -f gccDebug/*.o
	rm -f gccDebug/*.d
	rm -f ../gccDebug/*.a
	rm -f ../gccDebug/*.so
	rm -f ../gccDebug/*.dll
	rm -f ../gccDebug/*.exe
	rm -f gccRelease/*.o
	rm -f gccRelease/*.d
	rm -f ../gccRelease/*.a
	rm -f ../gccRelease/*.so
	rm -f ../gccRelease/*.dll
	rm -f ../gccRelease/*.exe

