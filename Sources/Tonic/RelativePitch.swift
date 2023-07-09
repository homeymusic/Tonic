//
//  RelativePitch.swift
//  HomeyPad
//
//  Created by landlessness on 7/8/23.
//

import Foundation

public struct RelativePitch: Equatable, Hashable {
    /// MIDI Note Number 0-127
    public var octave: Int
    public var interval: Int

    public init(octave: Int, interval: Int) {
        self.octave = octave
        self.interval = interval
    }
}
