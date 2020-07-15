Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE24C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342082063A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgGOLVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:21:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:34310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgGOLVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:21:00 -0400
IronPort-SDR: Yok4xWuh3HjB1nCxGjFsuucA+y510YauuLt/hFWaxCp/YcnKD45BF1NrgD0Av11AS9DyuEfb/V
 EKLDC6qEVdzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="137252545"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="gz'50?scan'50,208,50";a="137252545"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 04:20:56 -0700
IronPort-SDR: nX5ZwV4avx0X1bAy7uufI110uHx/dRsnbsw+lReXfBYroZGM3qjjZR1PrLsVtHWOBgMaKYY7RY
 mq45kyafi48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="gz'50?scan'50,208,50";a="485697363"
Received: from lkp-server01.sh.intel.com (HELO b157d87b7ee7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2020 04:20:54 -0700
Received: from kbuild by b157d87b7ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvfT4-0000BU-2h; Wed, 15 Jul 2020 11:20:54 +0000
Date:   Wed, 15 Jul 2020 19:20:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/usb/gadget/udc/mv_udc_core.c:833:34: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202007151928.6KOEl0s8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e9919e11e219eaa5e8041b7b1a196839143e9125
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: mips-randconfig-s032-20200715 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/usb/gadget/udc/mv_udc_core.c:67:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/mv_udc_core.c:67:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/mv_udc_core.c:67:33: sparse:     got int
   drivers/usb/gadget/udc/mv_udc_core.c:367:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr0 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:367:24: sparse:     expected unsigned int [usertype] buff_ptr0
   drivers/usb/gadget/udc/mv_udc_core.c:367:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr1 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     expected unsigned int [usertype] buff_ptr1
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr2 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     expected unsigned int [usertype] buff_ptr2
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr3 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     expected unsigned int [usertype] buff_ptr3
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:372:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr4 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:372:24: sparse:     expected unsigned int [usertype] buff_ptr4
   drivers/usb/gadget/udc/mv_udc_core.c:372:24: sparse:     got restricted __le32 [usertype]
>> drivers/usb/gadget/udc/mv_udc_core.c:833:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
>> drivers/usb/gadget/udc/mv_udc_core.c:833:34: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/usb/gadget/udc/mv_udc_core.c:833:34: sparse:     got unsigned int *
>> drivers/usb/gadget/udc/mv_udc_core.c:834:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
>> drivers/usb/gadget/udc/mv_udc_core.c:834:42: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/usb/gadget/udc/mv_udc_core.c:834:42: sparse:     got unsigned int *
   drivers/usb/gadget/udc/mv_udc_core.c:1456:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:1456:41: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1456:41: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1516:26: sparse: sparse: cast from restricted __le16
   drivers/usb/gadget/udc/mv_udc_core.c:1546:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1547:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1568:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1579:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1580:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1616:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1625:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1611:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1611:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1634:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1635:43: sparse: sparse: restricted __le16 degrades to integer
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: too many warnings
--
>> drivers/watchdog/sb_wdog.c:269:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got char *wd_cfg_reg @@
>> drivers/watchdog/sb_wdog.c:269:27: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/watchdog/sb_wdog.c:269:27: sparse:     got char *wd_cfg_reg
>> drivers/watchdog/sb_wdog.c:270:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got char * @@
   drivers/watchdog/sb_wdog.c:270:42: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/watchdog/sb_wdog.c:270:42: sparse:     got char *
   drivers/watchdog/sb_wdog.c:275:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/watchdog/sb_wdog.c:275:24: sparse:    char *
>> drivers/watchdog/sb_wdog.c:275:24: sparse:    char [noderef] __iomem *
>> drivers/watchdog/sb_wdog.c:307:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/sb_wdog.c:321:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/sb_wdog.c:331:22: sparse: sparse: cast removes address space '__iomem' of expression

vim +833 drivers/usb/gadget/udc/mv_udc_core.c

c2bbd16b03d036 drivers/usb/gadget/mv_udc_core.c Neil Zhang 2011-12-20  770  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  771  /* dequeues (cancels, unlinks) an I/O request from an endpoint */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  772  static int mv_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  773  {
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  774  	struct mv_ep *ep = container_of(_ep, struct mv_ep, ep);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  775  	struct mv_req *req;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  776  	struct mv_udc *udc = ep->udc;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  777  	unsigned long flags;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  778  	int stopped, ret = 0;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  779  	u32 epctrlx;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  780  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  781  	if (!_ep || !_req)
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  782  		return -EINVAL;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  783  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  784  	spin_lock_irqsave(&ep->udc->lock, flags);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  785  	stopped = ep->stopped;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  786  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  787  	/* Stop the ep before we deal with the queue */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  788  	ep->stopped = 1;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  789  	epctrlx = readl(&udc->op_regs->epctrlx[ep->ep_num]);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  790  	if (ep_dir(ep) == EP_DIR_IN)
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  791  		epctrlx &= ~EPCTRL_TX_ENABLE;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  792  	else
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  793  		epctrlx &= ~EPCTRL_RX_ENABLE;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  794  	writel(epctrlx, &udc->op_regs->epctrlx[ep->ep_num]);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  795  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  796  	/* make sure it's actually queued on this endpoint */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  797  	list_for_each_entry(req, &ep->queue, queue) {
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  798  		if (&req->req == _req)
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  799  			break;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  800  	}
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  801  	if (&req->req != _req) {
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  802  		ret = -EINVAL;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  803  		goto out;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  804  	}
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  805  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  806  	/* The request is in progress, or completed but not dequeued */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  807  	if (ep->queue.next == &req->queue) {
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  808  		_req->status = -ECONNRESET;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  809  		mv_ep_fifo_flush(_ep);	/* flush current transfer */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  810  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  811  		/* The request isn't the last request in this ep queue */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  812  		if (req->queue.next != &ep->queue) {
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  813  			struct mv_req *next_req;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  814  
c2bbd16b03d036 drivers/usb/gadget/mv_udc_core.c Neil Zhang 2011-12-20  815  			next_req = list_entry(req->queue.next,
c2bbd16b03d036 drivers/usb/gadget/mv_udc_core.c Neil Zhang 2011-12-20  816  				struct mv_req, queue);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  817  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  818  			/* Point the QH to the first TD of next request */
c2bbd16b03d036 drivers/usb/gadget/mv_udc_core.c Neil Zhang 2011-12-20  819  			mv_prime_ep(ep, next_req);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  820  		} else {
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  821  			struct mv_dqh *qh;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  822  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  823  			qh = ep->dqh;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  824  			qh->next_dtd_ptr = 1;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  825  			qh->size_ioc_int_sts = 0;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  826  		}
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  827  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  828  		/* The request hasn't been processed, patch up the TD chain */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  829  	} else {
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  830  		struct mv_req *prev_req;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  831  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  832  		prev_req = list_entry(req->queue.prev, struct mv_req, queue);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30 @833  		writel(readl(&req->tail->dtd_next),
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30 @834  				&prev_req->tail->dtd_next);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  835  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  836  	}
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  837  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  838  	done(ep, req, -ECONNRESET);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  839  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  840  	/* Enable EP */
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  841  out:
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  842  	epctrlx = readl(&udc->op_regs->epctrlx[ep->ep_num]);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  843  	if (ep_dir(ep) == EP_DIR_IN)
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  844  		epctrlx |= EPCTRL_TX_ENABLE;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  845  	else
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  846  		epctrlx |= EPCTRL_RX_ENABLE;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  847  	writel(epctrlx, &udc->op_regs->epctrlx[ep->ep_num]);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  848  	ep->stopped = stopped;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  849  
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  850  	spin_unlock_irqrestore(&ep->udc->lock, flags);
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  851  	return ret;
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  852  }
e7cddda48c7f89 drivers/usb/gadget/mv_udc_core.c cxie4      2010-11-30  853  

:::::: The code at line 833 was first introduced by commit
:::::: e7cddda48c7f892a3fb5c10a6f41a4395f46c0c2 USB: pxa: Add USB client support for Marvell PXA9xx/PXA168 chips

:::::: TO: cxie4 <cxie4@marvell.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--yrj/dFKFPuw6o+aM--
