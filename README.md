# Principal Component Analysis

### Introduction

Principal component analysis can be used to classify data that is seemingly grouped. Data can be processed so that each individual component can be identified as unique through various methodologies. The method used in this implementation utilizes double thresholding for background deletion. Each continuous object should then be identifiable as a unique entity. PCA can then be applied to classify each object. The center of mass for each object can be used to identify the center of the object.
After constructing a covariance matrix for an object, the major and minor axes an ellipse can be computed. The orientation of the ellipse can be determined by obtaining the eigenvalues. Each object can then be classified using the data available. In this implementation, the data is used to identify the types of fruits in an image.

In order to classify the fruits and provide axes on them, a series of steps were performed.  First, we classified the picture into moments which divides the picture into regions.  The image is labeled as f(x,y).  
The image is also classified as dark gray or not dark gray which allows Matlab to find the specific labeled regions.  


Figure 1: Original Image:

![Original picture
](./READMEImage/F1.bmp)


### Classification Methodology

The moments are in 2D with the labels m00, m01, m10, m11, m20, and m02.  These moments were then used to calculate the central moment of the picture’s regions.  If there was no centroid of a region, then the 
calculation would exit the central moment for loop calculation.  Now that the central moments of the regions have been calculated for the picture, the eigen-values can be calculated.  The eigen-values are what classify each fruit. Bananas, oranges, and apples all have different axis lengths.  The eigenvalues are used to calculate the semimajor and semiminor axis lengths. 


These axes lengths help calculate the eccentricity.  The eccentricity is used to classify the shape of the fruit.  If the eccentricity value is closer to 0 then the shape is closer to a circle.  If the eccentricity value is
closer to 1 then the shape is closer to a line.  To find the eccentricity, the equation uses the distance from the center of an ellipse.  For the banana in the picture, if the eccentricity value calculated in the program was calculated between 0.94 and 0.98, then the axis was paired with the banana.  If the eccentricity value was less than 0.6 but more than 0, then it was classified as “round fruit,” which is the apples and the oranges.  Then we had to differentiate between the apples and oranges since both of the fruits are round.  If the radius of the fruit is larger than the mean, then that fruit was classified as an orange. Below displays the final image with the respected axes to each fruit.   

* Bananas

Bananas are identified by computing the eccentricity of the matched ellipse. If the eccentricity of the object is be- tween .94 and .98 with an appropriate length, then it is assumed that the respective fruit is a banana.

* Apples & Oranges

Oranges are classified according to size. Since it is highly probable that the fruits will be of different sizes under dif- ferent circumstances, the sizing of the fruits needs to be dynamic. This is achieved by computing the sizes of the fruits using the distance formula.

The sizes of the fruits are then stored in a array associa- ted with another array of the following format: [[major_x, major_y, minor_x, minor_y]]. Every object with a radius below one standard deviation of the mean is culled. Objects that are larger than average are deemed to be oranges. The rest of the fruits are classified as apples.

### Result 
Figure 2: 

![](./READMEImage/F2.jpg)

Figure 3: 

![](./READMEImage/F3.jpg)

Figure 4: 

![](./READMEImage/F4.jpg)
