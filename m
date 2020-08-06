Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D64C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E282177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHFDFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:05:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:60473 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHFDFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:05:01 -0400
IronPort-SDR: px81bCDKvwI7tfCDnjBhVUSQuLbjIS+/BtwpslZ6A1W8g/NBDwnn52XClCXU8S5kgu/QdNHnD3
 l80s9qO+FTjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="140593936"
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="140593936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 20:04:59 -0700
IronPort-SDR: bMFRzZb/evurcLbUSY5VOONCyOVaqkxXf6lHOq74lIOctnlBFAdoIXLbgUP4ipqeRaHfp01IaK
 1e6tCBtC6IqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,440,1589266800"; 
   d="scan'208";a="397116547"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2020 20:04:57 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3WDA-00013X-JP; Thu, 06 Aug 2020 03:04:56 +0000
Date:   Thu, 6 Aug 2020 11:04:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: drivers/net/ethernet/xilinx/ll_temac_main.c:93:2: warning:
 Non-boolean value returned from function returning bool
Message-ID: <202008061102.jP3Qxahb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b
commit: e8b6c54f6d57822e228027d41a1edb317034a08c net: xilinx: temac: Relax Kconfig dependencies
date:   4 months ago
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/xilinx/ll_temac_main.c:93:2: warning: Non-boolean value returned from function returning bool [returnNonBoolInBooleanFunction]
    return temac_ior(lp, XTE_RDY0_OFFSET) & XTE_RDY0_HARD_ACS_RDY_MASK;
    ^
>> drivers/net/ethernet/xilinx/ll_temac_main.c:469:44: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     temac_indirect_out32(lp, XTE_AFM_OFFSET, XTE_AFM_EPPRM_MASK);
                                              ^
   drivers/net/ethernet/xilinx/ll_temac_main.c:505:8: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
        & XTE_AFM_EPPRM_MASK) {
          ^
   drivers/net/ethernet/xilinx/ll_temac_main.c:579:10: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     .m_or =XTE_AFM_EPPRM_MASK,
            ^
   drivers/net/ethernet/xilinx/ll_temac_main.c:637:44: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    temac_indirect_out32(lp, XTE_RXC1_OFFSET, XTE_RXC1_RXRST_MASK);
                                              ^
   drivers/net/ethernet/xilinx/ll_temac_main.c:639:52: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    while (temac_indirect_in32(lp, XTE_RXC1_OFFSET) & XTE_RXC1_RXRST_MASK) {
                                                      ^
   drivers/net/ethernet/xilinx/ll_temac_main.c:649:43: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    temac_indirect_out32(lp, XTE_TXC_OFFSET, XTE_TXC_TXRST_MASK);
                                             ^
   drivers/net/ethernet/xilinx/ll_temac_main.c:651:51: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    while (temac_indirect_in32(lp, XTE_TXC_OFFSET) & XTE_TXC_TXRST_MASK) {
                                                     ^
   drivers/net/ethernet/xilinx/ll_temac_main.c:725:33: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     case SPEED_1000: mii_speed |= XTE_EMCFG_LINKSPD_1000; break;
                                   ^

vim +93 drivers/net/ethernet/xilinx/ll_temac_main.c

92744989533cbe drivers/net/ll_temac_main.c                 Grant Likely    2009-04-25  90  
1bd33bf0fe6d30 drivers/net/ethernet/xilinx/ll_temac_main.c Esben Haabendal 2019-05-23  91  static bool hard_acs_rdy(struct temac_local *lp)
1bd33bf0fe6d30 drivers/net/ethernet/xilinx/ll_temac_main.c Esben Haabendal 2019-05-23  92  {
1bd33bf0fe6d30 drivers/net/ethernet/xilinx/ll_temac_main.c Esben Haabendal 2019-05-23 @93  	return temac_ior(lp, XTE_RDY0_OFFSET) & XTE_RDY0_HARD_ACS_RDY_MASK;
1bd33bf0fe6d30 drivers/net/ethernet/xilinx/ll_temac_main.c Esben Haabendal 2019-05-23  94  }
1bd33bf0fe6d30 drivers/net/ethernet/xilinx/ll_temac_main.c Esben Haabendal 2019-05-23  95  

:::::: The code at line 93 was first introduced by commit
:::::: 1bd33bf0fe6d3012410db0302187199871b510a0 net: ll_temac: Prepare indirect register access for multicast support

:::::: TO: Esben Haabendal <esben@geanix.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
