Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2676DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD031207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgFBARh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:17:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:21402 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgFBARg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:17:36 -0400
IronPort-SDR: RZqQmYpDRvyhhUL6UBuId5wbauWfnrcsXIPrBughiDsTUCftw9krbT7zC9SaPkw1MinU1oFsC6
 oxAYaVCT/1yQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 16:50:02 -0700
IronPort-SDR: 9wzPr5FftcRJ3CMIfMBODOXr8r+6criYOO28lEey7S1Cqm+69OFILNk2zt8gLw/m1sLdRt3QXj
 ZkWvuRJoTcXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="gz'50?scan'50,208,50";a="470463086"
Received: from lkp-server01.sh.intel.com (HELO 78d03bb9d680) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2020 16:49:58 -0700
Received: from kbuild by 78d03bb9d680 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfuBq-0000DQ-4W; Mon, 01 Jun 2020 23:49:58 +0000
Date:   Tue, 2 Jun 2020 07:49:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Colin, Ian, King," <colin.king@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: drivers/usb/cdns3/drd.c:336:35: sparse:     expected struct
 cdns3_otg_regs *otg_v1_regs
Message-ID: <202006020722.sGO2JjJt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69
commit: 70d8b9e5e63d212019ba3f6823c8ec3d2df87645 usb: cdns3: make signed 1 bit bitfields unsigned
date:   10 weeks ago
config: parisc-randconfig-s031-20200601 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-243-gc100a7ab-dirty
        git checkout 70d8b9e5e63d212019ba3f6823c8ec3d2df87645
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=parisc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/cdns3/drd.c:43:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:43:42: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:43:42: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:45:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:45:42: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:45:42: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:47:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:47:42: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:47:42: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:49:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:49:42: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:49:42: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:71:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:71:25: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:71:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:81:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:81:30: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:81:30: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:114:24: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:114:24: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:114:24: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:124:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:124:48: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:124:48: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:141:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:141:56: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:141:56: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:144:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:144:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:144:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:144:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:144:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:154:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:154:29: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:154:29: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:156:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:156:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:156:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:156:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:156:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:178:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:178:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:178:55: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:182:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:182:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:182:23: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:182:23: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:197:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:197:29: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:197:29: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:199:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:199:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:219:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:219:25: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:219:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:284:26: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:26: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:303:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:303:25: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:303:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:326:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_legacy_regs *otg_v0_regs @@     got void [noderef] <asn:2> *[assigned] regs @@
   drivers/usb/cdns3/drd.c:326:27: sparse:     expected struct cdns3_otg_legacy_regs *otg_v0_regs
   drivers/usb/cdns3/drd.c:326:27: sparse:     got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:327:25: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:330:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_common_regs *otg_regs @@     got void [noderef] <asn:2> *[assigned] regs @@
   drivers/usb/cdns3/drd.c:330:32: sparse:     expected struct cdns3_otg_common_regs *otg_regs
   drivers/usb/cdns3/drd.c:330:32: sparse:     got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:331:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:331:32: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:331:32: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:332:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:332:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:336:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_regs *otg_v1_regs @@     got void [noderef] <asn:2> *[assigned] regs @@
>> drivers/usb/cdns3/drd.c:336:35: sparse:     expected struct cdns3_otg_regs *otg_v1_regs
   drivers/usb/cdns3/drd.c:336:35: sparse:     got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:339:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:339:32: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:339:32: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:340:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:340:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:340:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:340:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:340:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:345:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:345:17: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:345:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:368:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:368:28: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:368:28: sparse:     got restricted __le32 *

vim +336 drivers/usb/cdns3/drd.c

7733f6c32e36ff Pawel Laszczak 2019-08-26  306  
7733f6c32e36ff Pawel Laszczak 2019-08-26  307  int cdns3_drd_init(struct cdns3 *cdns)
7733f6c32e36ff Pawel Laszczak 2019-08-26  308  {
7733f6c32e36ff Pawel Laszczak 2019-08-26  309  	void __iomem *regs;
7733f6c32e36ff Pawel Laszczak 2019-08-26  310  	int ret = 0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  311  	u32 state;
7733f6c32e36ff Pawel Laszczak 2019-08-26  312  
7733f6c32e36ff Pawel Laszczak 2019-08-26  313  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
7733f6c32e36ff Pawel Laszczak 2019-08-26  314  	if (IS_ERR(regs))
7733f6c32e36ff Pawel Laszczak 2019-08-26  315  		return PTR_ERR(regs);
7733f6c32e36ff Pawel Laszczak 2019-08-26  316  
7733f6c32e36ff Pawel Laszczak 2019-08-26  317  	/* Detection of DRD version. Controller has been released
7733f6c32e36ff Pawel Laszczak 2019-08-26  318  	 * in two versions. Both are similar, but they have same changes
7733f6c32e36ff Pawel Laszczak 2019-08-26  319  	 * in register maps.
7733f6c32e36ff Pawel Laszczak 2019-08-26  320  	 * The first register in old version is command register and it's read
7733f6c32e36ff Pawel Laszczak 2019-08-26  321  	 * only, so driver should read 0 from it. On the other hand, in v1
7733f6c32e36ff Pawel Laszczak 2019-08-26  322  	 * the first register contains device ID number which is not set to 0.
7733f6c32e36ff Pawel Laszczak 2019-08-26  323  	 * Driver uses this fact to detect the proper version of
7733f6c32e36ff Pawel Laszczak 2019-08-26  324  	 * controller.
7733f6c32e36ff Pawel Laszczak 2019-08-26  325  	 */
7733f6c32e36ff Pawel Laszczak 2019-08-26  326  	cdns->otg_v0_regs = regs;
7733f6c32e36ff Pawel Laszczak 2019-08-26  327  	if (!readl(&cdns->otg_v0_regs->cmd)) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  328  		cdns->version  = CDNS3_CONTROLLER_V0;
7733f6c32e36ff Pawel Laszczak 2019-08-26  329  		cdns->otg_v1_regs = NULL;
7733f6c32e36ff Pawel Laszczak 2019-08-26  330  		cdns->otg_regs = regs;
7733f6c32e36ff Pawel Laszczak 2019-08-26  331  		writel(1, &cdns->otg_v0_regs->simulate);
7733f6c32e36ff Pawel Laszczak 2019-08-26  332  		dev_info(cdns->dev, "DRD version v0 (%08x)\n",
7733f6c32e36ff Pawel Laszczak 2019-08-26  333  			 readl(&cdns->otg_v0_regs->version));
7733f6c32e36ff Pawel Laszczak 2019-08-26  334  	} else {
7733f6c32e36ff Pawel Laszczak 2019-08-26  335  		cdns->otg_v0_regs = NULL;
7733f6c32e36ff Pawel Laszczak 2019-08-26 @336  		cdns->otg_v1_regs = regs;
7733f6c32e36ff Pawel Laszczak 2019-08-26  337  		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
7733f6c32e36ff Pawel Laszczak 2019-08-26  338  		cdns->version  = CDNS3_CONTROLLER_V1;
7733f6c32e36ff Pawel Laszczak 2019-08-26  339  		writel(1, &cdns->otg_v1_regs->simulate);
7733f6c32e36ff Pawel Laszczak 2019-08-26  340  		dev_info(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
7733f6c32e36ff Pawel Laszczak 2019-08-26  341  			 readl(&cdns->otg_v1_regs->did),
7733f6c32e36ff Pawel Laszczak 2019-08-26  342  			 readl(&cdns->otg_v1_regs->rid));
7733f6c32e36ff Pawel Laszczak 2019-08-26  343  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  344  
7733f6c32e36ff Pawel Laszczak 2019-08-26  345  	state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
7733f6c32e36ff Pawel Laszczak 2019-08-26  346  
7733f6c32e36ff Pawel Laszczak 2019-08-26  347  	/* Update dr_mode according to STRAP configuration. */
7733f6c32e36ff Pawel Laszczak 2019-08-26  348  	cdns->dr_mode = USB_DR_MODE_OTG;
7733f6c32e36ff Pawel Laszczak 2019-08-26  349  	if (state == OTGSTS_STRAP_HOST) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  350  		dev_dbg(cdns->dev, "Controller strapped to HOST\n");
7733f6c32e36ff Pawel Laszczak 2019-08-26  351  		cdns->dr_mode = USB_DR_MODE_HOST;
7733f6c32e36ff Pawel Laszczak 2019-08-26  352  	} else if (state == OTGSTS_STRAP_GADGET) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  353  		dev_dbg(cdns->dev, "Controller strapped to PERIPHERAL\n");
7733f6c32e36ff Pawel Laszczak 2019-08-26  354  		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
7733f6c32e36ff Pawel Laszczak 2019-08-26  355  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  356  
7733f6c32e36ff Pawel Laszczak 2019-08-26  357  	ret = devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
7733f6c32e36ff Pawel Laszczak 2019-08-26  358  					cdns3_drd_irq,
7733f6c32e36ff Pawel Laszczak 2019-08-26  359  					cdns3_drd_thread_irq,
7733f6c32e36ff Pawel Laszczak 2019-08-26  360  					IRQF_SHARED,
7733f6c32e36ff Pawel Laszczak 2019-08-26  361  					dev_name(cdns->dev), cdns);
7733f6c32e36ff Pawel Laszczak 2019-08-26  362  
7733f6c32e36ff Pawel Laszczak 2019-08-26  363  	if (ret) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  364  		dev_err(cdns->dev, "couldn't get otg_irq\n");
7733f6c32e36ff Pawel Laszczak 2019-08-26  365  		return ret;
7733f6c32e36ff Pawel Laszczak 2019-08-26  366  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  367  
7733f6c32e36ff Pawel Laszczak 2019-08-26  368  	state = readl(&cdns->otg_regs->sts);
7733f6c32e36ff Pawel Laszczak 2019-08-26  369  	if (OTGSTS_OTG_NRDY(state) != 0) {
7733f6c32e36ff Pawel Laszczak 2019-08-26  370  		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
7733f6c32e36ff Pawel Laszczak 2019-08-26  371  		return -ENODEV;
7733f6c32e36ff Pawel Laszczak 2019-08-26  372  	}
7733f6c32e36ff Pawel Laszczak 2019-08-26  373  
7733f6c32e36ff Pawel Laszczak 2019-08-26  374  	return ret;
7733f6c32e36ff Pawel Laszczak 2019-08-26  375  }
7733f6c32e36ff Pawel Laszczak 2019-08-26  376  

:::::: The code at line 336 was first introduced by commit
:::::: 7733f6c32e36ff9d7adadf40001039bf219b1cbe usb: cdns3: Add Cadence USB3 DRD Driver

:::::: TO: Pawel Laszczak <pawell@cadence.com>
:::::: CC: Felipe Balbi <felipe.balbi@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1lPC5va/C901VTX41v7bwzf0jVi8PC9kKsXil7/eFkl+h2Kik9niz/sfo6f6/dP3l8UvD4vn
h4ffHn77PxiHB6uk48PTN+3z8ycmWXp8/v3FFSEjpXsLg70Xf95/fXz+Og8co1dnlm7tRG8a
imq7T3UDAjHPRmqu3qyUkVukBsKxVfrESKGnMGuc8L09uJJTnpz66f4NxuLPxeHpr4dFfv/j
4XXy+NeTXTAYp98ejGgnekJF1VVlfnXblV1SWs8ZkPTdne7RESO/cF++F1y7m3Vg92YAzjl6
QkBPQVTlFv/iLkpZ3uh1J+XG8yChGQN0W/sOaSrV3p88xfNCrH2pMwAXrl0xwbKTOnnTTPCz
5Ad7SHJ+qJQ+ilsDkrsjNIZ4Ta+bdO1EAk6v2pTPGeus15CsUvYqE/oix6bV93SD1bnZIw3v
ij1IeNCW0anIY0TTBzSGbTA5eyz2dKf8ol41DPSIs0gazA/n3xGqC2saUVHPuX0QeekoT/wo
uerl4l606tRwl/PwIKrNZA3oFehm+VD4Fz2ErY8hcHeF/8N42TqK01GC3gK/RHEQuaWOuNU6
oOxk9bhhbhWYGt47brklwLxU8o5TV5l6cpWb1gRPjbOrMF1Si5e73tE/cXbIOZTnqQkTMfS1
Taus/uPH98df4UyhJRW9+9RHSyyVQ1j3NuXi7KkJVdjunNgHU8WO58q9z58pFJH7CmacCzyt
tQs5MG/Me3WtyVj3ejsHqdbJi1A6vPD0SVHQifUKqUR6Z6fM62Hzh/4hZjJsjz/k2+Ov/6LS
rg3fnkrJ9rwDUXIq7Bzqsm4q0I6rlIr9XcgeNU6tWZlfpZ03XYl90RW+GEoD0Se9/5ZdtPVF
5RkIm3jnC180UnCmL4rpRx48taCmf1usWu/vk/QRsD6Rn3GHiZikQQFSomw+XnAtlgeejdsX
WlbNJkN/Npo9OfUwppZWJLEeWkZBGO+YSyyj9SpmboPSYh2ZCdhvUDNQqIZidLzIrU0Dwzlw
vbL8nyfwLqQ2vAkdmIF4NbRO2S6O5oUNcJ/VlKaxD699JXW0W63mTQMwGWljwMZx2xJn6wkb
Ut4rN2w0a0Ucr0OipG3seXcf8bT53G1E4nZW6gB/d6SQZh25Y9/b8oHGzJR5OdB/YZsJatiU
s9VXTZKF24Dot4riHeXj3h+tU4Z5bZ36VZ7Gu2XrrgkjIfccbEfsGRGYB/sdnozj/7h18HIf
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
QkPzf9GDWlvc2QEA

--IS0zKkzwUGydFO0o--
