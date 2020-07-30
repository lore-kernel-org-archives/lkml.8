Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89340C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FCAB20842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgG3FbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:31:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:39691 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3FbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:31:04 -0400
IronPort-SDR: hTralc1MB6XmwS6/8sobgfRaCxFbKiiTFaYz9l9RhH1JdPo5Mv8hkwCLxOd7lzWbVgJG3bD3vS
 eKT/VHXeGdOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="139075713"
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="139075713"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 22:31:03 -0700
IronPort-SDR: PsF4xgceipV6YKH4VRgqhX29jjJkM/lY2ZLTHtK440pBbuNUj/0DZTlybVA4GQef05s1cNUlo/
 +n7GobLc/jMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,413,1589266800"; 
   d="scan'208";a="330632759"
Received: from lkp-server01.sh.intel.com (HELO aff35d61a1e5) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Jul 2020 22:31:02 -0700
Received: from kbuild by aff35d61a1e5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k119h-00005s-PV; Thu, 30 Jul 2020 05:31:01 +0000
Date:   Thu, 30 Jul 2020 13:30:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/rtc/rtc-pcf85063.c:292:40: warning: Clarify calculation
 precedence for '&' and
Message-ID: <202007301329.vj66ufFB%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3590ebf6f91350192737dd1d1b219c05277f067
commit: f86dc5bde18e540743eaef20529d9f2b67283abd rtc: pcf85063: return meaningful value for RTC_VL_READ
date:   8 months ago
compiler: or1k-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/rtc/rtc-pcf85063.c:292:40: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     status = status & PCF85063_REG_SC_OS ? RTC_VL_DATA_INVALID : 0;
                                          ^

vim +292 drivers/rtc/rtc-pcf85063.c

   279	
   280	static int pcf85063_ioctl(struct device *dev, unsigned int cmd,
   281				  unsigned long arg)
   282	{
   283		struct pcf85063 *pcf85063 = dev_get_drvdata(dev);
   284		int status, ret = 0;
   285	
   286		switch (cmd) {
   287		case RTC_VL_READ:
   288			ret = regmap_read(pcf85063->regmap, PCF85063_REG_SC, &status);
   289			if (ret < 0)
   290				return ret;
   291	
 > 292			status = status & PCF85063_REG_SC_OS ? RTC_VL_DATA_INVALID : 0;
   293	
   294			return put_user(status, (unsigned int __user *)arg);
   295	
   296		default:
   297			return -ENOIOCTLCMD;
   298		}
   299	}
   300	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
