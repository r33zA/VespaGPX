//
//  ActivityRowView.swift
//  VespaGPX
//
//  Created by David A. Shamma on 11/16/24.
//

import Foundation
import SwiftUI

struct ActivityRowView: View {
    let item: Activity

    private var rideDate: Date? {
        guard item.timestamp.isFinite, item.timestamp > 0 else { return nil }
        return Date(timeIntervalSince1970: item.timestamp / 1_000)
    }

    private var durationText: String {
        guard item.duration.isFinite else { return "Unknown duration" }
        let totalMinutes = max(0, Int((item.duration / 60).rounded()))
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return hours > 0 ? "\(hours) hr \(minutes) min" : "\(minutes) min"
    }

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "map.fill")
                .font(.title3)
                .foregroundStyle(.tint)
                .frame(width: 38, height: 38)
                .background(.tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 5) {
                Text(rideDate?.formatted(.dateTime.weekday(.wide).day().month(.abbreviated).year()) ?? "Unknown date")
                    .font(.headline)

                HStack(spacing: 5) {
                    Image(systemName: "clock")
                    Text(rideDate?.formatted(date: .omitted, time: .shortened) ?? "Unknown time")
                    Text("·")
                    Text(durationText)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            Text(String(format: "%.1f km", item.distance))
                .font(.headline)
                .monospacedDigit()
                .foregroundStyle(.primary)
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ActivityRowView(item: Activity.dummy)
}
