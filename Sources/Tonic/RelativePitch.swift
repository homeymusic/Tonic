//
//  RelativePitch.swift
//  HomeyPad
//
//  Created by landlessness on 7/8/23.
//

import Foundation

public typealias PitchSet = BitSetAdapter<RelativePitch, BitSet128>

public extension PitchSet {
    init(pitches: [RelativePitch]) {
        self.init()
        for pitch in pitches {
            add(pitch)
        }
    }

}

public struct RelativePitch: Equatable, Hashable {
    public var interval: Int8
    public var octave: Int8
    public var homePitchClass: Int8
    
    public init(interval: Int8, octave: Int8, homePitchClass: Int8) {
        self.interval = interval
        self.octave = octave
        self.homePitchClass = homePitchClass % 12
    }

    // built in % modulo needs help w neg numbers
    // see https://stackoverflow.com/questions/41180292/negative-number-modulo-in-swift
    public static func mod(_ a: Int8, _ n: Int8) -> Int8 {
        precondition(n > 0, "modulus must be positive")
        let r = a % n
        return r >= 0 ? r : r + n
    }

    /// Returns the distance between Pitches in semitones.
    /// - Parameter to: RelativePitch to which you want to know the distance
    public func semitones(to next: RelativePitch) -> Int8 {
        abs(midiNoteNumber - next.midiNoteNumber)
    }

    /// Equivalence classes of pitches modulo octave.
    public var pitchClass: Int8 {
        RelativePitch.mod(interval, 12)
    }

    /// Equivalence classes of pitches modulo octave.
    public var midiNoteNumber: Int8 {
        interval + 12 * octave + homePitchClass
    }
}

extension RelativePitch: IntRepresentable {
    public var intValue: Int {
        Int(midiNoteNumber)
    }

    public init(intValue: Int) {
        octave = Int8(floor(Float(intValue)/12))
        interval = RelativePitch.mod(Int8(intValue), 12)
        homePitchClass = 0
    }
}

extension RelativePitch: Comparable {
    public static func < (lhs: RelativePitch, rhs: RelativePitch) -> Bool {
        lhs.midiNoteNumber < rhs.midiNoteNumber
    }
}

extension RelativePitch: Strideable {
    public func distance(to other: RelativePitch) -> Int8 {
        semitones(to: other)
    }

    public func advanced(by n: Int8) -> RelativePitch {
        RelativePitch(intValue: Int((midiNoteNumber + n)))
    }
}
