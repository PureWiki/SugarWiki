/*=============================================================================┐
|             _  _  _       _                                                  |  
|            (_)(_)(_)     | |                            _                    |██
|             _  _  _ _____| | ____ ___  ____  _____    _| |_ ___              |██
|            | || || | ___ | |/ ___) _ \|    \| ___ |  (_   _) _ \             |██
|            | || || | ____| ( (__| |_| | | | | ____|    | || |_| |            |██
|             \_____/|_____)\_)____)___/|_|_|_|_____)     \__)___/             |██
|                                                                              |██
|               ______                         _  _  _ _ _     _ _             |██
|              / _____)                       (_)(_)(_|_) |   (_) |            |██
|             ( (____  _   _  ____ _____  ____ _  _  _ _| |  _ _| |            |██
|              \____ \| | | |/ _  (____ |/ ___) || || | | |_/ ) |_|            |██
|              _____) ) |_| ( (_| / ___ | |   | || || | |  _ (| |_             |██
|             (______/|____/ \___ \_____|_|    \_____/|_|_| \_)_|_|            |██
|                           (_____|                                            |██
|                                                                              |██
|                         Copyright (c) 2015 Tong Kuo                          |██
|                                                                              |██
|                             ALL RIGHTS RESERVED.                             |██
|                                                                              |██
└==============================================================================┘██
  ████████████████████████████████████████████████████████████████████████████████
  ██████████████████████████████████████████████████████████████████████████████*/

#import "WikiJSONObject.h"
#import "SugarWikiDefines.h"

#import "__WikiJSONObject.h"

// WikiJSONObject class
@implementation WikiJSONObject

@dynamic json;

- ( void ) mergeFrom: ( WikiJSONObject* )_Another
    {
    NSMutableDictionary* mergedJSON = [ NSMutableDictionary dictionaryWithDictionary: self->_json ];

    for ( NSString* _JSONKey in _Another.json )
        {
        NSObject* myJSONElem = self->_json[ _JSONKey ];
        NSObject* anotherJSONElem = _Another.json[ _JSONKey ];

        if ( [ anotherJSONElem isKindOfClass: [ NSArray class ] ]
                && [ myJSONElem isKindOfClass: [ NSArray class ] ] )
            mergedJSON[ _JSONKey ] = [ ( NSArray* )myJSONElem arrayByAddingObjectsFromArray: ( NSArray* )anotherJSONElem ];
        else
            mergedJSON[ _JSONKey ] = anotherJSONElem;
        }

    self->_json = [ mergedJSON copy ];
    [ self __extractUseful: self->_json ];
    }

#pragma mark Dynamic Properties
- ( NSDictionary* ) json
    {
    return self->_json;
    }

@end // WikiJSONObject class

// WikiJSONObject + SugarWikiPrivate
@implementation WikiJSONObject ( SugarWikiPrivate )

#pragma mark Pure Virtual Initializations ( only used by friend classes )
+ ( instancetype ) __jsonObjectWithJSONDict: ( NSDictionary* )_JSONDict
    {
    return [ [ self alloc ] __initWithJSONDict: _JSONDict ];
    }

- ( instancetype ) __initWithJSONDict: ( NSDictionary* )_JSONDict
    {
    if ( !_JSONDict || ![ _JSONDict isKindOfClass: [ NSDictionary class ] ] )
        return nil;

    if ( self = [ super init ] )
        {
        self->_json = _JSONDict;
        [ self __extractUseful: self->_json ];
        }

    return self;
    }

#pragma mark Processing JSON
- ( void ) __extractUseful: ( NSDictionary* )_JSONDict
    {
    // TODO: Should be overrided by subclasses
    }

@end // WikiJSONObject + SugarWikiPrivate

/*================================================================================┐
|                              The MIT License (MIT)                              |
|                                                                                 |
|                           Copyright (c) 2015 Tong Kuo                           |
|                                                                                 |
|  Permission is hereby granted, free of charge, to any person obtaining a copy   |
|  of this software and associated documentation files (the "Software"), to deal  |
|  in the Software without restriction, including without limitation the rights   |
|    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell    |
|      copies of the Software, and to permit persons to whom the Software is      |
|            furnished to do so, subject to the following conditions:             |
|                                                                                 |
| The above copyright notice and this permission notice shall be included in all  |
|                 copies or substantial portions of the Software.                 |
|                                                                                 |
|   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    |
|    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,     |
|   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   |
|     AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      |
|  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  |
|  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  |
|                                    SOFTWARE.                                    |
└================================================================================*/