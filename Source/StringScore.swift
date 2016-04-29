/*

Based on string_score 0.1.21 by Joshaven Potter.
https://github.com/joshaven/string_score/

Copyright (c) 2015 Yichi Zhang
https://github.com/yichizhang
zhang-yi-chi@hotmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

import Foundation

public extension String
{
    func score(word: String, fuzziness: Double? = nil) -> Double
    {
        // If the string is equal to the word, perfect match.
        if self == word {
            return 1
        }

        //if it's not a perfect match and is empty return 0
        if word.isEmpty || self.isEmpty {
            return 0
        }

        var
        runningScore = 0.0,
        charScore = 0.0,
        finalScore = 0.0,
        string = self,
        lString = string.lowercaseString,
        strLength = string.characters.count,
        lWord = word.lowercaseString,
        wordLength = word.characters.count,
        idxOf: String.Index!,
        startAt = lString.startIndex,
        fuzzies = 1.0,
        fuzzyFactor = 0.0,
        fuzzinessIsNil = true

        // Cache fuzzyFactor for speed increase
        if let fuzziness = fuzziness {
            fuzzyFactor = 1 - fuzziness
            fuzzinessIsNil = false
        }

        for i in 0 ..< wordLength {
            // Find next first case-insensitive match of word's i-th character.
            // The search in "string" begins at "startAt".
            if let range = lString.rangeOfString(
            String(lWord[lWord.startIndex.advancedBy(i)] as Character),
            options: NSStringCompareOptions.CaseInsensitiveSearch,
            range: Range<String.Index>(start: startAt, end: lString.endIndex),
            locale: nil
            ) {
                // start index of word's i-th character in string.
                idxOf = range.startIndex
                if startAt == idxOf {
                    // Consecutive letter & start-of-string Bonus
                    charScore = 0.7
                }
                else {
                    charScore = 0.1

                    // Acronym Bonus
                    // Weighing Logic: Typing the first character of an acronym is as if you
                    // preceded it with two perfect character matches.
                    if string[idxOf.advancedBy(-1)] == " " {
                        charScore += 0.8
                    }
                }
            }
            else {
                // Character not found.
                if fuzzinessIsNil {
                    // Fuzziness is nil. Return 0.
                    return 0
                }
                else {
                    fuzzies += fuzzyFactor
                    continue
                }
            }

            // Same case bonus.
            if (string[idxOf] == word[word.startIndex.advancedBy(i)]) {
                charScore += 0.1
            }

            // Update scores and startAt position for next round of indexOf
            runningScore += charScore
            startAt = idxOf.advancedBy(1)
        }

        // Reduce penalty for longer strings.
        finalScore = 0.5 * (runningScore / Double(strLength) + runningScore / Double(wordLength)) / fuzzies

        if (lWord[lWord.startIndex] == lString[lString.startIndex]) && (finalScore < 0.85) {
            finalScore += 0.15
        }

        return finalScore
    }
}
