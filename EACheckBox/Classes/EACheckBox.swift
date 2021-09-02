//  EACheckBox.swift
//  EACheckBox
//
//  Created by emirhan Acısu on 2.09.2021.

import UIKit

public enum CheckBoxStyle {
    case square
    case circle
}

public class EACheckBox: UIButton {
    
    var checkBoxStyle: CheckBoxStyle!
    var borderWidth: CGFloat?
    public var checkImage: UIImage?
    public var checkColor: UIColor?
    public var cornerRadius: CGFloat?
    public var borderColor: UIColor?
    public var checkedBorderColor: UIColor?
    
    var height: CGFloat = 10
    var width: CGFloat = 10 {
        didSet {
            radiusSetup()
        }
    }
    
    public var isOn: Bool = false {
        didSet {
            UIView.transition(with: self, duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.changeStatus()
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
    
    public init(style: CheckBoxStyle?,
         checkColor: UIColor? = nil,
         borderColor: UIColor? = nil,
         checkedBorderColor: UIColor? = nil,
         checkImage: UIImage? = nil,
         cornerRadius: CGFloat? = nil,
         borderWidth: CGFloat? = nil) {
        self.init()
        defer {
            self.checkBoxStyle = style
            self.checkColor = checkColor
            self.borderColor = borderColor ?? .red
            self.checkedBorderColor = checkedBorderColor ?? .red
            self.cornerRadius = cornerRadius
            self.checkImage = checkImage
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
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        selectedView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        selectedView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        selectedView.isHidden = true
    
        self.layer.borderWidth = borderWidth ?? 1
        self.layer.borderColor = borderColor?.cgColor
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    func radiusSetup() {
        switch checkBoxStyle {
        case .circle:
            self.layer.cornerRadius = width / 2
            selectedView.widthAnchor.constraint(equalToConstant: width * 0.5).isActive = true
            selectedView.heightAnchor.constraint(equalToConstant: height * 0.5).isActive = true
            selectedView.layer.cornerRadius = (width * 0.5) / 2
            selectedView.backgroundColor = checkColor == nil ? .red : checkColor
            
            if checkImage != nil {
                selectedView.image = checkImage
            }
        case .square:
            self.layer.cornerRadius = cornerRadius ?? 4
            selectedView.heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
            selectedView.widthAnchor.constraint(lessThanOrEqualToConstant: width).isActive = true
            selectedView.image = checkImage == nil ? UIImage(named: "ic_flag_checked") : checkImage
            
            if checkColor != nil {
                selectedView.tintColor = checkColor
            }
            
        default:
            break
        }
    }
    
    func changeStatus() {
        if self.isOn {
            self.selectedView.isHidden = false
            self.layer.borderColor = checkedBorderColor?.cgColor
        } else {
            self.selectedView.isHidden = true
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @objc
    private func onPress() {
        self.isOn.toggle()
    }
    
}
