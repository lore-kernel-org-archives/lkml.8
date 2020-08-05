Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4860CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152C322D03
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgHEJF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:05:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:27892 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEJFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:05:53 -0400
IronPort-SDR: T57YUoXi+bwBRJf+FzoeMdRHqwwVyZlnp4QA21xi4iejUKShB9Ytrugq/2U5oglGNJFRXS74m0
 Y/a5u9EWaIsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="216863773"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="216863773"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 02:05:45 -0700
IronPort-SDR: Kzwp82pBLdFei3BWT/qCXlnI2d16e8soJ/QDqEDH8PGdUAwjfsKX3fjmNg5UxuFHcEaQeG5Puh
 ECqM+C4QRzdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="306638133"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2020 02:05:42 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3FMk-0000gz-5w; Wed, 05 Aug 2020 09:05:42 +0000
Date:   Wed, 5 Aug 2020 17:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, arnaud.pouliquen@st.com
Subject: Re: [PATCH 5/9] rpmsg: introduce reserved rpmsg driver for ns
 announcement
Message-ID: <202008051645.ApSUqqOG%lkp@intel.com>
References: <20200731114732.12815-6-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731114732.12815-6-arnaud.pouliquen@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20200730]
[also build test WARNING on v5.8]
[cannot apply to linux/master linus/master rpmsg/for-next v5.8-rc7 v5.8-rc6 v5.8-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/introduce-name-service-announcement-rpmsg-driver/20200731-195014
base:    7b287a5c6ac518c415a258f2aa7b1ebb25c263d2
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/rpmsg/rpmsg_ns.c:68:34: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
      msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
                                    ^

vim +68 drivers/rpmsg/rpmsg_ns.c

    54	
    55		if (len != sizeof(*msg)) {
    56			dev_err(dev, "malformed ns msg (%d)\n", len);
    57			return -EINVAL;
    58		}
    59	
    60		/* don't trust the remote processor for null terminating the name */
    61		msg->name[RPMSG_NAME_SIZE - 1] = '\0';
    62	
    63		strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
    64		chinfo.src = RPMSG_ADDR_ANY;
    65		chinfo.dst = msg->addr;
    66	
    67		dev_info(dev, "%sing channel %s addr 0x%x\n",
  > 68			 msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
    69			 msg->name, msg->addr);
    70	
    71		if (msg->flags & RPMSG_NS_DESTROY) {
    72			ret = rpmsg_release_channel(rpdev, &chinfo);
    73			if (ret)
    74				dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
    75		} else {
    76			newch = rpmsg_create_channel(rpdev, &chinfo);
    77			if (!newch)
    78				dev_err(dev, "rpmsg_create_channel failed\n");
    79		}
    80	
    81		return 0;
    82	}
    83	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
