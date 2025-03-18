//
//  DiffUsecase.swift
//  IosDiffView
//
//  Created by 배성연 on 3/18/25.
//

import Foundation

protocol DiffUsecaseProtocol {
    func computeDiff(oldLines: [String], newLines: [String]) -> [DiffCode]
}

struct DiffUsecase: DiffUsecaseProtocol {

    func computeDiff(oldLines: [String], newLines: [String]) -> [DiffCode] {
        let lcsMatrix = computeLCSMatrix(oldLines, newLines) // ✅ LCS 테이블 생성
        var result: [DiffCode] = []

        var i = oldLines.count
        var j = newLines.count

        while i > 0 || j > 0 {
            if i > 0, j > 0, oldLines[i - 1] == newLines[j - 1] {
                // ✅ 변경 없음
                result.append(DiffCode(status: .notChange, oldLine: i - 1, newLine: j - 1, content: oldLines[i - 1], hilightedContent: nil))
                i -= 1
                j -= 1
            } else if j > 0, (i == 0 || lcsMatrix[i][j - 1] >= lcsMatrix[i - 1][j]) {
                // ✅ 새로 추가된 줄
                result.append(DiffCode(status: .add, oldLine: i-1, newLine: j - 1, content: newLines[j - 1], hilightedContent: nil))
                j -= 1
            } else if i > 0, (j == 0 || lcsMatrix[i][j - 1] < lcsMatrix[i - 1][j]) {
                // ✅ 삭제된 줄
                result.append(DiffCode(status: .delete, oldLine: i - 1, newLine: j-1, content: oldLines[i - 1], hilightedContent: nil))
                i -= 1
            }
        }

        return result.reversed() // ✅ 원래 순서대로 반환
    }

    // ✅ LCS 테이블 계산 (GitHub과 같은 Diff 비교를 위해 사용)
    private func computeLCSMatrix(_ oldLines: [String], _ newLines: [String]) -> [[Int]] {
        let m = oldLines.count
        let n = newLines.count
        var lcsMatrix = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

        for i in 1...m {
            for j in 1...n {
                if oldLines[i - 1] == newLines[j - 1] {
                    lcsMatrix[i][j] = lcsMatrix[i - 1][j - 1] + 1
                } else {
                    lcsMatrix[i][j] = max(lcsMatrix[i - 1][j], lcsMatrix[i][j - 1])
                }
            }
        }

        return lcsMatrix
    }
}
