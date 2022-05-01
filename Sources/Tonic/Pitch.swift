
import Foundation

/// Essentially a midi note number.
///
/// We want to use a notion of pitch that lends itself to combinatorical algorithms,
/// as opposed to useing e.g. a fundamental frequency.
public struct Pitch: Equatable, Hashable {

    var midiNoteNumber: Int8

    public init(_ midiNoteNumber: Int8) {
        self.midiNoteNumber = midiNoteNumber
    }

    func note(in key: Key) -> Note {
        Note(pitch: self, key: key)
    }

    func semitones(to: Pitch) -> Int8 {
        abs(midiNoteNumber - to.midiNoteNumber)
    }
}
