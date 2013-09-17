#include "opencv/cv.h"
#include "opencv2/core/core.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <stdio.h>
#define _USE_MATH_DEFINES
#include <math.h>

using namespace cv;
using namespace std;  // std c++ libs implemented in std

#ifdef GCC_BUILD
#define sprintf_s sprintf
#endif