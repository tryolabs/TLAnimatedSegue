# TLAnimatedSegue
[![Version](https://img.shields.io/cocoapods/v/TLAnimatedSegue.svg?style=flat)](http://cocoadocs.org/docsets/TLAnimatedSegue)
[![License](https://img.shields.io/cocoapods/l/TLAnimatedSegue.svg?style=flat)](http://cocoadocs.org/docsets/TLAnimatedSegue)
[![Platform](https://img.shields.io/cocoapods/p/TLAnimatedSegue.svg?style=flat)](http://cocoadocs.org/docsets/TLAnimatedSegue)

TLAnimatedSegue is a storyboard segue that allow you to write animated transisions between controllers leverage the actual presentation of the new controller to the internal segue logic.

## Usage

The project contains two classes: `TLPresentSegue` and `TLAnimatedSegue`. The last one inherit from the first.

To use this segue you need to setup it on your storyboard like any other segue. XCode detect the UIStoryboardSegue subclass you have on your project and will let you pick it right in your storyboard.

![seguesetup](http://zippy.gfycat.com/SparseSpotlessBubblefish.gif)

Then you provide it with an object that conforms to the TLAnimatedSegueDelegate protocol.

```objective-c
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue isKindOfClass:[TLAnimatedSegue class]]) {
        ((TLAnimatedSegue *) segue).delegate = self;
    }
}
```

This protocol declares a method that is called before the actual presentation to ocurr alow you to code a animation at the right time.

```objective-c
    - (void)animateSegueFormViewController:(UIViewController *)sourceController toViewController:(UIViewController *)destinationController onComplete:(void (^)(void))onComplente {
    ...
    }
```

Once your animation end you need to call the `onComplete` callback to let know the segue that must continue with the presentation. The TLAnimatedSegueDelegate protocol exten from TLPresentSegueDelegate protocol so it also allow you to control if this new controler should replace the current one or just present it at top of the presentation stack.

TLAnimatedSegue extend from TLPresentSegue that abstract the presentation for the case if there is a navigation controller or not so you can use this segues in almost any case.

To run the example project you can clone the repo and run the project in the `Example` directory or just do `pod try TLAnimatedSegue` on your terminal.

![example](http://zippy.gfycat.com/SpicyTotalGoitered.gif)

## Installation

TLAnimatedSegue is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "TLAnimatedSegue"

You can allways opt to clon the repo and integrate the code under `Pod/Classes` to your project as you like.

## Author

BrunoBerisso, bruno@tryolabs.com

## License

TLAnimatedSegue is available under the MIT license. See the LICENSE file for more info.

