/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50624
 Source Host           : localhost:3306
 Source Schema         : inform

 Target Server Type    : MySQL
 Target Server Version : 50624
 File Encoding         : 65001

 Date: 02/03/2020 17:05:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for jiebao_collect_inform
-- ----------------------------
DROP TABLE IF EXISTS `jiebao_collect_inform`;
CREATE TABLE `jiebao_collect_inform`  (
  `inform_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博文url',
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `author_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者博客地址',
  `read_num` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博文阅读量',
  `recommen_num` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推荐量',
  `comment_num` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论量',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `publish_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发表的时间',
  PRIMARY KEY (`inform_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of jiebao_collect_inform
-- ----------------------------
INSERT INTO `jiebao_collect_inform` VALUES (13, '手把手用Python网络爬虫带你爬取全国著名高校附近酒店评论', '/blog/dcpeng/36506', 'dcpeng', 'https://ask.hellobi.com/people/python_crawler', '51', '0', '0', '<div class=\"message-content editor-style\"> \n <p style=\"text-align: center;\"><span style=\"color: rgb(255, 169, 0);\"><strong>/1 前言/</strong></span></p>\n <p style=\"margin-left: auto;\">&nbsp;&nbsp;简介：本文介绍如何用python爬取全国著名高校附近的酒店点评，并进行分析，带大家看看著名高校附近的酒店怎么样。</p>\n <p style=\"text-align: center;\"><span style=\"color: rgb(255, 169, 0);\"><strong>/2 具体实现/</strong></span></p>\n <p style=\"margin-left: auto;\">&nbsp;&nbsp;具体的实现主要是分为三步，具体的操作过程如下。</p>\n <p style=\"text-align: center;\"><span style=\"color: rgb(255, 169, 0);\">一、抓取高校附近的酒店信息</span></p>\n <p>&nbsp;&nbsp;由于电脑客户端的美团酒店没有评论信息，于是我从手机端的网页入手，网页地址为：<a href=\"https://i.meituan.com/awp/h5/hotel/search/search.html\" rel=\"nofollow\">https://i.meituan.com/awp/h5/hotel/search/search.html</a></p>\n <p>&nbsp;&nbsp;通过搜索北京大学附近的酒店，抓包找到了返回酒店json信息的url。</p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/zzrzotdnsd.webp\"></p>\n <p>&nbsp;&nbsp;其中，limit代表返回酒店的最大数量（经测试，limit最大为50），offset为每次返回酒店数量的起点，cityId为城市的标志，在网页信息中可以找到，时间参数可以修改，sort为返回酒店信息的排序，sort=distance代表按距离搜索，q和keyword都是大学名称。</p>\n <p>&nbsp;&nbsp;返回的数据如下图所示：</p>\n <p style=\"text-align: center;\"><img src=\"upload_not_writable\"></p>\n <p></p>\n <p>&nbsp;&nbsp;&nbsp;&nbsp;包含酒店的名字、地理位置、评分、realPoiId（相当于酒店的身份证号，后面爬评论用的到）、酒店和大学的距离等信息。</p>\n <p>&nbsp;&nbsp;&nbsp;&nbsp;下面我们开始爬排名前10高校附近的酒店信息（不要在乎大学排名，我乱找的，以学习为主）：</p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/jtxjevrous.webp\"></p>\n <p style=\"text-align: center;\">（图片来源于网络）<br></p>\n <p>&nbsp;&nbsp;部分代码如下图所示：</p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/fomzjznbaj.webp\"></p>\n <p>&nbsp;&nbsp;其中cityId和大学名字为控制变量，通过返回的距离信息将酒店位置控制在2000米以内，输出结果为：</p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/wcfidatbip.webp\"></p>\n <p>&nbsp;&nbsp;看看这10所大学2000米附近附近有多少家酒店：</p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/suasxytgmf.webp\"></p>\n <p>&nbsp;&nbsp;我们可以发现，南京大学附近酒店最多，有453家；上海交通大学闵行校区附近酒店最少，有75家。</p>\n <p style=\"text-align: center;\"><span style=\"color: rgb(255, 169, 0);\"><strong>二、抓取每家酒店的点评信息</strong></span></p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/onltolvvkt.webp\"></p>\n <p>&nbsp;&nbsp;这个从这个url可以返回每家酒店的评论数量，poiId是酒店的“身份证号”。</p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/rqnspvddoc.webp\"></p>\n <p>&nbsp;&nbsp;这个url可以返回酒店的所有评论信息，其中limit为返回的评论数量，可以直接用上个url返回的评论数量，一次全部以json格式返回，非常方便，返回结果如下：</p>\n <p style=\"text-align: center;\"><img src=\"https://ask.hellobi.com/uploads/article/20200301/vkzthagfze.webp\"></p>\n <p style=\"text-align: center;\"><span style=\"color: rgb(255, 169, 0);\">三、遇到的坑</span></p>\n <p>&nbsp; 1.刚开始爬评论是1次返回15个，后来发现可以Limit可以为评论的最大值，但是第一步返回的酒店信息中包含酒店评论数量是不准确的，要用第二步的方法；</p>\n <p>&nbsp; 2.评论中乱七八糟的表情、符号也是大坑，去了好久也去不干净；</p>\n <p>&nbsp; 3.最好用代理IP地址爬，否则评论太多，会被封。</p>\n <p style=\"text-align: center;\"><strong>/3&nbsp;结语/</strong><br></p>\n <p>&nbsp; 本文基于Python网络爬虫，抓取了高校旁边的酒店数量及其评论数量，如果你想抓取其他地方的其他信息，也是可行的，可以纵向拓展。</p>\n <p>&nbsp;&nbsp;欢迎大家尝试，消耗在家的无聊时间。本文涉及的代码都上传到了github地址上，后台回复“<strong>高校酒店</strong>”四个字即可获取代码。</p> \n</div>', '2020-03-02');
INSERT INTO `jiebao_collect_inform` VALUES (14, '战“疫”下的零售企业，如何用数据智能转危为机', '/blog/guandata/36505', '观远数据', 'https://ask.hellobi.com/people/guanyuan', '133', '0', '0', '<div class=\"message-content editor-style\"> \n <p style=\"text-align: center;\"><span style=\"color: rgb(51, 51, 51);\"><img alt=\"1.jpg\" src=\"https://ask.hellobi.com/uploads/article/20200227/f8b642457cabc0c82375541d2dd966c0.jpg\" width=\"600\" height=\"255.33333333333334\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\"><br></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span><span style=\"color: rgb(51, 51, 51);\">“黑天鹅、灰犀牛现象频繁出现，这个VUCA的时代是无比的真实，与我们每一位息息相关。面对不确定性将成为常态的未来，我们需要抓住其中的确定性。用数据驱动经营，让决策更加智能。”</span></p>\n <p style=\"text-align: right;\"><span style=\"color: rgb(51, 51, 51);\">——观远数据&nbsp;苏春园</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">2020</span><span style=\"color: rgb(51, 51, 51);\">年春节期间，疫情黑天鹅突然来袭，给本该更热闹的零售实体行业按下了暂停键。消费者被限制出门，员工无法按时到岗，物流仓储跨城配送运输困难……这个春节只有零售企业家们自己知道到底在面临和经历什么。</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">但从过往经验来看，危机往往也是促进行业加速升级发展的契机。2003年SARS催生了电商的发展，京东、阿里巴巴迅速崛起，今年的疫情也助推了社区商业、O2O平台、线上微商与全渠道的发展。</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><b><span style=\"color: rgb(51, 51, 51);\">那么，疫情之下，企业该如何通过数字化措施来及时止损，甚至转危为机呢？</span></b></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <h2 id=\"articleHeader1\"><span style=\"color: rgb(51, 51, 51);\">疫情之下，快反制胜</span></h2>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">观远数据创始人兼CEO苏春园表示，疫情之下，很多零售企业都表现出了惊人的行动力和快速反应能力。</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><b><span style=\"color: rgb(51, 51, 51);\">「生鲜传奇」</span></b><span style=\"color: rgb(51, 51, 51);\">在节后第一个工作日就启动了门店线上预订小程序，让社区消费者足不出户也能选购生鲜产品；在武汉的<b>「Today便利店」</b>、在厦门的<b>「见福便利店」</b>一天24小时向社区和医务工作者提供口罩、便当、矿泉水、方便面等生活必需品；<b>「奈雪的茶」</b>在疫情期间推出小程序下单，实现从门店包装开始的无接触式配送；餐饮连锁品牌<b>「咬不得」</b>也在疫情期间快速推出在线无接触配送。</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p style=\"text-align: center;\"><img alt=\"2.jpg\" src=\"https://ask.hellobi.com/uploads/article/20200227/094d139e7f6077aee9b607206c8212c0.jpg\" width=\"600\" height=\"231.25\"><br></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">面对疫情，零售企业比谁都清楚该疫情对企业的影响，但是并不是每一家企业都有能力支撑自己的想法。我们看得见的是企业承诺“今日订次日提”、“24小时营业”、“配送到家”“不涨价不停业不缺货”等一系列战略调整和优化，<b>而看不见的是他们要顶住疫情压力，解决人员调配、供应链补给、门店仓储协同等各种难题。</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <h2 id=\"articleHeader2\"><span style=\"color: rgb(51, 51, 51);\">数据洞察，寻找先机</span></h2>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">苏春园认为，疫情是挑战，但同样也是对整个零售行业的一次大考验，<b>谁的精细化运营程度高，快速反应能力强，谁就可以在这场战疫中突破重围化危为机。</b>而具体怎么做，我们可以从一些优秀案例中寻找启发。</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p style=\"text-align: center;\"><img alt=\"2.jpg\" src=\"https://ask.hellobi.com/uploads/article/20200227/c724321f783a633f7795246919766879.jpg\" width=\"600\" height=\"231.25\"><br></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\"><b>以人为本的健康度数据监控</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">疫情对所有企业影响的一个共性就是限制员工上班，对零售企业来说尤为严重。一是要响应国家政策延迟复工加强隔离，另一个还是响应国家政策，保障居民的基本生活需求不受影响，这就需要企业有足够的零售人坚守前线售卖、配送。满足这一点，零售企业除了要加强员工关怀和防护措施，更需要科学合理地安排员工有序复工。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">员工健康度监测，是很多企业目前正在做的，可以在疫情期间时刻关注不同区域、不同部门员工的健康状况和返工状况。<b>对重点高危人员进行针对性部署，判断有没有条件提高门店的开业率，支撑各个办公地点的工作恢复安排，保证企业正常经营。</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\"><b>疫情创造商机，数据赋能决策</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">疫情之下，门店停业、线下渠道遭受重创、常规商品销售受阻、跨城配送障碍重重……这不是一家企业遇到的问题，也是整个行业的现状。<b>而集中出的暴露问题除了带来短期的重创，反过来也会推动整个行业进行反思。&nbsp;</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">在人流量无法改变的情况下，怎样在可做的场景里及时去发现可优化的空间。比如：门店和门店之前哪些可以支持，不同仓和仓的调拨，不同区域和区域之间的协同。发现不同的营销方式，每天去做一些迭代优化，就会显得尤为重要。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">苏春园表示，在疫情发生的这一个月内，观远一些客户已经通过数据洞察，在很多决策上做出快速反应，找到了突破口。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">拿开闭店来说，1月份就有很多店铺陆续停业，有些分布在疫情重灾区或者写字楼的门店由于疫情和政策影响迟迟不能开业。而门店开业是需要各种人员、渠道、供应链、商品提前准备的，门店数量少的企业可以通过会议来进行协调，但是如果数量有上千家甚至几千家时，越高的决策层对于各区域开闭店的门店信息掌握就会越滞后，也会严重影响他们对于资源的协调以及经营政策的制定。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">据悉，观远数据部分客户，在疫情期间，基于之前的门店分析又增加了一项<b>开闭店分析</b>，各级决策层可以通过观远移动BI轻应用，对受政策影响的被动开闭店总数量、每日新增数量进行有效跟踪，<b>及时更新预估门店开业时间，快速协调后端支持资源。</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p style=\"text-align: center;\"><span style=\"color: rgb(51, 51, 51);\"><img alt=\"3.jpg\" src=\"https://ask.hellobi.com/uploads/article/20200227/afe5da2f51998527741f0310e059ea7e.jpg\" width=\"600\" height=\"1853.3333333333333\"></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">而在商品渠道端，既然消费者进店次数减少，那么，门店可以想办法通过提高客单价来提升营业额，同时也可以加强线上渠道的营销。目前，观远部分客户，在疫情期间，已经重点在做<b>特殊商品和渠道的分析监控，</b>通过优化商品组合，提高客单价，及时协调供应链资源，提高各个渠道的订单满足率。同时配合特殊商品预警功能，<b>可以让平时一周或一天监测一次的商品在特殊时期实现每小时推送一次，确保不缺货。</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p style=\"text-align: center;\"><img alt=\"4.jpg\" src=\"https://ask.hellobi.com/uploads/article/20200227/a93f5c6467640e6a228f9793f377fc33.jpg\" width=\"600\" height=\"1551.3333333333333\"><br></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">除了门店、渠道和商品的精细化运营，在疫情期间，仓储物流的配合也十分重要。受各个区域政策的影响，疫情期间的仓储物流的协调无法向平时一样自由，有些地方缺货，有些地方严重积压。这时候，决策者只有能一盘棋去监测整个仓储情况的全景，并结合区域疫情交通管制措施，才能快速规划可行性路径，做出响应。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">苏春园说：这些快反制胜的案例都是基于企业前期的数字化部署，而对于更多企业来说，<b>既然第一季度的损失无法挽回，更应该考虑如何基于现状苦练数字化内功，在后面的二三四季度中挽回损失，甚至实现反超。&nbsp;</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <h2 id=\"articleHeader3\"><span style=\"color: rgb(51, 51, 51);\">提升数字化内功，才能真正将疫情转危为机</span></h2>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">苏春园认为，2020年，企业对于数字化内功的追求，一定要抓住一个核心：用数据赋能两端，全面提高精细化运营能力。而这两端就是决策端和终端。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">根据新媒体特大号上周的一份调查问卷也显示，超过50.7%的IT人都认为，数据分析类产品对此次抗击疫情，尤其是疫情后的恢复有很大帮助，仅次于远程办公，排在数字化转型的前列。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">两端赋能如何去做？2019年，观远数据就已经联合零售消费领域诸多客户落地了相关分析案例，比如“空中巡店”模式。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><b><span style=\"color: rgb(51, 51, 51);\">“空中巡店”是面向一线店长、督导、区域和公司高层提供相应的数据分析和指标体系。</span></b><span style=\"color: rgb(51, 51, 51);\">在终端落地的应用我们称之为“店铺管家”，供管理层使用的应用称之为“巡店助理”。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><b><span style=\"color: rgb(51, 51, 51);\">“店铺管家”因为是面向终端店长，常规会通过移动端显示，方便使用者远程决策。</span></b><span style=\"color: rgb(51, 51, 51);\">主要为门店店长提供基于主题的仪表盘，包括销售分析、商品、排名等，跟踪和监控门店销售趋势、客户流量、转换率和目标完成率，可以帮助店长实时看到自己与同类其他店铺的表现，及时做出营销政策调整，提高店长数据经营的能力。</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><b><span style=\"color: rgb(51, 51, 51);\">而“巡店助理”可通过PC端、移动端数据展示方式，以全国-区域/渠道-门店等链路逐层展示经营情况，帮助总部管理层实现空中巡店。</span></b><span style=\"color: rgb(51, 51, 51);\">这种模式，不管在疫情期间，还是在未来，都能极大降低管理成本，帮助管理层及时发现末梢的经营问题，这也是提高零售行业精细化管理的能力。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p style=\"text-align: center;\"><img alt=\"5.jpg\" src=\"https://ask.hellobi.com/uploads/article/20200227/cba82cf05ab3539b87ea3797da7d610b.jpg\" width=\"600\" height=\"311.80555555555554\"><br></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">空中巡店是目前观远数据总结的一套自上而下的智能数据分析指标体系，而企业在实际落地过程中可以从渠道、商品、供应链、门店、营销、财务、人力资源、财务等八大场景为切入点，逐级提升自己的精细化运营水平。&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">针对疫情期间的微商运营，“空中巡店”额外为店长提供“微商小助手“移动应用，对微信群营销、微商城营销等线上运营进行动态分析，通过店铺赛马、标杆分析，为店长们提供更匹配的营销建议。</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p style=\"text-align: center;\"><span style=\"color: rgb(51, 51, 51);\"><img alt=\"6.jpg\" src=\"https://ask.hellobi.com/uploads/article/20200227/9f4c064f4bcc495e9b740f3bb95e3cc8.jpg\" width=\"600\" height=\"948.3333333333334\"></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">疫情很快会过去，但基于数字化构建的内功比过去任何时候都更加重要。黑天鹅、灰犀牛现象频繁出现，这个VUCA的不确定时代是无比的真实，与我们每一位息息相关。<b>苏春园表示：面对不确定性将成为常态的未来，我们需要抓住其中的确定性。用数据驱动经营，让决策更加智能。</b></span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p><span style=\"color: rgb(51, 51, 51);\">&nbsp;</span></p>\n <p>&nbsp;</p> \n <ul class=\"aw-upload-file-list\"> \n </ul> \n</div>', '2020-02-27');

SET FOREIGN_KEY_CHECKS = 1;
