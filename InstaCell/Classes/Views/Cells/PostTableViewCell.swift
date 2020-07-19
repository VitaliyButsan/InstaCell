//
//  PostTableViewCell.swift
//  InstaCell
//
//  Created by Vitaliy on 18.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import UIKit
import SnapKit
import ImageSlideshow
import SDWebImage

class PostTableViewCell: UITableViewCell {

    static let cellID = "postTableViewCell"
    
    // Header
    // -------------------------------------------------------------------------------------------
    private var headerView: UIView = {
        let headerView = UIView()
        return headerView
    }()
    
    private var profileIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var userNameHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "header_label"
        return label
    }()
    
    lazy private var whereFromUserHeaderButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return button
    }()
    
    lazy private var moreHeaderButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more")!, for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    @objc func tap(_ sender: UIButton!) {
        print(sender.titleLabel?.text ?? "...")
    }
    
    // Image Slider
    // ---------------------------------------------------------------------------------
    private var imageSlider: ImageSlideshow = {
        let imageSlider = ImageSlideshow()
        imageSlider.circular = false
        return imageSlider
    }()
    
    lazy private var pageIndicator: UIPageControl = {
        let indicator = UIPageControl()
        indicator.currentPageIndicatorTintColor = .link
        indicator.pageIndicatorTintColor = .lightGray
        return indicator
    }()
    
    private var sliderLeftActionsImagesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy private var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    lazy private var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "chat"), for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    lazy private var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plane"), for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    lazy private var sliderBookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    // Footer
    // ----------------------------------------------------------------------------------
    var postLinkersTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .justified
        return textView
    }()
    
    var postFollowersTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .justified
        return textView
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    // -----------------------------------------------------------------------------------
    
    // init cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHeaderViewConstraints()
        setupImgSliderConstraints()
        setupFooterViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(withPost post: Post) {
        setupUserProfileInfo(withPost: post)
        setupPostLinkersTextView(withPost: post)
        setupPostFollowersTextView(withPost: post)
        setupDateLabel(withPost: post)
        setupImageSladerSource(withPost: post)
    }
    
    private func setupUserProfileInfo(withPost post: Post) {
        profileIconImageView.sd_setImage(with: URL(string: post.postOwnerIconURL))
        userNameHeaderLabel.text = post.postOwnerName
        whereFromUserHeaderButton.setTitle(post.whereFromUser, for: .normal)
    }
    
    private func setupImageSladerSource(withPost post: Post) {
        var sources: [SDWebImageSource] = []
        post.postImages.forEach { postImageURL in
            if let imageSource = SDWebImageSource(urlString: postImageURL) {
                sources.append(imageSource)
            }
        }
        imageSlider.setImageInputs(sources)
    }
    
    private func setupPostLinkersTextView(withPost post: Post) {
        let linkersUsers = post.postLinkers.joined(separator: ", ")
        postLinkersTextView.attributedText = NSMutableAttributedString()
                                                .normal("Linked by ")
                                                .bold(linkersUsers)
                                                .normal(" and ")
                                                .bold("94 others")
    }
    
    private func setupPostFollowersTextView(withPost post: Post) {
        let followers = post.postFollowers.map { $0 + " " }
        postFollowersTextView.attributedText = NSMutableAttributedString()
                                                .bold(post.postOwnerName)
                                                .normal(" Beauty ")
                                                .setAsLinks(followers, post.followersLinks)
    }
    
    private func setupDateLabel(withPost post: Post) {
        dateLabel.text = post.postDate.uppercased()
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .lightGray
    }
    
    // Setup header
    // -----------------------------------------------------------------------
    private func setupHeaderViewConstraints() {
        self.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(60)
        }
        
        headerView.addSubview(profileIconImageView)
        let iconWidth: CGFloat = 40
        profileIconImageView.layer.cornerRadius = iconWidth / 2
        profileIconImageView.layer.masksToBounds = true
        profileIconImageView.snp.makeConstraints { make in
            make.width.equalTo(iconWidth)
            make.height.equalTo(iconWidth)
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        headerView.addSubview(moreHeaderButton)
        moreHeaderButton.snp.makeConstraints { make in
            make.width.equalTo(profileIconImageView.snp.width)
            make.height.equalTo(profileIconImageView.snp.height)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-16)
        }
        
        headerView.addSubview(userNameHeaderLabel)
        userNameHeaderLabel.snp.makeConstraints { make in
            make.height.equalTo(profileIconImageView.snp.height).multipliedBy(0.4)
            make.leading.equalTo(profileIconImageView.snp.trailing).offset(10)
            make.bottom.equalTo(profileIconImageView.snp.centerY)
        }
        
        headerView.addSubview(whereFromUserHeaderButton)
        whereFromUserHeaderButton.snp.makeConstraints { make in
            make.height.equalTo(profileIconImageView.snp.height).multipliedBy(0.4)
            make.leading.equalTo(profileIconImageView.snp.trailing).offset(10)
            make.top.equalTo(profileIconImageView.snp.centerY)
        }
    }
    
    // Setup image slider
    // ----------------------------------------------------------------------
    private func setupImgSliderConstraints() {
        self.addSubview(imageSlider)
        imageSlider.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(bounds.width * 1.2)
        }
        
        imageSlider.contentScaleMode = .scaleAspectFill
        imageSlider.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customUnder(padding: 10))
        imageSlider.pageIndicator = pageIndicator
        
        imageSlider.addSubview(sliderLeftActionsImagesStack)
        sliderLeftActionsImagesStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(30)
        }
        sliderLeftActionsImagesStack.addArrangedSubview(heartButton)
        sliderLeftActionsImagesStack.addArrangedSubview(commentButton)
        sliderLeftActionsImagesStack.addArrangedSubview(sendButton)
        
        imageSlider.addSubview(sliderBookmarkButton)
        sliderBookmarkButton.snp.makeConstraints { make in
            make.height.equalTo(sliderLeftActionsImagesStack.snp.height)
            make.width.equalTo(sliderLeftActionsImagesStack.snp.height)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    // Setup footer
    // ----------------------------------------------------------------------
    private func setupFooterViewConstraints() {
        self.addSubview(postLinkersTextView)
        postLinkersTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(imageSlider.snp.bottom)
        }
        
        self.addSubview(postFollowersTextView)
        postFollowersTextView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(postLinkersTextView)
            make.top.equalTo(postLinkersTextView.snp.bottom)
        }
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.trailing.equalTo(postFollowersTextView).offset(5)
            make.top.equalTo(postFollowersTextView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
