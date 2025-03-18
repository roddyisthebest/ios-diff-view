//
//  UIColor.swift
//  IosDiffView
//
//  Created by 배성연 on 3/18/25.
//

import UIKit

extension UIColor {
    /// Hex 코드로 UIColor 생성 (예: UIColor(hex: "#FF5733"))
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
    static let removedLineNumberBkg = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#3B0507") : UIColor(hex: "#FFD8E0")
    }

    static let removedLineNumber = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#FF808D") : UIColor(hex: "#F30016")
    }

    static let addedLineNumberBkg = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#08260F") : UIColor(hex: "#C7FFE0")
    }
    
    static let addedLineNumber = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#95F0AB") : UIColor(hex: "#008B1B")
    }
    
    static let lineBorder = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#9194A1") : UIColor(hex: "#686D7F")
    }
    
    static let addedLineBorder = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#253F2D") : UIColor(hex: "#A5D2BD")
    }
    
    static let removedLineBorder = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#502326") : UIColor(hex: "#DBB3BC")
    }
    
    static let lineNumberBkg = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#39393E") : UIColor(hex: "#C3C5CD")
    }
    
    static let lineNumber = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#9194A1") : UIColor(hex: "#686D7F")
    }
    
    static let removedLineContentBkg = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#300406") : UIColor(hex: "#FFECF0")
    }
    
    static let addedLineContentBkg = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#061C0B") : UIColor(hex: "#E7FFF2")
    }
    
    static let lineContentBkg = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#17181C") : UIColor(hex: "#FFFFFF")
    }
    
    static let lineContent = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#FBFBFC") : UIColor(hex: "#222930")
    }
    
}
