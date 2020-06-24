Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA064C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACD5020768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406262AbgFXTyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:54:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:22955 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406135AbgFXTyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:54:51 -0400
IronPort-SDR: nUaKtj9tCsLHXHu47b5v+J2qHfq328paxd6gNGUkLz3/vlJ8pImjLWM1wOKRFWEIJ32QPElcj8
 wAMhnwk5T+Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="144665737"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="144665737"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 12:50:43 -0700
IronPort-SDR: ZB2BFGv80zSJVPgAQAp0pCgXuonm3fEmn+FfSvQdAaWvc7a1TmraWJyQMKKobrPgA47NMBHzNS
 EHfn3CWOyFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="319548725"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2020 12:50:41 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joBPs-000177-Eb; Wed, 24 Jun 2020 19:50:40 +0000
Date:   Thu, 25 Jun 2020 03:49:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202006250306.JK17fD8d%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 days ago
config: s390-randconfig-s032-20200624 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=s390 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *p
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
>> drivers/video/fbdev/vt8623fb.c:161:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:182:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/vt8623fb.c:217:25: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got unsigned char [noderef] [usertype] __iomem *dst @@
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     expected void *p
   drivers/video/fbdev/aty/mach64_cursor.c:156:23: sparse:     got unsigned char [noderef] [usertype] __iomem *dst
   drivers/video/fbdev/aty/mach64_cursor.c:187:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:188:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/aty/mach64_cursor.c:209:30: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:140:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:41: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] inst_cnt_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:38: sparse:     expected void [noderef] __iomem *[assigned] inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:450:38: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:49: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:543:49: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:31: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:57: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:551:57: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:51: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:553:51: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:51: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:558:51: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:51: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:561:51: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:603:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:602:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *doorbell_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:602:26: sparse:     expected void [noderef] __iomem *doorbell_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:602:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:605:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:604:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *inst_cnt_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:604:26: sparse:     expected void [noderef] __iomem *inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:604:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:647:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:646:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_sent_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:646:29: sparse:     expected void [noderef] __iomem *pkts_sent_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:646:29: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:649:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:648:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_credit_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:648:31: sparse:     expected void [noderef] __iomem *pkts_credit_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:648:31: sparse:     got unsigned char [usertype] *
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:688:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:688:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:688:42: sparse:     got void *mbox_int_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:689:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:689:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:689:42: sparse:     got void *mbox_int_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:694:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:694:54: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:694:54: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:737:39: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:741:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:745:40: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:755:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:755:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:755:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:990:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:990:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:990:42: sparse:     got void *mbox_int_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:997:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:997:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:997:44: sparse:     got void *mbox_int_reg
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: too many warnings
--
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:41: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *[assigned] inst_cnt_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:38: sparse:     expected void [noderef] __iomem *[assigned] inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:121:38: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:226:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:225:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *doorbell_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:225:26: sparse:     expected void [noderef] __iomem *doorbell_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:225:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:228:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:227:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *inst_cnt_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:227:26: sparse:     expected void [noderef] __iomem *inst_cnt_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:227:26: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:258:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:257:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_sent_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:257:29: sparse:     expected void [noderef] __iomem *pkts_sent_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:257:29: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:260:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:259:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *pkts_credit_reg @@     got unsigned char [usertype] * @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:259:31: sparse:     expected void [noderef] __iomem *pkts_credit_reg
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:259:31: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:298:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:301:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:304:14: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:313:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:313:36: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:313:36: sparse:     got void *mbox_read_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:479:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *mbox_int_reg @@
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:479:50: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:479:50: sparse:     got void *mbox_int_reg
>> drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:480:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_int_reg @@
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:480:50: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:480:50: sparse:     got void *mbox_int_reg
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
--
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:43:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:43:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:43:29: sparse:     got void *mbox_read_reg
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:81:52: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:81:52: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:115:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:115:36: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:115:36: sparse:     got void *mbox_read_reg
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:163:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:163:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:163:26: sparse:     got void *mbox_write_reg
>> drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:172:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:172:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:172:47: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:175:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:175:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:175:42: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:184:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_write_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:184:63: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:184:63: sparse:     got void *mbox_write_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:193:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:193:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:193:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:305:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:305:52: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:305:52: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:315:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:315:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:315:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:324:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:324:44: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:324:44: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:340:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:340:52: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:340:52: sparse:     got void *mbox_read_reg
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:370:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *mbox_read_reg @@
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:370:36: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:370:36: sparse:     got void *mbox_read_reg
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]

vim +1120 drivers/video/fbdev/tdfxfb.c

^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1040  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1041  static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1042  {
a807f618b62594 drivers/video/tdfxfb.c Antonino A. Daplas 2006-01-09  1043  	struct tdfx_par *par = info->par;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1044  	u32 vidcfg;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1045  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1046  	if (!hwcursor)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1047  		return -EINVAL;	/* just to force soft_cursor() call */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1048  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1049  	/* Too large of a cursor or wrong bpp :-( */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1050  	if (cursor->image.width > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1051  	    cursor->image.height > 64 ||
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1052  	    cursor->image.depth > 1)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1053  		return -EINVAL;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1054  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1055  	vidcfg = tdfx_inl(par, VIDPROCCFG);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1056  	if (cursor->enable)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1057  		tdfx_outl(par, VIDPROCCFG, vidcfg | VIDCFG_HWCURSOR_ENABLE);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1058  	else
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1059  		tdfx_outl(par, VIDPROCCFG, vidcfg & ~VIDCFG_HWCURSOR_ENABLE);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1060  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1061  	/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1062  	 * If the cursor is not be changed this means either we want the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1063  	 * current cursor state (if enable is set) or we want to query what
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1064  	 * we can do with the cursor (if enable is not set)
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1065  	 */
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1066  	if (!cursor->set)
8af1d50f7f6793 drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1067  		return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1068  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1069  	/* fix cursor color - XFree86 forgets to restore it properly */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1070  	if (cursor->set & FB_CUR_SETCMAP) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1071  		struct fb_cmap cmap = info->cmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1072  		u32 bg_idx = cursor->image.bg_color;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1073  		u32 fg_idx = cursor->image.fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1074  		unsigned long bg_color, fg_color;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1075  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1076  		fg_color = (((u32)cmap.red[fg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1077  			   (((u32)cmap.green[fg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1078  			   (((u32)cmap.blue[fg_idx]  & 0xff00) >> 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1079  		bg_color = (((u32)cmap.red[bg_idx]   & 0xff00) << 8) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1080  			   (((u32)cmap.green[bg_idx] & 0xff00) << 0) |
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1081  			   (((u32)cmap.blue[bg_idx]  & 0xff00) >> 8);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1082  		banshee_make_room(par, 2);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1083  		tdfx_outl(par, HWCURC0, bg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1084  		tdfx_outl(par, HWCURC1, fg_color);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1085  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1086  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1087  	if (cursor->set & FB_CUR_SETPOS) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1088  		int x = cursor->image.dx;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1089  		int y = cursor->image.dy - info->var.yoffset;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1090  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1091  		x += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1092  		y += 63;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1093  		banshee_make_room(par, 1);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1094  		tdfx_outl(par, HWCURLOC, (y << 16) + x);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1095  	}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1096  	if (cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1097  		/*
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1098  		 * Voodoo 3 and above cards use 2 monochrome cursor patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1099  		 *    The reason is so the card can fetch 8 words at a time
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1100  		 * and are stored on chip for use for the next 8 scanlines.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1101  		 * This reduces the number of times for access to draw the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1102  		 * cursor for each screen refresh.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1103  		 *    Each pattern is a bitmap of 64 bit wide and 64 bit high
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1104  		 * (total of 8192 bits or 1024 bytes). The two patterns are
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1105  		 * stored in such a way that pattern 0 always resides in the
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1106  		 * lower half (least significant 64 bits) of a 128 bit word
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1107  		 * and pattern 1 the upper half. If you examine the data of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1108  		 * the cursor image the graphics card uses then from the
25985edcedea63 drivers/video/tdfxfb.c Lucas De Marchi    2011-03-30  1109  		 * beginning you see line one of pattern 0, line one of
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1110  		 * pattern 1, line two of pattern 0, line two of pattern 1,
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1111  		 * etc etc. The linear stride for the cursor is always 16 bytes
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1112  		 * (128 bits) which is the maximum cursor width times two for
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1113  		 * the two monochrome patterns.
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1114  		 */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1115  		u8 __iomem *cursorbase = info->screen_base + info->fix.smem_len;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1116  		u8 *bitmap = (u8 *)cursor->image.data;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1117  		u8 *mask = (u8 *)cursor->mask;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1118  		int i;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1119  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16 @1120  		fb_memset(cursorbase, 0, 1024);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1121  
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1122  		for (i = 0; i < cursor->image.height; i++) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1123  			int h = 0;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1124  			int j = (cursor->image.width + 7) >> 3;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1125  
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1126  			for (; j > 0; j--) {
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1127  				u8 data = *mask ^ *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1128  				if (cursor->rop == ROP_COPY)
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1129  					data = *mask & *bitmap;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1130  				/* Pattern 0. Copy the cursor mask to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1131  				fb_writeb(*mask, cursorbase + h);
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1132  				mask++;
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1133  				/* Pattern 1. Copy the cursor bitmap to it */
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1134  				fb_writeb(data, cursorbase + h + 8);
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1135  				bitmap++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1136  				h++;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1137  			}
90b0f08536531a drivers/video/tdfxfb.c Krzysztof Helt     2007-10-16  1138  			cursorbase += 16;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1139  		}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1140  	}
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1141  	return 0;
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1142  }
^1da177e4c3f41 drivers/video/tdfxfb.c Linus Torvalds     2005-04-16  1143  

:::::: The code at line 1120 was first introduced by commit
:::::: 90b0f08536531abbbe7b5d4944792da08cadde01 tdfxfb: hardware cursor

:::::: TO: Krzysztof Helt <krzysztof.h1@wp.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Er0TIhDprAWwSDNRhgtf6fwHaTvp8JX1AQA=

--ZGiS0Q5IWpPtfppv--
