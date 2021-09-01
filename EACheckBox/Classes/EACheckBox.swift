//
//  EACheckBox.swift
//  TestCrashlyticsApp
//
//  Created by emirhan Acısu on 31.08.2021.
//

import UIKit

enum CheckBoxStyle {
    case square
    case circle
}

public class EACheckBox: UIButton {
    
    var checkBoxStyle: CheckBoxStyle!
    var checkImage: UIImage?
    var checkColor: UIColor?
    var cornerRadius: CGFloat?
    var borderWidth: CGFloat?
    var borderColor: UIColor?
    
    var height: CGFloat = 10
    var width: CGFloat = 10 {
        didSet {
            radiusSetup()
        }
    }
    
    var isOn: Bool = false {
        didSet {
            UIView.transition(with: self, duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.selectedView.isHidden = !self.isOn ? true : false
                              })
        }
    }
    
    private let selectedView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    init(style: CheckBoxStyle?,
         checkColor: UIColor?,
         borderColor: UIColor? = nil,
         checkImage: UIImage? = nil,
         cornerRadius: CGFloat? = nil,
         borderWidth: CGFloat? = nil) {
        self.init()
        defer {
            self.checkBoxStyle = style
            self.checkColor = checkColor
            self.borderColor = borderColor
            self.cornerRadius = cornerRadius ?? 4
            self.checkImage = checkImage ?? UIImage(named: "ic_flag_checked")
            self.borderWidth = borderWidth
            self.commonInit()
        }
        
    }
    public override func layoutSubviews() {
        self.height = self.bounds.size.height
        self.width = self.bounds.size.width
    }
    
    private func commonInit() {
        addSubview(selectedView)
        selectedView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectedView.isHidden = true
    
        self.layer.borderWidth = borderWidth ?? 1
        self.layer.borderColor = borderColor?.cgColor ?? UIColor.blue.cgColor
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    func radiusSetup() {
        switch checkBoxStyle {
        case .circle:
            selectedView.widthAnchor.constraint(equalToConstant: width * 0.5).isActive = true
            selectedView.heightAnchor.constraint(equalToConstant: height * 0.5).isActive = true
            self.layer.cornerRadius = width / 2
            selectedView.layer.cornerRadius = (width * 0.5) / 2
            selectedView.backgroundColor = checkColor
            if checkImage != nil {
                selectedView.image = checkImage
            }
        case .square:
            self.layer.cornerRadius = cornerRadius!
            selectedView.image = checkImage
            selectedView.heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
            selectedView.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
            if checkColor != nil {
                selectedView.tintColor = checkColor
            }
            
        default:
            break
        }
    }
    
    @objc
    private func onPress() {
        self.isOn.toggle()
    }
    
}
