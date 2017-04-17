# PackUpTableView
cell的显示、隐藏

>项目中，总会遇到各种鬼需求，比如cell的显示隐藏就算吧，好好的数据直接展示就得了呗，非得隐藏起来，我就纳闷了，隐藏了，还显示嘎哈啊？毕竟就是个撸代码的，咋也得搞出来。

效果图就是这样：

![黑色的为每组头视图，点击展开隐藏的cell，再点击收缩隐藏。](http://upload-images.jianshu.io/upload_images/2381595-abe919078ac58921.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

黑色的为每组头视图，点击展开隐藏的cell，再点击收缩隐藏。
各种设置，已经封装起来了，使用的时候，直接遵守各个协议就可以了。

```

#pragma mark - YUFoldingTableViewDelegate / required
- (PackUpTableViewSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(PackUpTableView *)yuTableView {
    return self.arrowPosition ? :PackUpTableViewSectionHeaderArrowPositionRight;
}

- (NSInteger )numberOfSectionForPackUpTableView:(PackUpTableView *)tableView{
    return 4;
}

- (NSInteger )packUpTableView:(PackUpTableView *)tableView numberOfRowsInSection:(NSInteger )section {
    return 3;
}

- (CGFloat )packUpTableView:(PackUpTableView *)tableView heightForHeaderInSection:(NSInteger )section {
    return 50;
}

- (CGFloat )packUpTableView:(PackUpTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSString *)packUpTableView:(PackUpTableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titleArray[section];
}

- (UITableViewCell *)packUpTableView:(PackUpTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
        cell.textLabel.text = self.valueArray[indexPath.row];
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.text = self.valueDetailArray[indexPath.row];
        cell.detailTextLabel.textColor = [UIColor redColor];
        return cell;
}

- (void )packUpTableView:(PackUpTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - YUFoldingTableViewDelegate / optional
- (NSString *)packUpTableView:(PackUpTableView *)tableView descriptionForHeaderInSection:(NSInteger )section {
    return self.titleDetailArray[section];
}
```

以上就是主要的几个协议方式，基本也就这些，写上了，请求数据，再一赋值就OK了。
