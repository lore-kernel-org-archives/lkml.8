Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAAFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2A62070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgGFNUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:20:51 -0400
Received: from foss.arm.com ([217.140.110.172]:39756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgGFNUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:20:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E7D21FB;
        Mon,  6 Jul 2020 06:20:50 -0700 (PDT)
Received: from e119603-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BD713F71E;
        Mon,  6 Jul 2020 06:20:49 -0700 (PDT)
Date:   Mon, 6 Jul 2020 14:20:39 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kbuild-all@lists.01.org, sudeep.holla@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: fix notifications macros argument
 reuse
Message-ID: <20200706132015.GA12498@e119603-lin.cambridge.arm.com>
References: <20200630162547.40824-1-cristian.marussi@arm.com>
 <202007040619.62IIIoeR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007040619.62IIIoeR%lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sat, Jul 04, 2020 at 07:01:21AM +0800, kernel test robot wrote:
> Hi Cristian,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20200630]
> [cannot apply to linux/master soc/for-next linus/master v5.8-rc3 v5.8-rc2 v5.8-rc1 v5.8-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Cristian-Marussi/firmware-arm_scmi-fix-notifications-macros-argument-reuse/20200701-002818
> base:    f2b92b14533e646e434523abdbafddb727c23898
> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 

This patch was afterwards squashed into the SCMI Notifications series V11:

https://lore.kernel.org/linux-arm-kernel/20200701155348.52864-1-cristian.marussi@arm.com/

and requeued on next, and, as I can see all of the surrounding/offending code
referenced in this report has been modified in V11 so I don' expect the reported
issues to be anymore valid...but let's wait to see the next CI run results on
next- to be sure about that :D (a local SMATCH/sparse run returned me no issues on V11)

Thanks

Cristian


> cppcheck warnings: (new ones prefixed by >>)
> 
>    drivers/firmware/arm_scmi/notify.c:660:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
>     return ret;
>            ^
>    drivers/firmware/arm_scmi/notify.c:654:6: note: first condition
>     if (ret)
>         ^
>    drivers/firmware/arm_scmi/notify.c:660:9: note: second condition
>     return ret;
>            ^
> >> drivers/firmware/arm_scmi/notify.c:1125:9: warning: Variable 'r' is reassigned a value before the old one has been used. [redundantAssignment]
>        r = REVT_NOTIFY_ENABLE(r_evt,
>            ^
>    drivers/firmware/arm_scmi/notify.c:1125:7: note: Variable 'r' is reassigned a value before the old one has been used.
>        r = REVT_NOTIFY_ENABLE(r_evt,
>          ^
>    drivers/firmware/arm_scmi/notify.c:1125:9: note: Variable 'r' is reassigned a value before the old one has been used.
>        r = REVT_NOTIFY_ENABLE(r_evt,
>            ^
> 
> vim +/r +1125 drivers/firmware/arm_scmi/notify.c
> 
> 7a57069e9daf95a Cristian Marussi 2020-06-19  1090  
> 5b352c5379300ec Cristian Marussi 2020-06-19  1091  /**
> 5b352c5379300ec Cristian Marussi 2020-06-19  1092   * __scmi_enable_evt()  - Enable/disable events generation
> 5b352c5379300ec Cristian Marussi 2020-06-19  1093   * @r_evt: The registered event to act upon
> 5b352c5379300ec Cristian Marussi 2020-06-19  1094   * @src_id: The src_id to act upon
> 5b352c5379300ec Cristian Marussi 2020-06-19  1095   * @enable: The action to perform: true->Enable, false->Disable
> 5b352c5379300ec Cristian Marussi 2020-06-19  1096   *
> 5b352c5379300ec Cristian Marussi 2020-06-19  1097   * Takes care of proper refcounting while performing enable/disable: handles
> 5b352c5379300ec Cristian Marussi 2020-06-19  1098   * the special case of ALL sources requests by itself.
> 5b352c5379300ec Cristian Marussi 2020-06-19  1099   *
> 5b352c5379300ec Cristian Marussi 2020-06-19  1100   * Return: True when the required action has been successfully executed
> 5b352c5379300ec Cristian Marussi 2020-06-19  1101   */
> 5b352c5379300ec Cristian Marussi 2020-06-19  1102  static inline bool __scmi_enable_evt(struct scmi_registered_event *r_evt,
> 5b352c5379300ec Cristian Marussi 2020-06-19  1103  				     u32 src_id, bool enable)
> 5b352c5379300ec Cristian Marussi 2020-06-19  1104  {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1105  	int ret = 0;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1106  	u32 num_sources;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1107  	refcount_t *sid;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1108  
> 5b352c5379300ec Cristian Marussi 2020-06-19  1109  	if (src_id == SRC_ID_MASK) {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1110  		src_id = 0;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1111  		num_sources = r_evt->num_sources;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1112  	} else if (src_id < r_evt->num_sources) {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1113  		num_sources = 1;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1114  	} else {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1115  		return ret;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1116  	}
> 5b352c5379300ec Cristian Marussi 2020-06-19  1117  
> 5b352c5379300ec Cristian Marussi 2020-06-19  1118  	mutex_lock(&r_evt->sources_mtx);
> 5b352c5379300ec Cristian Marussi 2020-06-19  1119  	if (enable) {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1120  		for (; num_sources; src_id++, num_sources--) {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1121  			bool r;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1122  
> 5b352c5379300ec Cristian Marussi 2020-06-19  1123  			sid = &r_evt->sources[src_id];
> 5b352c5379300ec Cristian Marussi 2020-06-19  1124  			if (refcount_read(sid) == 0) {
> 5b352c5379300ec Cristian Marussi 2020-06-19 @1125  				r = REVT_NOTIFY_ENABLE(r_evt,
> 5b352c5379300ec Cristian Marussi 2020-06-19  1126  						       r_evt->evt->id, src_id);
> 5b352c5379300ec Cristian Marussi 2020-06-19  1127  				if (r)
> 5b352c5379300ec Cristian Marussi 2020-06-19  1128  					refcount_set(sid, 1);
> 5b352c5379300ec Cristian Marussi 2020-06-19  1129  			} else {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1130  				refcount_inc(sid);
> 5b352c5379300ec Cristian Marussi 2020-06-19  1131  				r = true;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1132  			}
> 5b352c5379300ec Cristian Marussi 2020-06-19  1133  			ret += r;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1134  		}
> 5b352c5379300ec Cristian Marussi 2020-06-19  1135  	} else {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1136  		for (; num_sources; src_id++, num_sources--) {
> 5b352c5379300ec Cristian Marussi 2020-06-19  1137  			sid = &r_evt->sources[src_id];
> 5b352c5379300ec Cristian Marussi 2020-06-19  1138  			if (refcount_dec_and_test(sid))
> 5b352c5379300ec Cristian Marussi 2020-06-19  1139  				REVT_NOTIFY_DISABLE(r_evt,
> 5b352c5379300ec Cristian Marussi 2020-06-19  1140  						    r_evt->evt->id, src_id);
> 5b352c5379300ec Cristian Marussi 2020-06-19  1141  		}
> 5b352c5379300ec Cristian Marussi 2020-06-19  1142  		ret = 1;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1143  	}
> 5b352c5379300ec Cristian Marussi 2020-06-19  1144  	mutex_unlock(&r_evt->sources_mtx);
> 5b352c5379300ec Cristian Marussi 2020-06-19  1145  
> 5b352c5379300ec Cristian Marussi 2020-06-19  1146  	return ret;
> 5b352c5379300ec Cristian Marussi 2020-06-19  1147  }
> 5b352c5379300ec Cristian Marussi 2020-06-19  1148  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
