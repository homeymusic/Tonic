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

    public init(interval: Int8, octave: Int8) {
        self.interval = interval
        self.octave = octave
    }

    /// Returns the distance between Pitches in semitones.
    /// - Parameter to: RelativePitch to which you want to know the distance
    public func semitones(to next: RelativePitch) -> Int8 {
        abs(interval - next.interval)
    }

    /// Equivalence classes of pitches modulo octave.
    public var pitchClass: Int8 {
        interval % 12
    }

}

extension RelativePitch: IntRepresentable {
    public var intValue: Int {
        Int(interval) + 2
    }

    public init(intValue: Int) {
        interval = Int8(intValue)
        octave = Int8(4)
    }
}

extension RelativePitch: Comparable {
    public static func < (lhs: RelativePitch, rhs: RelativePitch) -> Bool {
        lhs.interval < rhs.interval
    }
}

extension RelativePitch: Strideable {
    public func distance(to other: RelativePitch) -> Int8 {
        semitones(to: other)
    }

    public func advanced(by n: Int8) -> RelativePitch {
        RelativePitch(intValue: Int((interval + n)))
    }
}
