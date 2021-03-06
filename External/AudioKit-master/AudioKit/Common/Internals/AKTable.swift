//
//  AKTable.swift
//  AudioKit
//
//  Created by Aurelius Prochazka, revision history on Github.
//  Copyright © 2016 Aurelius Prochazka. All rights reserved.
//

import Foundation

/// Supported default table types
public enum AKTableType: String {
    /// Standard sine waveform
    case Sine
    
    /// Standard triangle waveform
    case Triangle
    
    /// Standard square waveform
    case Square
    
    /// Standard sawtooth waveform
    case Sawtooth
    
    /// Reversed sawtooth waveform
    case ReverseSawtooth
}

/// A table of values accessible as a waveform or lookup mechanism
public struct AKTable {
    
    // MARK: - Properties
    
    /// Values stored in the table
    public var values = [Float]()
    
    /// Number of values stored in the table
    var size = 4096
    
    /// Type of table
    var type: AKTableType
    
    // MARK: - Initialization
    
    /// Initialize and set up the default table 
    ///
    /// - parameter tableType: AKTableType of teh new table
    /// - parameter size: Size of the table (multiple of 2)
    ///
    public init(_ tableType: AKTableType = .Sine, size tableSize: Int = 4096) {
        type = tableType
        size = tableSize
        switch type {
        case .Sine:
            self.standardSineWave()
        case .Sawtooth:
            self.standardSawtoothWave()
        case .Triangle:
            self.standardTriangleWave()
        case .ReverseSawtooth:
            self.standardReverseSawtoothWave()
        case .Square:
            self.standardSquareWave()
        }
    }
    
    /// Instantiate the table as a triangle wave
    mutating func standardTriangleWave() {
        values = [Float]()
        let slope = Float(4.0) / Float(size)
        for i in 0..<size {
            if i < size / 2 {
                values.append(slope * Float(i) - 1.0)
            } else {
                values.append(slope * Float(-i) + 3.0)
            }
        }
    }

    /// Instantiate the table as a square wave
    mutating func standardSquareWave() {
        values = [Float]()
        for i in 0..<size {
            if i < size / 2 {
                values.append(-1.0)
            } else {
                values.append(1.0)
            }
        }
    }
    
    /// Instantiate the table as a sawtooth wave
    mutating func standardSawtoothWave() {
        values = [Float]()
        for i in 0..<size {
            values.append(-1.0 + 2.0*Float(i)/Float(size))
        }
    }

    /// Instantiate the table as a reverse sawtooth wave
    mutating func standardReverseSawtoothWave() {
        values = [Float]()
        for i in 0..<size {
            values.append(1.0 - 2.0*Float(i)/Float(size))
        }
    }

    /// Instantiate the table as a sine wave 
    mutating func standardSineWave() {
        values = [Float]()
        for i in 0..<size {
            values.append(sin(2 * 3.14159265 * Float(i)/Float(size)))
        }
    }
}
