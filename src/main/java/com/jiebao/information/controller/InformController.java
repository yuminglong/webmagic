package com.jiebao.information.controller;


import com.central.common.model.Result;
import com.jiebao.information.model.Inform;
import com.jiebao.information.pageProcessor.BlogPageProcessor;
import com.jiebao.information.service.InformService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Spider;

import java.util.Date;
import java.util.List;


@Slf4j
@Controller
public class InformController {

    @Autowired
    InformService informService;

    @ResponseBody
    @GetMapping("/selectAll")
    public List<Inform> selectAll() {

        return informService.list();
    }

    @GetMapping("/conInform")
    public Result conInform(){


        return Result.succeed("dd");
    }


}