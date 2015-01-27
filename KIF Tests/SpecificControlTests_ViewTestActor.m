//
//  NewSpecificControlTests.m
//  KIF
//
//  Created by Alex Odawa on 1/27/15.
//
//

#import <KIF/KIF.h>

@interface SpecificControlTests_ViewTestActor : KIFTestCase
@end

@implementation SpecificControlTests_ViewTestActor

- (void)beforeEach
{
    [[viewTester usingLabel:@"Tapping"] tap];
}

- (void)afterEach
{
    [[[viewTester usingLabel:@"Test Suite"] usingTraits:UIAccessibilityTraitButton] tap];
}

- (void)testTogglingASwitch
{
    [[[[viewTester usingLabel:@"Happy"] usingValue:@"1"] usingTraits:UIAccessibilityTraitNone] waitForView];
    [[viewTester usingLabel:@"Happy"] setSwitchOn:NO];
    [[[[viewTester usingLabel:@"Happy"] usingValue:@"0"] usingTraits:UIAccessibilityTraitNone] waitForView];
    [[viewTester usingLabel:@"Happy"] setSwitchOn:YES];
    [[[[viewTester usingLabel:@"Happy"] usingValue:@"1"] usingTraits:UIAccessibilityTraitNone] waitForView];
}

- (void)testMovingASlider
{
    [viewTester waitForTimeInterval:1];
    [[viewTester usingLabel:@"Slider"] setSliderValue:3];
    [[[[viewTester usingLabel:@"Slider"] usingValue:@"3"] usingTraits:UIAccessibilityTraitNone] waitForView];
    [[viewTester usingLabel:@"Slider"] setSliderValue:0];
    [[[[viewTester usingLabel:@"Slider"] usingValue:@"0"] usingTraits:UIAccessibilityTraitNone] waitForView];
    [[viewTester usingLabel:@"Slider"] setSliderValue:5];
    [[[[viewTester usingLabel:@"Slider"] usingValue:@"5"] usingTraits:UIAccessibilityTraitNone] waitForView];
}

- (void)testPickingAPhoto
{
    [[viewTester usingLabel:@"Photos"] tap];
    [viewTester acknowledgeSystemAlert];
    [viewTester waitForTimeInterval:0.5f]; // Wait for view to stabilize

    NSOperatingSystemVersion iOS8 = {8, 0, 0};
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)] && [[NSProcessInfo new] isOperatingSystemAtLeastVersion:iOS8]) {
        [viewTester choosePhotoInAlbum:@"Camera Roll" atRow:1 column:2];
    } else {
        [viewTester choosePhotoInAlbum:@"Saved Photos" atRow:1 column:2];
    }
    [[viewTester usingLabel:@"{834, 1250}"] waitForView];
}

@end
