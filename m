Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D81720724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGCXdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:33:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:23721 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgGCXdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:33:42 -0400
IronPort-SDR: 1oMKxDBg99g/a+GxX8xTuDFZI4TXoMGKoCRB+Zx13UreFEAL/AEnFT0ThxlUpjRmJAKzPt4VA+
 a2JUmJnkpYFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="145338490"
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="gz'50?scan'50,208,50";a="145338490"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 16:17:37 -0700
IronPort-SDR: mZLmFzLbe8+8Wvf8EVQNR4XsMm4xBwVq9ZXbmCpsLhnKcTjK6b2Zea1CmQ/WO2LC46jXr333Hg
 6EetAuYXZQbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="gz'50?scan'50,208,50";a="482487271"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2020 16:17:36 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jrUw3-0000Rh-FD; Fri, 03 Jul 2020 23:17:35 +0000
Date:   Sat, 4 Jul 2020 07:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/dma/at_hdmac.c:941:15: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202007040754.nRSsPQcb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c7d7d1fada70420851b63f2e2669cb4976a303b
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   2 weeks ago
config: arm-randconfig-s031-20200703 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/dma/at_hdmac.c:941:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *vaddr @@     got void * @@
>> drivers/dma/at_hdmac.c:941:15: sparse:     expected void [noderef] __iomem *vaddr
   drivers/dma/at_hdmac.c:941:15: sparse:     got void *
>> drivers/dma/at_hdmac.c:947:11: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/dma/at_hdmac.c:957:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int *memset_vaddr @@     got void [noderef] __iomem *vaddr @@
   drivers/dma/at_hdmac.c:957:28: sparse:     expected int *memset_vaddr
>> drivers/dma/at_hdmac.c:957:28: sparse:     got void [noderef] __iomem *vaddr
>> drivers/dma/at_hdmac.c:971:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *vaddr @@     got void [noderef] __iomem *vaddr @@
   drivers/dma/at_hdmac.c:971:43: sparse:     expected void *vaddr
   drivers/dma/at_hdmac.c:971:43: sparse:     got void [noderef] __iomem *vaddr
   drivers/dma/at_hdmac.c:999:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *vaddr @@     got void * @@
   drivers/dma/at_hdmac.c:999:15: sparse:     expected void [noderef] __iomem *vaddr
   drivers/dma/at_hdmac.c:999:15: sparse:     got void *
   drivers/dma/at_hdmac.c:1005:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/dma/at_hdmac.c:1034:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int *memset_vaddr @@     got void [noderef] __iomem *vaddr @@
   drivers/dma/at_hdmac.c:1034:28: sparse:     expected int *memset_vaddr
   drivers/dma/at_hdmac.c:1034:28: sparse:     got void [noderef] __iomem *vaddr

vim +941 drivers/dma/at_hdmac.c

ce2a673d66b2ca Maxime Ripard 2015-10-22  909  
4d112426c3446d Maxime Ripard 2015-08-24  910  /**
4d112426c3446d Maxime Ripard 2015-08-24  911   * atc_prep_dma_memset - prepare a memcpy operation
4d112426c3446d Maxime Ripard 2015-08-24  912   * @chan: the channel to prepare operation on
4d112426c3446d Maxime Ripard 2015-08-24  913   * @dest: operation virtual destination address
4d112426c3446d Maxime Ripard 2015-08-24  914   * @value: value to set memory buffer to
4d112426c3446d Maxime Ripard 2015-08-24  915   * @len: operation length
4d112426c3446d Maxime Ripard 2015-08-24  916   * @flags: tx descriptor status flags
4d112426c3446d Maxime Ripard 2015-08-24  917   */
4d112426c3446d Maxime Ripard 2015-08-24  918  static struct dma_async_tx_descriptor *
4d112426c3446d Maxime Ripard 2015-08-24  919  atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
4d112426c3446d Maxime Ripard 2015-08-24  920  		    size_t len, unsigned long flags)
4d112426c3446d Maxime Ripard 2015-08-24  921  {
4d112426c3446d Maxime Ripard 2015-08-24  922  	struct at_dma		*atdma = to_at_dma(chan->device);
ce2a673d66b2ca Maxime Ripard 2015-10-22  923  	struct at_desc		*desc;
ce2a673d66b2ca Maxime Ripard 2015-10-22  924  	void __iomem		*vaddr;
ce2a673d66b2ca Maxime Ripard 2015-10-22  925  	dma_addr_t		paddr;
4d112426c3446d Maxime Ripard 2015-08-24  926  
2c5d7407e01272 Arnd Bergmann 2015-11-12  927  	dev_vdbg(chan2dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
2c5d7407e01272 Arnd Bergmann 2015-11-12  928  		&dest, value, len, flags);
4d112426c3446d Maxime Ripard 2015-08-24  929  
4d112426c3446d Maxime Ripard 2015-08-24  930  	if (unlikely(!len)) {
4d112426c3446d Maxime Ripard 2015-08-24  931  		dev_dbg(chan2dev(chan), "%s: length is zero!\n", __func__);
4d112426c3446d Maxime Ripard 2015-08-24  932  		return NULL;
4d112426c3446d Maxime Ripard 2015-08-24  933  	}
4d112426c3446d Maxime Ripard 2015-08-24  934  
4d112426c3446d Maxime Ripard 2015-08-24  935  	if (!is_dma_fill_aligned(chan->device, dest, 0, len)) {
4d112426c3446d Maxime Ripard 2015-08-24  936  		dev_dbg(chan2dev(chan), "%s: buffer is not aligned\n",
4d112426c3446d Maxime Ripard 2015-08-24  937  			__func__);
4d112426c3446d Maxime Ripard 2015-08-24  938  		return NULL;
4d112426c3446d Maxime Ripard 2015-08-24  939  	}
4d112426c3446d Maxime Ripard 2015-08-24  940  
247b4d83d6525d Tudor Ambarus 2020-01-23 @941  	vaddr = dma_pool_alloc(atdma->memset_pool, GFP_NOWAIT, &paddr);
ce2a673d66b2ca Maxime Ripard 2015-10-22  942  	if (!vaddr) {
ce2a673d66b2ca Maxime Ripard 2015-10-22  943  		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
4d112426c3446d Maxime Ripard 2015-08-24  944  			__func__);
4d112426c3446d Maxime Ripard 2015-08-24  945  		return NULL;
4d112426c3446d Maxime Ripard 2015-08-24  946  	}
ce2a673d66b2ca Maxime Ripard 2015-10-22 @947  	*(u32*)vaddr = value;
4d112426c3446d Maxime Ripard 2015-08-24  948  
ce2a673d66b2ca Maxime Ripard 2015-10-22  949  	desc = atc_create_memset_desc(chan, paddr, dest, len);
4d112426c3446d Maxime Ripard 2015-08-24  950  	if (!desc) {
ce2a673d66b2ca Maxime Ripard 2015-10-22  951  		dev_err(chan2dev(chan), "%s: couldn't get a descriptor\n",
4d112426c3446d Maxime Ripard 2015-08-24  952  			__func__);
ce2a673d66b2ca Maxime Ripard 2015-10-22  953  		goto err_free_buffer;
4d112426c3446d Maxime Ripard 2015-08-24  954  	}
4d112426c3446d Maxime Ripard 2015-08-24  955  
ce2a673d66b2ca Maxime Ripard 2015-10-22  956  	desc->memset_paddr = paddr;
ce2a673d66b2ca Maxime Ripard 2015-10-22 @957  	desc->memset_vaddr = vaddr;
ce2a673d66b2ca Maxime Ripard 2015-10-22  958  	desc->memset_buffer = true;
4d112426c3446d Maxime Ripard 2015-08-24  959  
4d112426c3446d Maxime Ripard 2015-08-24  960  	desc->txd.cookie = -EBUSY;
4d112426c3446d Maxime Ripard 2015-08-24  961  	desc->total_len = len;
4d112426c3446d Maxime Ripard 2015-08-24  962  
4d112426c3446d Maxime Ripard 2015-08-24  963  	/* set end-of-link on the descriptor */
4d112426c3446d Maxime Ripard 2015-08-24  964  	set_desc_eol(desc);
4d112426c3446d Maxime Ripard 2015-08-24  965  
4d112426c3446d Maxime Ripard 2015-08-24  966  	desc->txd.flags = flags;
4d112426c3446d Maxime Ripard 2015-08-24  967  
4d112426c3446d Maxime Ripard 2015-08-24  968  	return &desc->txd;
4d112426c3446d Maxime Ripard 2015-08-24  969  
ce2a673d66b2ca Maxime Ripard 2015-10-22  970  err_free_buffer:
ce2a673d66b2ca Maxime Ripard 2015-10-22 @971  	dma_pool_free(atdma->memset_pool, vaddr, paddr);
4d112426c3446d Maxime Ripard 2015-08-24  972  	return NULL;
4d112426c3446d Maxime Ripard 2015-08-24  973  }
4d112426c3446d Maxime Ripard 2015-08-24  974  

:::::: The code at line 941 was first introduced by commit
:::::: 247b4d83d6525d04278333cf201d6e3b066c9ca5 dmaengine: at_hdmac: Switch atomic allocations to GFP_NOWAIT

:::::: TO: Tudor Ambarus <tudor.ambarus@microchip.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/9DWx/yDrRhgMJTb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--/9DWx/yDrRhgMJTb--
