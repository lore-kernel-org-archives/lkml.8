Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D4720709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 05:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389768AbgFYFLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 01:11:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:7724 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgFYFLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 01:11:34 -0400
IronPort-SDR: y3zwHLPG/keUE/P2XPNfEn9Q4gByfKiUI8HCtxKtjvKuaNh0WGEhtKZxyjNkki2hv17Wn22ivM
 nvhSJGmHVILw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143847431"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="gz'50?scan'50,208,50";a="143847431"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 22:09:32 -0700
IronPort-SDR: gXnnQvtM57kDcO0TOp/c0guP4kL4VvATzbRHumydacQwa569761U09vuRV3k+XOiH513OnFCBo
 TBpVnctF7nyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="gz'50?scan'50,208,50";a="295279932"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2020 22:09:30 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joK8f-0001OI-9f; Thu, 25 Jun 2020 05:09:29 +0000
Date:   Thu, 25 Jun 2020 13:08:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/ethoc.c:450:67: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
Message-ID: <202006251335.R2k1u34s%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e08a95294a4fb3702bb3d35ed08028433c37fe6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 days ago
config: powerpc64-randconfig-s031-20200624 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=powerpc64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/ethoc.c:313:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *vma @@     got void [noderef] __iomem *membase @@
   drivers/net/ethernet/ethoc.c:313:13: sparse:     expected void *vma
   drivers/net/ethernet/ethoc.c:313:13: sparse:     got void [noderef] __iomem *membase
>> drivers/net/ethernet/ethoc.c:450:67: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void *src @@
>> drivers/net/ethernet/ethoc.c:450:67: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/net/ethernet/ethoc.c:450:67: sparse:     got void *src
>> drivers/net/ethernet/ethoc.c:908:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *[assigned] dest @@
>> drivers/net/ethernet/ethoc.c:908:21: sparse:     expected void volatile [noderef] __iomem *d
   drivers/net/ethernet/ethoc.c:908:21: sparse:     got void *[assigned] dest
   drivers/net/ethernet/ethoc.c:1108:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *membase @@     got void * @@
   drivers/net/ethernet/ethoc.c:1108:31: sparse:     expected void [noderef] __iomem *membase
   drivers/net/ethernet/ethoc.c:1108:31: sparse:     got void *
--
>> drivers/atm/horizon.c:1135:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[usertype] tx_addr @@     got void [noderef] __user *iov_base @@
   drivers/atm/horizon.c:1135:22: sparse:     expected void *[usertype] tx_addr
>> drivers/atm/horizon.c:1135:22: sparse:     got void [noderef] __user *iov_base
   drivers/atm/horizon.c:1173:49: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] @@
   drivers/atm/horizon.c:1173:49: sparse:     expected unsigned int [usertype] data
   drivers/atm/horizon.c:1173:49: sparse:     got restricted __be32 [usertype]
   drivers/atm/horizon.c:1177:48: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] @@
   drivers/atm/horizon.c:1177:48: sparse:     expected unsigned int [usertype] data
   drivers/atm/horizon.c:1177:48: sparse:     got restricted __be32 [usertype]
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:369:10: sparse: sparse: cast to restricted __le16
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] val
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] val
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] val
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] val
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:361:10: sparse: sparse: cast to restricted __le32
   drivers/atm/horizon.c:365:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [usertype] @@
   drivers/atm/horizon.c:365:9: sparse:     expected unsigned short [usertype] val
   drivers/atm/horizon.c:365:9: sparse:     got restricted __le16 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
   drivers/atm/horizon.c:357:9: sparse:     got restricted __le32 [usertype]
   drivers/atm/horizon.c:357:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   drivers/atm/horizon.c:357:9: sparse:     expected unsigned int [usertype] val
--
   arch/powerpc/platforms/4xx/pci.c:115:54: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/4xx/pci.c:115:54: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/4xx/pci.c:115:54: sparse:     got unsigned int const [usertype] *
   arch/powerpc/platforms/4xx/pci.c:116:74: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] *in_addr @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/4xx/pci.c:116:74: sparse:     expected restricted __be32 const [usertype] *in_addr
   arch/powerpc/platforms/4xx/pci.c:116:74: sparse:     got unsigned int const [usertype] *
   arch/powerpc/platforms/4xx/pci.c:117:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *cell @@     got unsigned int const [usertype] * @@
   arch/powerpc/platforms/4xx/pci.c:117:52: sparse:     expected restricted __be32 const [usertype] *cell
   arch/powerpc/platforms/4xx/pci.c:117:52: sparse:     got unsigned int const [usertype] *
>> arch/powerpc/platforms/4xx/pci.c:1630:30: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/4xx/pci.c:1630:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char const volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/4xx/pci.c:1630:30: sparse:     expected unsigned char const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1630:30: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1633:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/4xx/pci.c:1633:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
>> arch/powerpc/platforms/4xx/pci.c:1633:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1633:33: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1636:33: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/4xx/pci.c:1636:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
>> arch/powerpc/platforms/4xx/pci.c:1636:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1636:33: sparse:     got unsigned int [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1687:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/4xx/pci.c:1687:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned char volatile [noderef] [usertype] __iomem *addr @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/4xx/pci.c:1687:24: sparse:     expected unsigned char volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1687:24: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1690:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/4xx/pci.c:1690:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
>> arch/powerpc/platforms/4xx/pci.c:1690:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1690:27: sparse:     got unsigned short [usertype] *
   arch/powerpc/platforms/4xx/pci.c:1693:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/4xx/pci.c:1693:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
>> arch/powerpc/platforms/4xx/pci.c:1693:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/pci.c:1693:27: sparse:     got unsigned int [usertype] *
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:143:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:148:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
--
>> arch/powerpc/platforms/4xx/gpio.c:63:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/4xx/gpio.c:63:28: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/4xx/gpio.c:63:28: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/4xx/gpio.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
--
>> drivers/video/fbdev/chipsfb.c:334:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     expected void *
   drivers/video/fbdev/chipsfb.c:334:17: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/chipsfb.c:334:15: sparse: sparse: memset with byte count of 1048576
--
>> drivers/net/wireless/intersil/prism54/isl_ioctl.c:2054:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *pointer @@     got char *[assigned] memptr @@
>> drivers/net/wireless/intersil/prism54/isl_ioctl.c:2054:27: sparse:     expected void [noderef] __user *pointer
   drivers/net/wireless/intersil/prism54/isl_ioctl.c:2054:27: sparse:     got char *[assigned] memptr
   drivers/net/wireless/intersil/prism54/isl_ioctl.c:2073:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *pointer @@     got char *[assigned] memptr @@
   drivers/net/wireless/intersil/prism54/isl_ioctl.c:2073:27: sparse:     expected void [noderef] __user *pointer
   drivers/net/wireless/intersil/prism54/isl_ioctl.c:2073:27: sparse:     got char *[assigned] memptr
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     got unsigned int ( * )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected unsigned int [noderef] __user *__gu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected unsigned int [noderef] __user *__gu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected unsigned int [noderef] __user *__gu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     expected unsigned int [noderef] __user *__gu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int [noderef] __user *__pu_addr @@     got signed int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse:     expected signed int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse:     got signed int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse:     expected unsigned int [noderef] __user *__pu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse:     expected unsigned int [noderef] __user *__gu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse:     got unsigned int [usertype] *
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:210:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:210:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:210:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:210:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:210:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:210:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:215:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:215:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:215:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:215:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:215:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:215:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:216:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:216:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:216:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:216:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:216:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:216:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:241:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:241:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:241:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:241:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:241:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:241:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:242:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:242:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:242:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:242:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:242:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:242:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:243:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:243:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:243:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:243:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:243:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:243:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:249:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:249:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:249:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:249:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:249:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:249:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:255:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:255:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:255:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:255:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:255:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:255:28: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:384:67: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:384:67: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:384:67: sparse:     got void *[assigned] ptr
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:409:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:409:37: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:409:37: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:418:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:418:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:418:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:418:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:418:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:418:42: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:419:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *cpu_addr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:419:62: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:419:62: sparse:     got void *cpu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:420:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:420:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:420:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:420:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:420:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:420:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:421:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:421:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:421:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:421:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:421:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:421:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:422:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:422:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:422:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:422:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:422:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:422:40: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:424:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:424:35: sparse:     expected void volatile [noderef] __iomem *a
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:424:35: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:683:35: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:683:35: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:683:35: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:683:35: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:683:35: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:683:35: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1151:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1151:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1151:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1152:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1152:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1152:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1153:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1153:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1153:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1154:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1154:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1154:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1155:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1155:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1155:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1156:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1156:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1156:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1157:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1157:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1157:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1158:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1158:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1158:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1159:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1159:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1159:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1160:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1160:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1160:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1161:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1161:17: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1161:17: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1163:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1163:24: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1163:24: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1183:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1183:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1183:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1184:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1184:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1184:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1185:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1185:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1185:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1186:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1186:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1186:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1188:24: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1188:24: sparse:     got restricted __le32 [usertype]
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:177:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:177:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:177:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:177:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:177:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:177:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:314:18: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:314:18: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:314:18: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:314:18: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:314:18: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:314:18: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:315:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *[addressable] cpu_addr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:315:21: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:315:21: sparse:     got void *[addressable] cpu_addr
--
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:567:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void *ptr @@
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:567:51: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:567:51: sparse:     got void *ptr
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:589:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *ptr @@
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:589:29: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:589:29: sparse:     got void *ptr
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:1044:27: sparse: sparse: symbol 'vce_v4_0_ip_funcs' was not declared. Should it be static?
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:131:32: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:131:32: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:131:32: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:131:32: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:131:32: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:131:32: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:139:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:139:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:139:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:139:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:139:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:139:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:143:26: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:143:26: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:143:26: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:143:26: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:143:26: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:143:26: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:144:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:144:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:144:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:144:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:144:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:144:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:146:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:146:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:146:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:146:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:146:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:146:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:147:24: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:147:24: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:147:24: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:147:24: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:147:24: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:147:24: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:153:29: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:153:29: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:153:29: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:153:29: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:153:29: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:153:29: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:154:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:154:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:154:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:154:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:154:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:154:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:155:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:155:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:155:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:155:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:155:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:155:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:162:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:162:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:162:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:162:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:162:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:162:28: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:260:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:260:59: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:260:59: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:271:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:271:63: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:271:63: sparse:     got void *[assigned] ptr
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:292:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:292:37: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:292:37: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:301:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:301:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:301:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:301:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:301:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:301:42: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:302:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *cpu_addr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:302:62: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:302:62: sparse:     got void *cpu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:303:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:303:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:303:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:303:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:303:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:303:45: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:304:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:304:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:304:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:304:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:304:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:304:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:305:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:305:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:305:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:305:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:305:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:305:40: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:307:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:307:35: sparse:     expected void volatile [noderef] __iomem *a
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:307:35: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:317:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:317:37: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:317:37: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:319:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *a @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:319:35: sparse:     expected void volatile [noderef] __iomem *a
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:319:35: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:503:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:503:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:503:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:504:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:504:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:504:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:505:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:505:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:505:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:506:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:506:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:506:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:507:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:507:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:507:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:508:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:508:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:508:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:509:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:509:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:509:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:510:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:510:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:510:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:511:16: sparse: sparse: too many warnings
--
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:65:25: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:74:26: sparse: sparse: cast to restricted __be32
>> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:408:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *kaddr @@
>> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:408:44: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:408:44: sparse:     got void *kaddr
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:819:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1094:5: sparse: sparse: symbol 'amdgpu_ttm_gart_bind' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected unsigned int [noderef] __user *__gu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-mem.c:188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] *periodic @@     got restricted __le32 [usertype] * @@
   drivers/usb/host/ehci-mem.c:188:24: sparse:     expected restricted __hc32 [usertype] *periodic
   drivers/usb/host/ehci-mem.c:188:24: sparse:     got restricted __le32 [usertype] *
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __hc32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __hc32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
>> drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __hc32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __hc32 [usertype] *ohci_hcctrl_reg
>> drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:144:1: sparse: sparse: dereference of noderef expression
   arch/powerpc/include/asm/io.h:149:1: sparse: sparse: too many warnings

vim +450 drivers/net/ethernet/ethoc.c

a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  415  
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  416  static int ethoc_rx(struct net_device *dev, int limit)
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  417  {
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  418  	struct ethoc *priv = netdev_priv(dev);
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  419  	int count;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  420  
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  421  	for (count = 0; count < limit; ++count) {
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  422  		unsigned int entry;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  423  		struct ethoc_bd bd;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  424  
6a632625c7da75 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  425  		entry = priv->num_tx + priv->cur_rx;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  426  		ethoc_read_bd(priv, entry, &bd);
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  427  		if (bd.stat & RX_BD_EMPTY) {
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  428  			ethoc_ack_irq(priv, INT_MASK_RX);
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  429  			/* If packet (interrupt) came in between checking
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  430  			 * BD_EMTPY and clearing the interrupt source, then we
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  431  			 * risk missing the packet as the RX interrupt won't
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  432  			 * trigger right away when we reenable it; hence, check
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  433  			 * BD_EMTPY here again to make sure there isn't such a
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  434  			 * packet waiting for us...
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  435  			 */
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  436  			ethoc_read_bd(priv, entry, &bd);
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  437  			if (bd.stat & RX_BD_EMPTY)
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  438  				break;
20f70ddd6558a3 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  439  		}
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  440  
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  441  		if (ethoc_update_rx_stats(priv, &bd) == 0) {
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  442  			int size = bd.stat >> 16;
89d71a66c40d62 drivers/net/ethoc.c          Eric Dumazet    2009-10-13  443  			struct sk_buff *skb;
050f91dcd9a45a drivers/net/ethoc.c          Thomas Chou     2009-10-04  444  
050f91dcd9a45a drivers/net/ethoc.c          Thomas Chou     2009-10-04  445  			size -= 4; /* strip the CRC */
89d71a66c40d62 drivers/net/ethoc.c          Eric Dumazet    2009-10-13  446  			skb = netdev_alloc_skb_ip_align(dev, size);
050f91dcd9a45a drivers/net/ethoc.c          Thomas Chou     2009-10-04  447  
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  448  			if (likely(skb)) {
f8555ad0cfb0ba drivers/net/ethoc.c          Jonas Bonn      2010-06-11  449  				void *src = priv->vma[entry];
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27 @450  				memcpy_fromio(skb_put(skb, size), src, size);
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  451  				skb->protocol = eth_type_trans(skb, dev);
57616ee4405b82 drivers/net/ethoc.c          Kulikov Vasiliy 2010-07-05  452  				dev->stats.rx_packets++;
57616ee4405b82 drivers/net/ethoc.c          Kulikov Vasiliy 2010-07-05  453  				dev->stats.rx_bytes += size;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  454  				netif_receive_skb(skb);
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  455  			} else {
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  456  				if (net_ratelimit())
72aa8e1b29ecae drivers/net/ethernet/ethoc.c Barry Grussling 2013-01-27  457  					dev_warn(&dev->dev,
72aa8e1b29ecae drivers/net/ethernet/ethoc.c Barry Grussling 2013-01-27  458  					    "low on memory - packet dropped\n");
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  459  
57616ee4405b82 drivers/net/ethoc.c          Kulikov Vasiliy 2010-07-05  460  				dev->stats.rx_dropped++;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  461  				break;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  462  			}
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  463  		}
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  464  
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  465  		/* clear the buffer descriptor so it can be reused */
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  466  		bd.stat &= ~RX_BD_STATS;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  467  		bd.stat |=  RX_BD_EMPTY;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  468  		ethoc_write_bd(priv, entry, &bd);
6a632625c7da75 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  469  		if (++priv->cur_rx == priv->num_rx)
6a632625c7da75 drivers/net/ethoc.c          Jonas Bonn      2010-11-25  470  			priv->cur_rx = 0;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  471  	}
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  472  
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  473  	return count;
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  474  }
a1702857724fb3 drivers/net/ethoc.c          Thierry Reding  2009-03-27  475  

:::::: The code at line 450 was first introduced by commit
:::::: a1702857724fb39cb68ce581490010df99168fd0 net: Add support for the OpenCores 10/100 Mbps Ethernet MAC.

:::::: TO: Thierry Reding <thierry.reding@avionic-design.de>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/wcza/wjBR4CAA==

--IJpNTDwzlM2Ie8A6--
