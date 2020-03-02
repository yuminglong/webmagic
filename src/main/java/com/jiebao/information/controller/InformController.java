package com.jiebao.information.controller;


import com.jiebao.information.model.Inform;
import com.jiebao.information.pageProcessor.BlogPageProcessor;
import com.jiebao.information.service.InformService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@Slf4j
@RestController
public class InformController  {

    @Autowired
    InformService informService;

    @Autowired
    BlogPageProcessor blogPageProcessor;



    @ResponseBody
    @GetMapping("/selectAll")
    public List<Inform> selectAll() {

        return informService.list();
    }

    @GetMapping("/")
    public String index() {
        new Thread(() -> blogPageProcessor.start(blogPageProcessor)).start();
blogPageProcessor.toString();
        return "爬虫开启";
    }



}