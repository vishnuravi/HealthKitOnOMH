//
// This source file is part of the HealthKitOnOMH open source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit


extension HKQuantitySample {
    func buildOMH() throws -> HkQuantitySample<Double> {
        var unit = ""
        switch self.quantityType {
        case HKQuantityType(.heartRate):
            unit = "count/min"
        case HKQuantityType(.bloodGlucose):
            unit = "mg/dL"
        case HKQuantityType(.bodyMass):
            unit = "kg"
        case HKQuantityType(.bodyTemperature):
            unit = "degC"
        case HKQuantityType(.height):
            unit = "m"
        case HKQuantityType(.oxygenSaturation):
            unit = "%"
        case HKQuantityType(.respiratoryRate):
            unit = "count/min"
        case HKQuantityType(.stepCount):
            unit = "count"
        default:
            throw HealthKitOnOMHError.notSupported
        }

        return HkQuantitySample<Double>(
            quantityType: self.quantityType.identifier,
            unitValue: UnitValue<Double>(unit: unit,
                                         value: self.quantity.doubleValue(
                                            for: HKUnit(from: unit)
                                         )
                                        ),
            effectiveTimeFrame: TimeInterval(
                startDateTime: self.startDate,
                endDateTime: self.endDate
            )
        )
    }
}
