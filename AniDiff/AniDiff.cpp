// AniDiff.cpp : Defines the entry point for the console application.
//

#ifdef _MSC_VER
#include "stdafx.h"
#endif
#include <stdio.h>
#include "AniDiff.h"

int main(int argc, char *argv[])
{
   int h,w,d;

   Mat original,resized,output;
   Mat GradH,GradV,Grad;
   Mat Edges;
   Mat g;
   Mat temp;
   Mat RGB[3];
   Mat rgb[3];
   Mat edges[3];
   char fname[64];
   int iterations;
   double edgestop;
   double diffusing;
   char inputf[64];
   char outputf[64];
   double scale;
   int ksize;
   double kernelscale;

   strcpy_s(inputf,argv[1]);
   strcpy_s(outputf,argv[2]);
   scale = (double)atof(argv[3]);
   iterations = atoi(argv[4]);
   edgestop = (double)atof(argv[5]);
   diffusing = (double)atof(argv[6]);
   ksize = atoi(argv[7]);
   kernelscale = 1.0/(pow(2.0,ksize)-4);

   original = imread(inputf,CV_LOAD_IMAGE_COLOR);
   resize(original,resized,Size(),scale,scale,INTER_CUBIC);
   h = resized.rows;
   w = resized.cols;
   d = resized.depth();
   Grad  = Mat(h,w,CV_64F);
   GradH = Mat(h,w,CV_64F);
   GradV = Mat(h,w,CV_64F);
   g = Mat(h,w,CV_64F);
   temp = Mat(h,w,CV_64F);
   Edges  = Mat(h,w,CV_64F);
   output = resized.clone();


   split(resized,RGB);
   RGB[0].convertTo(rgb[0],CV_64F);
   RGB[1].convertTo(rgb[1],CV_64F);
   RGB[2].convertTo(rgb[2],CV_64F);
   Sobel(RGB[0],GradH,CV_64F,0,1,3,1.0);
   Sobel(RGB[0],GradV,CV_64F,1,0,3,1.0);
   temp=GradH.mul(GradH)+GradV.mul(GradV);
   sqrt(temp,edges[0]);
   Sobel(RGB[1],GradH,CV_64F,0,1,3,1.0);
   Sobel(RGB[1],GradV,CV_64F,1,0,3,1.0);
   temp=GradH.mul(GradH)+GradV.mul(GradV);
   sqrt(temp,edges[1]);
   Sobel(RGB[2],GradH,CV_64F,0,1,3,1.0);
   Sobel(RGB[2],GradV,CV_64F,1,0,3,1.0);
   temp=GradH.mul(GradH)+GradV.mul(GradV);
   sqrt(temp,edges[2]);
   Edges=((edges[0]+edges[1]+edges[2])/3)>100;
   RGB[0]=RGB[0].mul(1-Edges);
   RGB[1]=RGB[1].mul(1-Edges);
   RGB[2]=RGB[2].mul(1-Edges);
   merge(RGB,3,output);

   for (int i=0;i<iterations;i++)
   {
      for (int j=0;j<3;j++)
      {
         // gradient
         Sobel(rgb[j],GradH,-1,0,1,7,1.0/1024.0);
         Sobel(rgb[j],GradV,-1,1,0,7,1.0/1024.0);

         // edge stopping factor
         temp=GradH.mul(GradH)+GradV.mul(GradV);
         g = 1.0/(1.0+edgestop*temp);

         // Div of gradient
         Laplacian(rgb[j],temp,CV_64F,7,1.0/65536.0);
          rgb[j]=rgb[j]+diffusing*g.mul(temp);
         rgb[j].convertTo(RGB[j],CV_8U);
      }
      merge(RGB,3,output);
      if (i%100==0)
      {
         sprintf_s(fname,"%s_%05d.jpg",outputf,i);
         imwrite(fname,output);
         RGB[0]=RGB[0].mul(1-Edges);
         RGB[1]=RGB[1].mul(1-Edges);
         RGB[2]=RGB[2].mul(1-Edges);
         merge(RGB,3,output);
         sprintf_s(fname,"%s_edges_%05d.jpg",outputf,i);
         imwrite(fname,output);
      }
   }

   sprintf_s(fname,"%s_%05d.jpg",outputf,iterations);
   imwrite(fname,output);
   RGB[0]=RGB[0].mul(1-Edges);
   RGB[1]=RGB[1].mul(1-Edges);
   RGB[2]=RGB[2].mul(1-Edges);
   merge(RGB,3,output);
   sprintf_s(fname,"%s_edges_%05d.jpg",outputf,iterations);
   imwrite(fname,output);
   return 0;
}

