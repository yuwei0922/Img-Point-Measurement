# Img-Point-Measurement
Two MATLAB projects for the measurement of image point coordinate in the close-range photogrammetry control field of Wuhan University.

## centroid.m
Connected Component Grayscale Centroid Algorithm

Algorithm Basic Steps:

1) Gaussian Filtering of Grayscale Image: Convert the image to grayscale and apply Gaussian filtering for noise reduction.
2) Binarization: Apply Otsu's method (maximum between-class variance) to select an appropriate threshold for binarization.
3) Opening Operation: Used to eliminate image noise.
4) Connected Component Extraction: Extract all connected regions in the image, identifying circles/ellipses corresponding to control points by limiting the region area, eccentricity, and the shape of the minimum bounding rectangle.
5) Centroid Extraction: Extract centroids of the connected regions using built-in functions in Matlab.

## hough.m
Hough Circle Detection Algorithm

Algorithm Basic Steps:

1) Gaussian Filtering of Grayscale Image: Convert the image to grayscale and apply Gaussian filtering for noise reduction.
2) Edge Detection: Utilize the Canny operator to detect edge points.
3) Hough Transform: Apply Hough transform to edge points, building an accumulator in polar coordinate space to accumulate potential radius ranges for each circle center point.
4) Initial Filtering: Perform Gaussian smoothing and non-maximum suppression on the accumulator to identify potential circle center points and radii.
