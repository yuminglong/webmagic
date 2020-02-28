package com.jiebao.information.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jiebao.information.mapper.InformMapper;
import com.jiebao.information.model.Inform;
import com.jiebao.information.service.InformService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;


@Slf4j
@Service
public class InformServiceImpl extends ServiceImpl<InformMapper,Inform> implements InformService {

    @Override
    public boolean saveBlog(Inform inform) {
        return baseMapper.saveBlog(inform);
    }
}