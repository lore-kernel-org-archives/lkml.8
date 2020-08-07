Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6639C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD29D2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHGUW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:22:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:49941 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGUW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:22:29 -0400
IronPort-SDR: bhGaJvbOOck84HvUqTLg0S99uaJA74IziwXl0ubMaUO/2QgitI2CMwbAz92Ym92kuZbNn6U1+Q
 2AzAgQFnT45A==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="217520868"
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="scan'208";a="217520868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 13:22:27 -0700
IronPort-SDR: 6qhjjTBH6tJaEI4w6lWJ6xxvRhtClOiIDOvi+sniXaRBgGzc6zohVcqKDZjEkUW3kIbCCNcJpB
 /TGLfDXEsXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="scan'208";a="494155880"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2020 13:22:26 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k48sk-0000SH-3v; Fri, 07 Aug 2020 20:22:26 +0000
Date:   Sat, 8 Aug 2020 04:21:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/ptp/ptp_idt82p33.c:469:9: warning: Identical condition
 'err', second condition is always false
Message-ID: <202008080456.41pcA6ua%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5631c5e0eb9035d92ceb20fcd9cdb7779a3f5cc7
commit: 57a10d8c1123068e3cb06434fbc9634f945d3062 ptp: Add a ptp clock driver for IDT 82P33 SMU.
date:   6 months ago
compiler: powerpc64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/ptp/ptp_idt82p33.c:469:9: warning: Identical condition 'err', second condition is always false [identicalConditionAfterEarlyExit]
    return err;
           ^
   drivers/ptp/ptp_idt82p33.c:462:6: note: first condition
    if (err)
        ^
   drivers/ptp/ptp_idt82p33.c:469:9: note: second condition
    return err;
           ^

vim +/err +469 drivers/ptp/ptp_idt82p33.c

   440	
   441	static int idt82p33_measure_tod_write_overhead(struct idt82p33_channel *channel)
   442	{
   443		s64 trailing_overhead_ns, one_byte_write_ns, gap_ns;
   444		struct idt82p33 *idt82p33 = channel->idt82p33;
   445		int err;
   446	
   447		idt82p33->tod_write_overhead_ns = 0;
   448	
   449		err = idt82p33_measure_settime_gettime_gap_overhead(channel, &gap_ns);
   450	
   451		if (err)
   452			return err;
   453	
   454		err = idt82p33_measure_one_byte_write_overhead(channel,
   455							       &one_byte_write_ns);
   456	
   457		if (err)
   458			return err;
   459	
   460		err = idt82p33_measure_tod_write_9_byte_overhead(channel);
   461	
   462		if (err)
   463			return err;
   464	
   465		trailing_overhead_ns = gap_ns - (2 * one_byte_write_ns);
   466	
   467		idt82p33->tod_write_overhead_ns -= trailing_overhead_ns;
   468	
 > 469		return err;
   470	}
   471	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
