//
//  TableViewController.swift
//  LLCycleScrollView
//
//  Created by LvJianfeng on 2018/2/25.
//  Copyright © 2018年 LvJianfeng. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let titles = ["感谢您的支持",
                  "如果代码在使用过程中出现问题",
                  "您可以发邮件到coderjianfeng@foxmail.com您可以发邮件到coderjianfeng@foxmail.com您可以发邮件到coderjianfeng@foxmail.com"
    ];

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
        
        // header
        // 纯文本demo
        let titleHeaderDemo = LLCycleScrollView.llCycleScrollViewWithTitles(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:20)) { (index) in
            print("当前点击文本的位置为:\(index)")
        }
        
        titleHeaderDemo.customPageControlStyle = .none
        titleHeaderDemo.scrollDirection = .vertical
        titleHeaderDemo.font = UIFont.systemFont(ofSize: 13)
        titleHeaderDemo.textColor = UIColor.white
        titleHeaderDemo.titleBackgroundColor = UIColor.red
        titleHeaderDemo.numberOfLines = 2
        // 文本　Leading约束
        titleHeaderDemo.titleLeading = 30
        tableView.tableHeaderView = titleHeaderDemo
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            titleHeaderDemo.titles = self.titles
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)

        cell.textLabel?.text = "当前属于第(\(indexPath.row)行"

        return cell
    }

}
