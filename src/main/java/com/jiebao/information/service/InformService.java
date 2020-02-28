package com.jiebao.information.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.jiebao.information.model.Inform;
import org.springframework.stereotype.Service;


public interface InformService extends IService<Inform> {


     boolean saveBlog(Inform inform);
}