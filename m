Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FDFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32452206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405606AbgFXRa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:30:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:7662 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404908AbgFXRa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:30:58 -0400
IronPort-SDR: RnfvnAiL7XhiSCobS57Kv+NyU6A6re7rFBusDm8Lv4cvPjw03mYP/Gr/ffK9/mHNUZ8amHejx3
 5BEKhh+XGqmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143655509"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="143655509"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 10:04:19 -0700
IronPort-SDR: ziFVytsiQNZ4ki/i9VnKLeqQlFfqrFussYAd3mKmVT3slR25NEapvobWf5BRRIlbUv0No1I/Yc
 S2OfYqUy09GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="311710487"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2020 10:04:17 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jo8oq-00012o-Hy; Wed, 24 Jun 2020 17:04:16 +0000
Date:   Thu, 25 Jun 2020 01:04:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/char/pcmcia/synclink_cs.c:340:17: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202006250152.oS2V8l1H%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 days ago
config: riscv-randconfig-s031-20200624 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=riscv CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/char/pcmcia/synclink_cs.c:340:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/synclink_cs.c:340:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/synclink_cs.c:340:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:340:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3069:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3069:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3069:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/rtc/rtc-bq4802.c:32:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-bq4802.c:32:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/rtc/rtc-bq4802.c:32:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/rtc/rtc-bq4802.c:32:16: sparse:     got void *
   drivers/rtc/rtc-bq4802.c:37:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-bq4802.c:37:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/rtc/rtc-bq4802.c:37:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/rtc/rtc-bq4802.c:37:9: sparse:     got void *

vim +/__iomem +340 drivers/char/pcmcia/synclink_cs.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  326  
^1da177e4c3f41 Linus Torvalds 2005-04-16  327  #define set_reg_bits(info, reg, mask) \
^1da177e4c3f41 Linus Torvalds 2005-04-16  328  	write_reg(info, (reg), \
^1da177e4c3f41 Linus Torvalds 2005-04-16  329  		 (unsigned char) (read_reg(info, (reg)) | (mask)))
^1da177e4c3f41 Linus Torvalds 2005-04-16  330  #define clear_reg_bits(info, reg, mask) \
^1da177e4c3f41 Linus Torvalds 2005-04-16  331  	write_reg(info, (reg), \
^1da177e4c3f41 Linus Torvalds 2005-04-16  332  		 (unsigned char) (read_reg(info, (reg)) & ~(mask)))
^1da177e4c3f41 Linus Torvalds 2005-04-16  333  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  334   * interrupt enable/disable routines
^1da177e4c3f41 Linus Torvalds 2005-04-16  335   */
^1da177e4c3f41 Linus Torvalds 2005-04-16  336  static void irq_disable(MGSLPC_INFO *info, unsigned char channel, unsigned short mask)
^1da177e4c3f41 Linus Torvalds 2005-04-16  337  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  338  	if (channel == CHA) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  339  		info->imra_value |= mask;
^1da177e4c3f41 Linus Torvalds 2005-04-16 @340  		write_reg16(info, CHA + IMR, info->imra_value);
^1da177e4c3f41 Linus Torvalds 2005-04-16  341  	} else {
^1da177e4c3f41 Linus Torvalds 2005-04-16  342  		info->imrb_value |= mask;
^1da177e4c3f41 Linus Torvalds 2005-04-16  343  		write_reg16(info, CHB + IMR, info->imrb_value);
^1da177e4c3f41 Linus Torvalds 2005-04-16  344  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  345  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  346  static void irq_enable(MGSLPC_INFO *info, unsigned char channel, unsigned short mask)
^1da177e4c3f41 Linus Torvalds 2005-04-16  347  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  348  	if (channel == CHA) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  349  		info->imra_value &= ~mask;
^1da177e4c3f41 Linus Torvalds 2005-04-16  350  		write_reg16(info, CHA + IMR, info->imra_value);
^1da177e4c3f41 Linus Torvalds 2005-04-16  351  	} else {
^1da177e4c3f41 Linus Torvalds 2005-04-16  352  		info->imrb_value &= ~mask;
^1da177e4c3f41 Linus Torvalds 2005-04-16  353  		write_reg16(info, CHB + IMR, info->imrb_value);
^1da177e4c3f41 Linus Torvalds 2005-04-16  354  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  355  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  356  

:::::: The code at line 340 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ReaqsoxgOBHFXBhH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
aZIbx9V/pU4vZg4vRvty6IO2VMqlrSRlptIXhcdT3XaM23a4p+eN//0DSC1cwKw5uFyFD6S4
EwBJAM+96eP7jaXJescdLfoJzMY0QkOT1qadYbZ9S6kmo0/NiSDzyxiip/QN4efpVF26rKg7
SnU8Ms2lfWqjZ6MX1q6vf4sBsVAIHNkw3jQCC4WOzviXumpA0fHtPax2d9r2CiVJNbys/nyk
3lQ3FiY5ajGcRfCIzCZS2Tsh61CNX3//9uPn0+8fvn8H8ZnNUO2wi6ULvXnmQVV+l+jqJs+1
53XTlqn5Leml8JGMisdMpiqcJvzPsi2t5vvoN4u0nG/QW3k517dcy5H5ernSoi5vuTQKxpDa
7HhfJE3i5w4Mki69aLXk260xbdXNSmNB12aijYgRVx8EauawnS4nVV/cFHdzB++aFaO+/uc7
LJd6x6+PDpUmXKlycJQVaXul2CUGY8vJgWhplWF0g6NFfuiOphDSQ9UK430ZtTmnvsqcaB1I
gqStVJ3PiVP+RpMM1fuuVQd9moeW70QaNfZDu7ldFTrX5hRi3bux52rEKHRnpfWQ6Ac+0Xq4
lpnaZl8+1WR89TQOT7z7qBSA31aMAq2d+ZUqbXoxILZpswTneGnmiAq5wFF+20r53K2JXJ8g
xrEn9jTRo3tcOq2n5VKlU2SQvdfRVi0YqG0xPBjdmArO5RjudLCbWXnmOqrrGyHkHVUBlIYf
DlVYtu3A03qDHRPHpFdfYXLaSsM2metGkbLvwYI3dqInf75SDfgGxNU/zMJdkXUk6iLPurIc
ihKv86krCchaF2HDvNnb7mb/7/99Xu0Bh6qwF+hmr8oue6jbkS4cdpZ8dDwxPoqI2DdJMTog
w0vCg2EsK1E+JMor1mP88uHfr2oVVr0E/V7Qn1rVE9ThfydSYsUs/1FSxhGZE0fooyI3Rs+T
mG3anCpnSC0CEofjSh2xA5Hl04DnWsbykx6zZA7D5wBYMtE1swxGdCpffuYiQmFE+oiROGxD
1Ys1tgyJ2SE55eRxJYjOLIpuciXj9zIMg54JJ3ICcdMqSEwWxlQEf52U2w8iTz1lTkxGLxK5
jkwIcBWrHmDHsfJxd7LA8ywMwiLaBDg3iWF8rIaG9gDFfX3X68npunq+MeUJZ9TVwCTPljSZ
YFGRrhvwDZInImcei+GowSuIBoUSRwJIe1YgjLz1S0uSTVHs+YmOsIvnBPnmWLYktmwIDm6D
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

--ReaqsoxgOBHFXBhH--
