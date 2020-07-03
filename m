Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F0220747
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgGCXBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:01:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:54839 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgGCXBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:01:36 -0400
IronPort-SDR: xuHXB9F5xmuoMun2c9RtgTvImyfJmfYlVLpUG7lqJZQWV3q76cix885UI7gtxTBJM9pGWQ3k2i
 rj1GGQhnvqZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="146292637"
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="scan'208";a="146292637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 16:01:35 -0700
IronPort-SDR: NRiAxMx9RtTvKIvKBwVJSIGP0xi0nJ2tR6ASsFlHrRnMuyQ7M/EfUa6f5zSXtpaF8c+LP2yf65
 kHOwgR91NwtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="scan'208";a="282394205"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2020 16:01:34 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jrUgX-0000RU-Df; Fri, 03 Jul 2020 23:01:33 +0000
Date:   Sat, 4 Jul 2020 07:01:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org, sudeep.holla@arm.com,
        cristian.marussi@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: fix notifications macros argument
 reuse
Message-ID: <202007040619.62IIIoeR%lkp@intel.com>
References: <20200630162547.40824-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630162547.40824-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20200630]
[cannot apply to linux/master soc/for-next linus/master v5.8-rc3 v5.8-rc2 v5.8-rc1 v5.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cristian-Marussi/firmware-arm_scmi-fix-notifications-macros-argument-reuse/20200701-002818
base:    f2b92b14533e646e434523abdbafddb727c23898
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   drivers/firmware/arm_scmi/notify.c:660:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/firmware/arm_scmi/notify.c:654:6: note: first condition
    if (ret)
        ^
   drivers/firmware/arm_scmi/notify.c:660:9: note: second condition
    return ret;
           ^
>> drivers/firmware/arm_scmi/notify.c:1125:9: warning: Variable 'r' is reassigned a value before the old one has been used. [redundantAssignment]
       r = REVT_NOTIFY_ENABLE(r_evt,
           ^
   drivers/firmware/arm_scmi/notify.c:1125:7: note: Variable 'r' is reassigned a value before the old one has been used.
       r = REVT_NOTIFY_ENABLE(r_evt,
         ^
   drivers/firmware/arm_scmi/notify.c:1125:9: note: Variable 'r' is reassigned a value before the old one has been used.
       r = REVT_NOTIFY_ENABLE(r_evt,
           ^

vim +/r +1125 drivers/firmware/arm_scmi/notify.c

7a57069e9daf95a Cristian Marussi 2020-06-19  1090  
5b352c5379300ec Cristian Marussi 2020-06-19  1091  /**
5b352c5379300ec Cristian Marussi 2020-06-19  1092   * __scmi_enable_evt()  - Enable/disable events generation
5b352c5379300ec Cristian Marussi 2020-06-19  1093   * @r_evt: The registered event to act upon
5b352c5379300ec Cristian Marussi 2020-06-19  1094   * @src_id: The src_id to act upon
5b352c5379300ec Cristian Marussi 2020-06-19  1095   * @enable: The action to perform: true->Enable, false->Disable
5b352c5379300ec Cristian Marussi 2020-06-19  1096   *
5b352c5379300ec Cristian Marussi 2020-06-19  1097   * Takes care of proper refcounting while performing enable/disable: handles
5b352c5379300ec Cristian Marussi 2020-06-19  1098   * the special case of ALL sources requests by itself.
5b352c5379300ec Cristian Marussi 2020-06-19  1099   *
5b352c5379300ec Cristian Marussi 2020-06-19  1100   * Return: True when the required action has been successfully executed
5b352c5379300ec Cristian Marussi 2020-06-19  1101   */
5b352c5379300ec Cristian Marussi 2020-06-19  1102  static inline bool __scmi_enable_evt(struct scmi_registered_event *r_evt,
5b352c5379300ec Cristian Marussi 2020-06-19  1103  				     u32 src_id, bool enable)
5b352c5379300ec Cristian Marussi 2020-06-19  1104  {
5b352c5379300ec Cristian Marussi 2020-06-19  1105  	int ret = 0;
5b352c5379300ec Cristian Marussi 2020-06-19  1106  	u32 num_sources;
5b352c5379300ec Cristian Marussi 2020-06-19  1107  	refcount_t *sid;
5b352c5379300ec Cristian Marussi 2020-06-19  1108  
5b352c5379300ec Cristian Marussi 2020-06-19  1109  	if (src_id == SRC_ID_MASK) {
5b352c5379300ec Cristian Marussi 2020-06-19  1110  		src_id = 0;
5b352c5379300ec Cristian Marussi 2020-06-19  1111  		num_sources = r_evt->num_sources;
5b352c5379300ec Cristian Marussi 2020-06-19  1112  	} else if (src_id < r_evt->num_sources) {
5b352c5379300ec Cristian Marussi 2020-06-19  1113  		num_sources = 1;
5b352c5379300ec Cristian Marussi 2020-06-19  1114  	} else {
5b352c5379300ec Cristian Marussi 2020-06-19  1115  		return ret;
5b352c5379300ec Cristian Marussi 2020-06-19  1116  	}
5b352c5379300ec Cristian Marussi 2020-06-19  1117  
5b352c5379300ec Cristian Marussi 2020-06-19  1118  	mutex_lock(&r_evt->sources_mtx);
5b352c5379300ec Cristian Marussi 2020-06-19  1119  	if (enable) {
5b352c5379300ec Cristian Marussi 2020-06-19  1120  		for (; num_sources; src_id++, num_sources--) {
5b352c5379300ec Cristian Marussi 2020-06-19  1121  			bool r;
5b352c5379300ec Cristian Marussi 2020-06-19  1122  
5b352c5379300ec Cristian Marussi 2020-06-19  1123  			sid = &r_evt->sources[src_id];
5b352c5379300ec Cristian Marussi 2020-06-19  1124  			if (refcount_read(sid) == 0) {
5b352c5379300ec Cristian Marussi 2020-06-19 @1125  				r = REVT_NOTIFY_ENABLE(r_evt,
5b352c5379300ec Cristian Marussi 2020-06-19  1126  						       r_evt->evt->id, src_id);
5b352c5379300ec Cristian Marussi 2020-06-19  1127  				if (r)
5b352c5379300ec Cristian Marussi 2020-06-19  1128  					refcount_set(sid, 1);
5b352c5379300ec Cristian Marussi 2020-06-19  1129  			} else {
5b352c5379300ec Cristian Marussi 2020-06-19  1130  				refcount_inc(sid);
5b352c5379300ec Cristian Marussi 2020-06-19  1131  				r = true;
5b352c5379300ec Cristian Marussi 2020-06-19  1132  			}
5b352c5379300ec Cristian Marussi 2020-06-19  1133  			ret += r;
5b352c5379300ec Cristian Marussi 2020-06-19  1134  		}
5b352c5379300ec Cristian Marussi 2020-06-19  1135  	} else {
5b352c5379300ec Cristian Marussi 2020-06-19  1136  		for (; num_sources; src_id++, num_sources--) {
5b352c5379300ec Cristian Marussi 2020-06-19  1137  			sid = &r_evt->sources[src_id];
5b352c5379300ec Cristian Marussi 2020-06-19  1138  			if (refcount_dec_and_test(sid))
5b352c5379300ec Cristian Marussi 2020-06-19  1139  				REVT_NOTIFY_DISABLE(r_evt,
5b352c5379300ec Cristian Marussi 2020-06-19  1140  						    r_evt->evt->id, src_id);
5b352c5379300ec Cristian Marussi 2020-06-19  1141  		}
5b352c5379300ec Cristian Marussi 2020-06-19  1142  		ret = 1;
5b352c5379300ec Cristian Marussi 2020-06-19  1143  	}
5b352c5379300ec Cristian Marussi 2020-06-19  1144  	mutex_unlock(&r_evt->sources_mtx);
5b352c5379300ec Cristian Marussi 2020-06-19  1145  
5b352c5379300ec Cristian Marussi 2020-06-19  1146  	return ret;
5b352c5379300ec Cristian Marussi 2020-06-19  1147  }
5b352c5379300ec Cristian Marussi 2020-06-19  1148  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
