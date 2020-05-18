Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691E12065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgERNXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:23:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:32690 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgERNXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:23:45 -0400
IronPort-SDR: qJ22+0+kssq1mdCqXK8+vEXpSr1DRqfJlRAJO9D9RVNnz02mK0v3+0KZKeMDKrgYzbH00UUpDE
 y3TZ4HHfTTew==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 06:23:24 -0700
IronPort-SDR: /O1IIaj23lbRV7SIcAwiOMBfPofd/ZGOHtWaql49uKrf9apcYV+Vdy71DgY9+i7eJzr2MJbXu+
 0z5NBm54SG3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="gz'50?scan'50,208,50";a="288570811"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 06:23:22 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jafjl-000DRP-8F; Mon, 18 May 2020 21:23:21 +0800
Date:   Mon, 18 May 2020 21:22:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: drivers/usb/cdns3/drd.c:332:17: sparse: sparse: too many warnings
Message-ID: <202005182134.F6Wme8zd%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
commit: 70d8b9e5e63d212019ba3f6823c8ec3d2df87645 usb: cdns3: make signed 1 bit bitfields unsigned
date:   8 weeks ago
config: arc-randconfig-s001-20200518 (attached as .config)
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        git checkout 70d8b9e5e63d212019ba3f6823c8ec3d2df87645
        # save the attached .config to linux build tree
        make C=1 ARCH=arc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/cdns3/drd.c:182:23: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:182:23: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:182:23: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:195:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:195:17: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:195:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:199:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:199:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:199:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:219:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:219:9: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:219:9: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:284:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:284:15: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:284:15: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:303:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:303:9: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:303:9: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:326:27: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct cdns3_otg_legacy_regs *otg_v0_regs @@    got void struct cdns3_otg_legacy_regs *otg_v0_regs @@
   drivers/usb/cdns3/drd.c:326:27: sparse:    expected struct cdns3_otg_legacy_regs *otg_v0_regs
   drivers/usb/cdns3/drd.c:326:27: sparse:    got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:327:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:327:14: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:327:14: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:330:32: sparse: sparse: incorrect type in assignment (different address spaces) @@    expected struct cdns3_otg_common_regs *otg_regs @@    got void struct cdns3_otg_common_regs *otg_regs @@
   drivers/usb/cdns3/drd.c:330:32: sparse:    expected struct cdns3_otg_common_regs *otg_regs
   drivers/usb/cdns3/drd.c:330:32: sparse:    got void [noderef] <asn:2> *[assigned] regs
   drivers/usb/cdns3/drd.c:331:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected void volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:331:17: sparse:    expected void volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:331:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:332:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:332:17: sparse:    got restricted __le32 *
   drivers/usb/cdns3/drd.c:332:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:2> *addr @@    got [noderef] <asn:2> *addr @@
   drivers/usb/cdns3/drd.c:332:17: sparse:    expected void const volatile [noderef] <asn:2> *addr
   drivers/usb/cdns3/drd.c:332:17: sparse:    got restricted __le32 *
>> drivers/usb/cdns3/drd.c:332:17: sparse: sparse: too many warnings

vim +332 drivers/usb/cdns3/drd.c

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
7733f6c32e36ff Pawel Laszczak 2019-08-26 @332  		dev_info(cdns->dev, "DRD version v0 (%08x)\n",
7733f6c32e36ff Pawel Laszczak 2019-08-26  333  			 readl(&cdns->otg_v0_regs->version));
7733f6c32e36ff Pawel Laszczak 2019-08-26  334  	} else {
7733f6c32e36ff Pawel Laszczak 2019-08-26  335  		cdns->otg_v0_regs = NULL;
7733f6c32e36ff Pawel Laszczak 2019-08-26  336  		cdns->otg_v1_regs = regs;
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

:::::: The code at line 332 was first introduced by commit
:::::: 7733f6c32e36ff9d7adadf40001039bf219b1cbe usb: cdns3: Add Cadence USB3 DRD Driver

:::::: TO: Pawel Laszczak <pawell@cadence.com>
:::::: CC: Felipe Balbi <felipe.balbi@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--azLHFNyN32YCQGCU--
