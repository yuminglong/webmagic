package com.jiebao.information.model;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@ToString
@Getter
@Setter

@TableName("jiebao_collect_inform")
public class Inform {
    @TableId
    private Integer informId;

    /**
     * 博文标题
     */
    private String title;

    /**
     * 博文url
     */
    private String url;

    /**
     * 作者
     */
    private String author;

    /**
     * 作者博客地址
     */
    private  String authorUrl;

    /**
     * 博文阅读量
     */
    private String readNum;

    /**
     * 推荐量
     */
    private  String recommenNum;

    /**
     * 评论量
     */
    private  String commentNum;

    /**
     * 内容
     */
    private  String content;

    /**
     * 发表的时间
     */
    private String publishTime;
}
