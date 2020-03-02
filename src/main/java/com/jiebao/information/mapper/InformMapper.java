package com.jiebao.information.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jiebao.information.model.Inform;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InformMapper  extends BaseMapper<Inform> {
    @Insert({"<script>",
           "INSERT INTO jiebao_collect_inform (url,title,author,read_num,recommen_num,author_url,comment_num,publish_time,content) VALUES\n" +
                   "    (?,?,?,?,?,?,?,?,?) ",
            "</script>",
    })
            boolean saveBlog(Inform inform);
}
