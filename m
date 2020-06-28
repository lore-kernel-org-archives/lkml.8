Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732FC2076E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgF1AhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 20:37:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:53893 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgF1AhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:37:12 -0400
IronPort-SDR: WsXQSunlHHEEv2EznJdO+L1fPUgakZ96+iRjd0L6BjTsLNc/wKgu33nDxBSFHSjxTw8bgPGTZX
 FmoaLzTjvluw==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="147285515"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="gz'50?scan'50,208,50";a="147285515"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 17:29:36 -0700
IronPort-SDR: sTF41rLNECHyXnVS9NGYy2TRW6XN4Dkwr5iLRIabWepzqYAwsQGkfpSd7XMWIuqzh4tuy+5Mrb
 JkO2nmh9swaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="gz'50?scan'50,208,50";a="265908311"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2020 17:29:34 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpLCP-00031x-Sz; Sun, 28 Jun 2020 00:29:33 +0000
Date:   Sun, 28 Jun 2020 08:29:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/mx3fb.c:1336:26: sparse: sparse: incorrect type
 in assignment (different address spaces)
Message-ID: <202006280817.mt0JDPIK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4e99b32169e84b4ece5a1d74eb0b7e4ef07866b3
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 days ago
config: arm64-randconfig-s031-20200628 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/mx3fb.c:1336:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void * @@
>> drivers/video/fbdev/mx3fb.c:1336:26: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/mx3fb.c:1336:26: sparse:     got void *
>> drivers/video/fbdev/mx3fb.c:1359:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/mx3fb.c:1377:56: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *cpu_addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/mx3fb.c:1377:56: sparse:     expected void *cpu_addr
>> drivers/video/fbdev/mx3fb.c:1377:56: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/mx3fb.c:822:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/mx3fb.c:1094:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/mx3fb.c:1196:21: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/ata/ahci_xgene.c:196:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *port_mmio @@     got void [noderef] __iomem * @@
   drivers/ata/ahci_xgene.c:196:41: sparse:     expected void *port_mmio
>> drivers/ata/ahci_xgene.c:196:41: sparse:     got void [noderef] __iomem *
>> drivers/ata/ahci_xgene.c:203:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/ata/ahci_xgene.c:203:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:203:28: sparse:     got void *
>> drivers/ata/ahci_xgene.c:206:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/ata/ahci_xgene.c:206:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:206:17: sparse:     got void *
   drivers/ata/ahci_xgene.c:262:33: sparse: sparse: invalid assignment: &=
   drivers/ata/ahci_xgene.c:262:33: sparse:    left side has type unsigned short
   drivers/ata/ahci_xgene.c:262:33: sparse:    right side has type restricted __le16
   drivers/ata/ahci_xgene.c:457:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *port_mmio @@     got void [noderef] __iomem * @@
   drivers/ata/ahci_xgene.c:457:41: sparse:     expected void *port_mmio
   drivers/ata/ahci_xgene.c:457:41: sparse:     got void [noderef] __iomem *
   drivers/ata/ahci_xgene.c:464:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/ahci_xgene.c:464:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:464:20: sparse:     got void *
   drivers/ata/ahci_xgene.c:467:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/ahci_xgene.c:467:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:467:9: sparse:     got void *
   drivers/ata/ahci_xgene.c:502:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *port_mmio @@     got void [noderef] __iomem * @@
   drivers/ata/ahci_xgene.c:502:41: sparse:     expected void *port_mmio
   drivers/ata/ahci_xgene.c:502:41: sparse:     got void [noderef] __iomem *
   drivers/ata/ahci_xgene.c:508:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/ahci_xgene.c:508:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:508:25: sparse:     got void *
   drivers/ata/ahci_xgene.c:514:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/ahci_xgene.c:514:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:514:20: sparse:     got void *
   drivers/ata/ahci_xgene.c:517:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/ahci_xgene.c:517:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:517:9: sparse:     got void *
   drivers/ata/ahci_xgene.c:530:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/ahci_xgene.c:530:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/ahci_xgene.c:530:25: sparse:     got void *
   drivers/ata/ahci_xgene.c:718:9: sparse: sparse: Initializer entry defined twice
   drivers/ata/ahci_xgene.c:718:9: sparse:   also defined here
--
>> drivers/crypto/caam/ctrl.c:477:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *reg @@     got unsigned int [usertype] *mcr @@
>> drivers/crypto/caam/ctrl.c:477:31: sparse:     expected void [noderef] __iomem *reg
   drivers/crypto/caam/ctrl.c:477:31: sparse:     got unsigned int [usertype] *mcr
>> drivers/crypto/caam/ctrl.c:733:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [usertype] *mcr @@     got unsigned int [noderef] __iomem * @@
   drivers/crypto/caam/ctrl.c:733:32: sparse:     expected unsigned int [usertype] *mcr
>> drivers/crypto/caam/ctrl.c:733:32: sparse:     got unsigned int [noderef] __iomem *
--
>> drivers/crypto/marvell/cesa/cesa.c:384:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *sram @@     got void * @@
>> drivers/crypto/marvell/cesa/cesa.c:384:30: sparse:     expected void [noderef] __iomem *sram
   drivers/crypto/marvell/cesa/cesa.c:384:30: sparse:     got void *
--
>> drivers/crypto/marvell/cesa/cipher.c:93:47: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *buf @@     got void [noderef] __iomem * @@
   drivers/crypto/marvell/cesa/cipher.c:93:47: sparse:     expected void *buf
>> drivers/crypto/marvell/cesa/cipher.c:93:47: sparse:     got void [noderef] __iomem *
>> drivers/crypto/marvell/cesa/cipher.c:123:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void const *buf @@     got void [noderef] __iomem * @@
   drivers/crypto/marvell/cesa/cipher.c:123:49: sparse:     expected void const *buf
   drivers/crypto/marvell/cesa/cipher.c:123:49: sparse:     got void [noderef] __iomem *
   drivers/crypto/marvell/cesa/cipher.c:265:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/crypto/marvell/cesa/cipher.c:265:41: sparse:     expected unsigned int
   drivers/crypto/marvell/cesa/cipher.c:265:41: sparse:     got restricted __le32 [usertype]
   drivers/crypto/marvell/cesa/cipher.c:698:43: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/crypto/marvell/cesa/cipher.c:698:43: sparse:     expected unsigned int
   drivers/crypto/marvell/cesa/cipher.c:698:43: sparse:     got restricted __le32 [usertype]
--
>> drivers/crypto/marvell/cesa/hash.c:192:77: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *buf @@     got void [noderef] __iomem * @@
   drivers/crypto/marvell/cesa/hash.c:192:77: sparse:     expected void *buf
>> drivers/crypto/marvell/cesa/hash.c:192:77: sparse:     got void [noderef] __iomem *
>> drivers/crypto/marvell/cesa/hash.c:226:68: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
   drivers/crypto/marvell/cesa/hash.c:226:68: sparse:     expected unsigned char [usertype] *buf
   drivers/crypto/marvell/cesa/hash.c:226:68: sparse:     got void [noderef] __iomem *
   drivers/crypto/marvell/cesa/hash.c:343:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] *data @@     got unsigned int * @@
   drivers/crypto/marvell/cesa/hash.c:343:22: sparse:     expected restricted __le32 [usertype] *data
   drivers/crypto/marvell/cesa/hash.c:343:22: sparse:     got unsigned int *
   drivers/crypto/marvell/cesa/hash.c:345:42: sparse: sparse: cast from restricted __le32
   drivers/crypto/marvell/cesa/hash.c:345:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/crypto/marvell/cesa/hash.c:345:40: sparse:     expected unsigned int
   drivers/crypto/marvell/cesa/hash.c:345:40: sparse:     got restricted __le32 [usertype]
   drivers/crypto/marvell/cesa/hash.c:1265:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1265:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1265:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1265:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1265:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1265:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1268:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1268:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1268:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1268:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1268:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1268:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1335:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1335:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1335:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1335:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1335:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1335:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1338:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1338:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1338:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1338:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1338:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1338:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1392:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1392:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1392:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1392:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1392:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1392:30: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1395:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1395:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1395:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1395:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1395:34: sparse: sparse: cast to restricted __be32
   drivers/crypto/marvell/cesa/hash.c:1395:34: sparse: sparse: cast to restricted __be32

vim +1336 drivers/video/fbdev/mx3fb.c

86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1313  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1314  /*
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1315   * Main framebuffer functions
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1316   */
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1317  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1318  /**
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1319   * mx3fb_map_video_memory() - allocates the DRAM memory for the frame buffer.
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1320   * @fbi:	framebuffer information pointer
537a1bf059fa31 drivers/video/mx3fb.c       Krzysztof Helt        2009-06-30  1321   * @mem_len:	length of mapped memory
20de03dae54e10 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-08-06  1322   * @lock:	do not lock during initialisation
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1323   * @return:	Error code indicating success or failure
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1324   *
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1325   * This buffer is remapped into a non-cached, non-buffered, memory region to
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1326   * allow palette and pixel writes to occur without flushing the cache. Once this
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1327   * area is remapped, all virtual memory access to the video memory should occur
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1328   * at the new region.
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1329   */
20de03dae54e10 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-08-06  1330  static int mx3fb_map_video_memory(struct fb_info *fbi, unsigned int mem_len,
20de03dae54e10 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-08-06  1331  				  bool lock)
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1332  {
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1333  	int retval = 0;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1334  	dma_addr_t addr;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1335  
f6e45661f9be54 drivers/video/fbdev/mx3fb.c Luis R. Rodriguez     2016-01-22 @1336  	fbi->screen_base = dma_alloc_wc(fbi->device, mem_len, &addr,
f6e45661f9be54 drivers/video/fbdev/mx3fb.c Luis R. Rodriguez     2016-01-22  1337  					GFP_DMA | GFP_KERNEL);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1338  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1339  	if (!fbi->screen_base) {
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1340  		dev_err(fbi->device, "Cannot allocate %u bytes framebuffer memory\n",
537a1bf059fa31 drivers/video/mx3fb.c       Krzysztof Helt        2009-06-30  1341  			mem_len);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1342  		retval = -EBUSY;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1343  		goto err0;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1344  	}
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1345  
20de03dae54e10 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-08-06  1346  	if (lock)
537a1bf059fa31 drivers/video/mx3fb.c       Krzysztof Helt        2009-06-30  1347  		mutex_lock(&fbi->mm_lock);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1348  	fbi->fix.smem_start = addr;
537a1bf059fa31 drivers/video/mx3fb.c       Krzysztof Helt        2009-06-30  1349  	fbi->fix.smem_len = mem_len;
20de03dae54e10 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-08-06  1350  	if (lock)
537a1bf059fa31 drivers/video/mx3fb.c       Krzysztof Helt        2009-06-30  1351  		mutex_unlock(&fbi->mm_lock);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1352  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1353  	dev_dbg(fbi->device, "allocated fb @ p=0x%08x, v=0x%p, size=%d.\n",
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1354  		(uint32_t) fbi->fix.smem_start, fbi->screen_base, fbi->fix.smem_len);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1355  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1356  	fbi->screen_size = fbi->fix.smem_len;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1357  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1358  	/* Clear the screen */
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21 @1359  	memset((char *)fbi->screen_base, 0, fbi->fix.smem_len);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1360  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1361  	return 0;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1362  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1363  err0:
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1364  	fbi->fix.smem_len = 0;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1365  	fbi->fix.smem_start = 0;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1366  	fbi->screen_base = NULL;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1367  	return retval;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1368  }
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1369  
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1370  /**
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1371   * mx3fb_unmap_video_memory() - de-allocate frame buffer memory.
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1372   * @fbi:	framebuffer information pointer
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1373   * @return:	error code indicating success or failure
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1374   */
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1375  static int mx3fb_unmap_video_memory(struct fb_info *fbi)
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1376  {
f6e45661f9be54 drivers/video/fbdev/mx3fb.c Luis R. Rodriguez     2016-01-22 @1377  	dma_free_wc(fbi->device, fbi->fix.smem_len, fbi->screen_base,
f6e45661f9be54 drivers/video/fbdev/mx3fb.c Luis R. Rodriguez     2016-01-22  1378  		    fbi->fix.smem_start);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1379  
f3d8496e9c8418 drivers/video/mx3fb.c       Fabio Estevam         2013-02-21  1380  	fbi->screen_base = NULL;
537a1bf059fa31 drivers/video/mx3fb.c       Krzysztof Helt        2009-06-30  1381  	mutex_lock(&fbi->mm_lock);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1382  	fbi->fix.smem_start = 0;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1383  	fbi->fix.smem_len = 0;
537a1bf059fa31 drivers/video/mx3fb.c       Krzysztof Helt        2009-06-30  1384  	mutex_unlock(&fbi->mm_lock);
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1385  	return 0;
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1386  }
86528da229a448 drivers/video/mx3fb.c       Guennadi Liakhovetski 2009-01-21  1387  

:::::: The code at line 1336 was first introduced by commit
:::::: f6e45661f9be546811b62b2b01f32f4bf0c436c0 dma, mm/pat: Rename dma_*_writecombine() to dma_*_wc()

:::::: TO: Luis R. Rodriguez <mcgrof@suse.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--u3/rZRmxL6MmkK24--
