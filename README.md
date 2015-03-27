## Backstory

Midway through last year, we were building something that required us to read the entire pixel color data of a large number of images, in the fastest possible time. Searching brought us upon various different ways to read pixel data. Each of these would be ideal if your case is to read a single pixel, where optimisation isn't a necessary concern. But multiplying that use, reading much larger portions of an image, most of these fell down. The one we settled on originally, high in the StackOverflow results, would read pixel data 20x slower than our eventual solution.

So we found the fastest way to read pixel data, but there was further optimisation to be made when it comes to reading the image as a whole. It turns out that with pixel reading so fast, the biggest downfall was the ramp-up and ramp-down time of generating a color space and the image's pixel data. Those things are generated for the image, each time you want the color of a pixel. Wait, so are you thinking what I'm thinking? How about we just do it once, for the whole image? That's what we've done. We have a subclass of UIImage, called `MBInspectionImage`. It's initialised like so:

**Objective-C**
`[[MBInspectionImage alloc] initWithImage:[UIImage imageNamed:@"my_image"]]`

**Swift**
`MBInspectionImage(image: UIImage(named:"my_image"))`

And it has these methods:

`- (UIColor *)colorForPixelAtPoint:(CGPoint)point;`

`- (NSArray *)colorsForPixelsInRect:(CGRect)rect;`

`- (NSArray *)colorsForAllPixels;`

It's so simply, and it's super fast. A 1024x1024 image can be read in under a second.

Also, sort of interesting:
MBInspectionImage is written in Objective-C. If you check the commit history, you can see that I tried a Swift version first, but it was simply much slower. This was mainly caused by using a Swift Array, but even cutting out all array work, it was just slower.


## Demo

Tap anywhere on the image to get a color reading of that pixel, and the time taken. Or tap the "Analyze Image" button to process the whole image.


The demo comes with an image curtosy of [Matteo Minelli on Unsplash](https://unsplash.com/photos/VgdFyOOu1PA).

## Installation

All you need to do to install is:

Drag `MBInspectionImage.h` and `MBInspectionImage.m` into your project.