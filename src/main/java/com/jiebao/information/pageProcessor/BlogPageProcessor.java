package com.jiebao.information.pageProcessor;

import com.jiebao.information.model.Inform;
import com.jiebao.information.service.InformService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Component
public class BlogPageProcessor implements PageProcessor {

    @Autowired
    private InformService informService;



    /**
     * 抓取网站的相关配置，包括：编码、抓取间隔、重试次数等
     */
    private Site site = Site.me().setRetryTimes(10).setRetrySleepTime(1000);
    private Pattern compile = Pattern.compile("");

    /**
     * 博文数量
     */
    private static int num = 0;

    @Override
    public void process(Page page) {
        //1. 如果是博文列表页面 【入口页面】，将所有博文的详细页面的url放入target集合中。
        // 并且添加下一页的url放入target集合中

        List<Inform> informs = new ArrayList<>();
        if (page.getUrl().regex("https://blog\\.hellobi\\.com/hot/weekly\\?page=\\d+").match()) {
            //目标链接
            page.addTargetRequests(page.getHtml().xpath("//h2[@class='title']/a").links().all());
            //下一页博文列表页链接
            page.addTargetRequests(page.getHtml().xpath("//a[@rel='next']").links().all());
        } else {

            Inform inform = new Inform();
            //博文标题
            String title = page.getHtml().xpath("//h1[@class='clearfix']/a/text()").get();
            //博文url
            String url = page.getHtml().xpath("//h1[@class='clearfix']/a/@href").get();
            //作者
            String author = page.getHtml().xpath("//section[@class='sidebar']/div/div/a[@class='aw-user-name']/text()").get();
            //作者博客地址
            String authorUrl = page.getHtml().xpath("//section[@class='sidebar']/div/div/a[@class='aw-user-name']/@href").get();
            //博文内容(这里只获取带html标签的内容，后续可再进一步处理)
            String content = page.getHtml().xpath("//div[@class='message-content editor-style']").get();
            //推荐数
            String recommenNum = page.getHtml().xpath("//a[@class='agree']/b/text()").get();
            //评论数
            String commentNum = page.getHtml().xpath("//div[@class='aw-mod']/div/h2/text()").get().split("个")[0].trim();
            //阅读量
            String readNum = page.getHtml().xpath("//div[@class='row']/div/div/div/div/span/text()").get().split(":")[1].trim();
            //发表时间,发布时间需要处理，这一步获取原始信息
            String time = page.getHtml().xpath("//time[@class='time']/text()").get().split(":")[1].trim();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            //获取当前日期
            Calendar instance = Calendar.getInstance();
            String publishTime = null;
            Matcher matcher = compile.matcher(time);
            if (matcher.matches()) {
                publishTime = time;
                //如果time包含“天”，如1天前，
            } else if (time.contains("天")) {
                //则获取对应的天数
                int days = Integer.parseInt(time.split("天")[0].trim());
                // 取当前日期的前days天.
                instance.add(Calendar.DAY_OF_MONTH, -days);
                //并将时间转换为“YYYY-mm-dd”这个格式
                publishTime = simpleDateFormat.format(instance.getTime());
            } else {//time是其他格式，如几分钟前，几小时前，都为当日日期
                publishTime = simpleDateFormat.format(instance.getTime());
            }

            //对象赋值
            inform.setUrl(url);
            inform.setTitle(title);
            inform.setAuthor(author);
            inform.setAuthorUrl(authorUrl);
            inform.setCommentNum(commentNum);
            inform.setRecommenNum(recommenNum);
            inform.setReadNum(readNum);
            inform.setContent(content);
            inform.setPublishTime(publishTime);
            num++;//博文数++

            //输出对象
             System.out.println("num:" + num + " =================" + inform.toString());


            //保存到数据库
            //informs.add(inform);



            informService.saveOrUpdate(inform);

        }

       /* for (Inform s : informs
        ) {
            System.out.println(s.toString() + "===================================================");
        }*/
       // informService.saveOrUpdateBatch(informs);
    }

    @Override
    public Site getSite() {
        return this.site;
    }



    public void start(BlogPageProcessor blogPageProcessor){

        long startTime, endTime;
        System.out.println("========爬虫【启动】！=========");
        startTime = System.currentTimeMillis();
        Spider.create(blogPageProcessor).addUrl("https://blog.hellobi.com/hot/weekly?page=1").thread(5).run();
        endTime = System.currentTimeMillis();
        System.out.println("========爬虫【结束】！=========");
        System.out.println("一共爬到" + num + "篇博客！用时为：" + (endTime - startTime) / 1000 + "s");
    }



}