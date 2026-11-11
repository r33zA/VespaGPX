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

    private var dateText: String {
        rideDate?.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year()) ?? "Unknown date"
    }

    private var startTimeText: String {
        rideDate?.formatted(date: .omitted, time: .shortened) ?? "Unknown time"
    }

    private var durationText: String {
        guard item.duration.isFinite, item.duration >= 0 else { return "Unknown duration" }
        let totalMinutes = Int((item.duration / 60).rounded())
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        if hours == 0 { return "\(minutes)m" }
        return minutes == 0 ? "\(hours)h" : "\(hours)h \(minutes)m"
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "map.fill")
                .font(.title3)
                .foregroundStyle(Color.accentColor)
                .frame(width: 36, height: 36)
                .background(Color.accentColor.opacity(0.12),
                            in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(dateText)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                Text("\(startTimeText) · \(durationText)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(String(format: "%.1f km", item.distance))
                .font(.subheadline.weight(.semibold))
                .monospacedDigit()
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(.vertical, 5)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ActivityRowView(item: Activity.dummy)
}
