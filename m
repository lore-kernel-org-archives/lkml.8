Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D750C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8412065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgGGHu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:50:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:6408 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgGGHu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:50:27 -0400
IronPort-SDR: JeJHHnr+HmCW7NnGc7FpsebBo9CNAB3Hko/BfZbefjFVz3McPVUUIYhWx5PfBkaHSEHh5fhFQq
 MFCddPAYJpOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="232409946"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="gz'50?scan'50,208,50";a="232409946"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 00:09:23 -0700
IronPort-SDR: 0DFUUAzUWuri8ogkfhgSR6Zk/iats7rWGM1iii4ez2yRkGTHrilb3RcFUTv234mD2MZ5DYDczS
 UMBQ8C7OGGtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="gz'50?scan'50,208,50";a="315432292"
Received: from lkp-server01.sh.intel.com (HELO f2047cb89c8e) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2020 00:09:19 -0700
Received: from kbuild by f2047cb89c8e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jshjC-00008j-G3; Tue, 07 Jul 2020 07:09:18 +0000
Date:   Tue, 7 Jul 2020 15:09:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/soc/qcom/smem.c:406:16: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202007071506.KWPZ5XHx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfe91da29bfad9941d5d703d45e29f0812a20724
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: i386-randconfig-s002-20200707 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-31-gabbfd661-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/soc/qcom/smem.c:406:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:406:16: sparse:     expected struct smem_header *header
>> drivers/soc/qcom/smem.c:406:16: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:491:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:491:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:491:16: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:504:50: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:504:50: sparse:     expected void *
>> drivers/soc/qcom/smem.c:504:50: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:639:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:639:24: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:639:24: sparse:     got void [noderef] __iomem *virt_base
   drivers/soc/qcom/smem.c:661:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/soc/qcom/smem.c:661:23: sparse:    void *
>> drivers/soc/qcom/smem.c:661:23: sparse:    void [noderef] __iomem *
   drivers/soc/qcom/smem.c:663:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/soc/qcom/smem.c:663:23: sparse:    void *
   drivers/soc/qcom/smem.c:663:23: sparse:    void [noderef] __iomem *
   drivers/soc/qcom/smem.c:664:40: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/soc/qcom/smem.c:679:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:679:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:679:16: sparse:     got void [noderef] __iomem *virt_base
>> drivers/soc/qcom/smem.c:690:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_ptable *ptable @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:690:16: sparse:     expected struct smem_ptable *ptable
   drivers/soc/qcom/smem.c:690:16: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:712:57: sparse: sparse: restricted __le32 degrades to integer
>> drivers/soc/qcom/smem.c:731:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_partition_header *header @@     got void [noderef] __iomem * @@
   drivers/soc/qcom/smem.c:731:16: sparse:     expected struct smem_partition_header *header
   drivers/soc/qcom/smem.c:731:16: sparse:     got void [noderef] __iomem *
   drivers/soc/qcom/smem.c:926:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct smem_header *header @@     got void [noderef] __iomem *virt_base @@
   drivers/soc/qcom/smem.c:926:16: sparse:     expected struct smem_header *header
   drivers/soc/qcom/smem.c:926:16: sparse:     got void [noderef] __iomem *virt_base
--
>> drivers/soc/qcom/smp2p.c:218:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *value @@
>> drivers/soc/qcom/smp2p.c:218:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smp2p.c:218:34: sparse:     got unsigned int [usertype] *value
   drivers/soc/qcom/smp2p.c:325:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *value @@
   drivers/soc/qcom/smp2p.c:325:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smp2p.c:325:33: sparse:     got unsigned int [usertype] *value
>> drivers/soc/qcom/smp2p.c:328:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *value @@
>> drivers/soc/qcom/smp2p.c:328:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/qcom/smp2p.c:328:26: sparse:     got unsigned int [usertype] *value
--
>> drivers/soc/qcom/smsm.c:152:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *local_state @@
>> drivers/soc/qcom/smsm.c:152:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:152:32: sparse:     got unsigned int [usertype] *local_state
>> drivers/soc/qcom/smsm.c:164:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *local_state @@
>> drivers/soc/qcom/smsm.c:164:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:164:25: sparse:     got unsigned int [usertype] *local_state
>> drivers/soc/qcom/smsm.c:174:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:174:48: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:174:48: sparse:     got unsigned int [usertype] *
>> drivers/soc/qcom/smsm.c:206:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *remote_state @@
   drivers/soc/qcom/smsm.c:206:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:206:26: sparse:     got unsigned int [usertype] *remote_state
   drivers/soc/qcom/smsm.c:245:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:245:49: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:245:49: sparse:     got unsigned int [usertype] *
>> drivers/soc/qcom/smsm.c:247:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:247:49: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:247:49: sparse:     got unsigned int [usertype] *
   drivers/soc/qcom/smsm.c:272:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:272:49: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:272:49: sparse:     got unsigned int [usertype] *
   drivers/soc/qcom/smsm.c:274:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:274:49: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:274:49: sparse:     got unsigned int [usertype] *
   drivers/soc/qcom/smsm.c:569:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:569:47: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/soc/qcom/smsm.c:569:47: sparse:     got unsigned int [usertype] *
--
>> drivers/hwspinlock/stm32_hwspinlock.c:30:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
>> drivers/hwspinlock/stm32_hwspinlock.c:30:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/stm32_hwspinlock.c:30:39: sparse:     got void *priv
   drivers/hwspinlock/stm32_hwspinlock.c:41:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
   drivers/hwspinlock/stm32_hwspinlock.c:41:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/stm32_hwspinlock.c:41:39: sparse:     got void *priv
>> drivers/hwspinlock/stm32_hwspinlock.c:78:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/hwspinlock/stm32_hwspinlock.c:78:39: sparse:     expected void *priv
>> drivers/hwspinlock/stm32_hwspinlock.c:78:39: sparse:     got void [noderef] __iomem *
--
>> drivers/hwspinlock/u8500_hsem.c:52:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
>> drivers/hwspinlock/u8500_hsem.c:52:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/u8500_hsem.c:52:39: sparse:     got void *priv
   drivers/hwspinlock/u8500_hsem.c:65:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *lock_addr @@     got void *priv @@
   drivers/hwspinlock/u8500_hsem.c:65:39: sparse:     expected void [noderef] __iomem *lock_addr
   drivers/hwspinlock/u8500_hsem.c:65:39: sparse:     got void *priv
>> drivers/hwspinlock/u8500_hsem.c:116:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/hwspinlock/u8500_hsem.c:116:30: sparse:     expected void *priv
>> drivers/hwspinlock/u8500_hsem.c:116:30: sparse:     got void [noderef] __iomem *
>> drivers/hwspinlock/u8500_hsem.c:126:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *io_base @@     got void * @@
>> drivers/hwspinlock/u8500_hsem.c:126:52: sparse:     expected void [noderef] __iomem *io_base
   drivers/hwspinlock/u8500_hsem.c:126:52: sparse:     got void *
--
>> drivers/rpmsg/qcom_smd.c:510:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __iomem *src @@     got void * @@
>> drivers/rpmsg/qcom_smd.c:510:53: sparse:     expected void const [noderef] __iomem *src
   drivers/rpmsg/qcom_smd.c:510:53: sparse:     got void *
>> drivers/rpmsg/qcom_smd.c:517:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __iomem *src @@     got void *rx_fifo @@
   drivers/rpmsg/qcom_smd.c:517:43: sparse:     expected void const [noderef] __iomem *src
   drivers/rpmsg/qcom_smd.c:517:43: sparse:     got void *rx_fifo
>> drivers/rpmsg/qcom_smd.c:711:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *dst @@     got void * @@
>> drivers/rpmsg/qcom_smd.c:711:51: sparse:     expected void [noderef] __iomem *dst
   drivers/rpmsg/qcom_smd.c:711:51: sparse:     got void *
>> drivers/rpmsg/qcom_smd.c:718:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *dst @@     got void *tx_fifo @@
   drivers/rpmsg/qcom_smd.c:718:41: sparse:     expected void [noderef] __iomem *dst
   drivers/rpmsg/qcom_smd.c:718:41: sparse:     got void *tx_fifo

vim +406 drivers/soc/qcom/smem.c

4b638df4c9d556 Bjorn Andersson 2015-06-26  398  
4b638df4c9d556 Bjorn Andersson 2015-06-26  399  static int qcom_smem_alloc_global(struct qcom_smem *smem,
4b638df4c9d556 Bjorn Andersson 2015-06-26  400  				  unsigned item,
4b638df4c9d556 Bjorn Andersson 2015-06-26  401  				  size_t size)
4b638df4c9d556 Bjorn Andersson 2015-06-26  402  {
4b638df4c9d556 Bjorn Andersson 2015-06-26  403  	struct smem_global_entry *entry;
d52e404874369f Chris Lew       2017-10-11  404  	struct smem_header *header;
4b638df4c9d556 Bjorn Andersson 2015-06-26  405  
4b638df4c9d556 Bjorn Andersson 2015-06-26 @406  	header = smem->regions[0].virt_base;
4b638df4c9d556 Bjorn Andersson 2015-06-26  407  	entry = &header->toc[item];
4b638df4c9d556 Bjorn Andersson 2015-06-26  408  	if (entry->allocated)
4b638df4c9d556 Bjorn Andersson 2015-06-26  409  		return -EEXIST;
4b638df4c9d556 Bjorn Andersson 2015-06-26  410  
4b638df4c9d556 Bjorn Andersson 2015-06-26  411  	size = ALIGN(size, 8);
9806884d8cd552 Stephen Boyd    2015-09-02  412  	if (WARN_ON(size > le32_to_cpu(header->available)))
4b638df4c9d556 Bjorn Andersson 2015-06-26  413  		return -ENOMEM;
4b638df4c9d556 Bjorn Andersson 2015-06-26  414  
4b638df4c9d556 Bjorn Andersson 2015-06-26  415  	entry->offset = header->free_offset;
9806884d8cd552 Stephen Boyd    2015-09-02  416  	entry->size = cpu_to_le32(size);
4b638df4c9d556 Bjorn Andersson 2015-06-26  417  
4b638df4c9d556 Bjorn Andersson 2015-06-26  418  	/*
4b638df4c9d556 Bjorn Andersson 2015-06-26  419  	 * Ensure the header is consistent before we mark the item allocated,
4b638df4c9d556 Bjorn Andersson 2015-06-26  420  	 * so that remote processors will get a consistent view of the item
4b638df4c9d556 Bjorn Andersson 2015-06-26  421  	 * even though they do not take the spinlock on read.
4b638df4c9d556 Bjorn Andersson 2015-06-26  422  	 */
4b638df4c9d556 Bjorn Andersson 2015-06-26  423  	wmb();
9806884d8cd552 Stephen Boyd    2015-09-02  424  	entry->allocated = cpu_to_le32(1);
4b638df4c9d556 Bjorn Andersson 2015-06-26  425  
9806884d8cd552 Stephen Boyd    2015-09-02  426  	le32_add_cpu(&header->free_offset, size);
9806884d8cd552 Stephen Boyd    2015-09-02  427  	le32_add_cpu(&header->available, -size);
4b638df4c9d556 Bjorn Andersson 2015-06-26  428  
4b638df4c9d556 Bjorn Andersson 2015-06-26  429  	return 0;
4b638df4c9d556 Bjorn Andersson 2015-06-26  430  }
4b638df4c9d556 Bjorn Andersson 2015-06-26  431  
4b638df4c9d556 Bjorn Andersson 2015-06-26  432  /**
4b638df4c9d556 Bjorn Andersson 2015-06-26  433   * qcom_smem_alloc() - allocate space for a smem item
4b638df4c9d556 Bjorn Andersson 2015-06-26  434   * @host:	remote processor id, or -1
4b638df4c9d556 Bjorn Andersson 2015-06-26  435   * @item:	smem item handle
4b638df4c9d556 Bjorn Andersson 2015-06-26  436   * @size:	number of bytes to be allocated
4b638df4c9d556 Bjorn Andersson 2015-06-26  437   *
4b638df4c9d556 Bjorn Andersson 2015-06-26  438   * Allocate space for a given smem item of size @size, given that the item is
4b638df4c9d556 Bjorn Andersson 2015-06-26  439   * not yet allocated.
4b638df4c9d556 Bjorn Andersson 2015-06-26  440   */
4b638df4c9d556 Bjorn Andersson 2015-06-26  441  int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
4b638df4c9d556 Bjorn Andersson 2015-06-26  442  {
d52e404874369f Chris Lew       2017-10-11  443  	struct smem_partition_header *phdr;
4b638df4c9d556 Bjorn Andersson 2015-06-26  444  	unsigned long flags;
4b638df4c9d556 Bjorn Andersson 2015-06-26  445  	int ret;
4b638df4c9d556 Bjorn Andersson 2015-06-26  446  
4b638df4c9d556 Bjorn Andersson 2015-06-26  447  	if (!__smem)
4b638df4c9d556 Bjorn Andersson 2015-06-26  448  		return -EPROBE_DEFER;
4b638df4c9d556 Bjorn Andersson 2015-06-26  449  
4b638df4c9d556 Bjorn Andersson 2015-06-26  450  	if (item < SMEM_ITEM_LAST_FIXED) {
4b638df4c9d556 Bjorn Andersson 2015-06-26  451  		dev_err(__smem->dev,
4b638df4c9d556 Bjorn Andersson 2015-06-26  452  			"Rejecting allocation of static entry %d\n", item);
4b638df4c9d556 Bjorn Andersson 2015-06-26  453  		return -EINVAL;
4b638df4c9d556 Bjorn Andersson 2015-06-26  454  	}
4b638df4c9d556 Bjorn Andersson 2015-06-26  455  
5b3940676107dd Chris Lew       2017-10-11  456  	if (WARN_ON(item >= __smem->item_count))
5b3940676107dd Chris Lew       2017-10-11  457  		return -EINVAL;
5b3940676107dd Chris Lew       2017-10-11  458  
4b638df4c9d556 Bjorn Andersson 2015-06-26  459  	ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
4b638df4c9d556 Bjorn Andersson 2015-06-26  460  					  HWSPINLOCK_TIMEOUT,
4b638df4c9d556 Bjorn Andersson 2015-06-26  461  					  &flags);
4b638df4c9d556 Bjorn Andersson 2015-06-26  462  	if (ret)
4b638df4c9d556 Bjorn Andersson 2015-06-26  463  		return ret;
4b638df4c9d556 Bjorn Andersson 2015-06-26  464  
d52e404874369f Chris Lew       2017-10-11  465  	if (host < SMEM_HOST_COUNT && __smem->partitions[host]) {
d52e404874369f Chris Lew       2017-10-11  466  		phdr = __smem->partitions[host];
d52e404874369f Chris Lew       2017-10-11  467  		ret = qcom_smem_alloc_private(__smem, phdr, item, size);
d52e404874369f Chris Lew       2017-10-11  468  	} else if (__smem->global_partition) {
d52e404874369f Chris Lew       2017-10-11  469  		phdr = __smem->global_partition;
d52e404874369f Chris Lew       2017-10-11  470  		ret = qcom_smem_alloc_private(__smem, phdr, item, size);
d52e404874369f Chris Lew       2017-10-11  471  	} else {
4b638df4c9d556 Bjorn Andersson 2015-06-26  472  		ret = qcom_smem_alloc_global(__smem, item, size);
d52e404874369f Chris Lew       2017-10-11  473  	}
4b638df4c9d556 Bjorn Andersson 2015-06-26  474  
4b638df4c9d556 Bjorn Andersson 2015-06-26  475  	hwspin_unlock_irqrestore(__smem->hwlock, &flags);
4b638df4c9d556 Bjorn Andersson 2015-06-26  476  
4b638df4c9d556 Bjorn Andersson 2015-06-26  477  	return ret;
4b638df4c9d556 Bjorn Andersson 2015-06-26  478  }
4b638df4c9d556 Bjorn Andersson 2015-06-26  479  EXPORT_SYMBOL(qcom_smem_alloc);
4b638df4c9d556 Bjorn Andersson 2015-06-26  480  
1a03964dec3cec Stephen Boyd    2015-09-02  481  static void *qcom_smem_get_global(struct qcom_smem *smem,
4b638df4c9d556 Bjorn Andersson 2015-06-26  482  				  unsigned item,
4b638df4c9d556 Bjorn Andersson 2015-06-26  483  				  size_t *size)
4b638df4c9d556 Bjorn Andersson 2015-06-26  484  {
4b638df4c9d556 Bjorn Andersson 2015-06-26  485  	struct smem_header *header;
9f01b7a8f1d79c Alex Elder      2018-06-25  486  	struct smem_region *region;
4b638df4c9d556 Bjorn Andersson 2015-06-26  487  	struct smem_global_entry *entry;
4b638df4c9d556 Bjorn Andersson 2015-06-26  488  	u32 aux_base;
4b638df4c9d556 Bjorn Andersson 2015-06-26  489  	unsigned i;
4b638df4c9d556 Bjorn Andersson 2015-06-26  490  
4b638df4c9d556 Bjorn Andersson 2015-06-26  491  	header = smem->regions[0].virt_base;
4b638df4c9d556 Bjorn Andersson 2015-06-26  492  	entry = &header->toc[item];
4b638df4c9d556 Bjorn Andersson 2015-06-26  493  	if (!entry->allocated)
1a03964dec3cec Stephen Boyd    2015-09-02  494  		return ERR_PTR(-ENXIO);
4b638df4c9d556 Bjorn Andersson 2015-06-26  495  
9806884d8cd552 Stephen Boyd    2015-09-02  496  	aux_base = le32_to_cpu(entry->aux_base) & AUX_BASE_MASK;
4b638df4c9d556 Bjorn Andersson 2015-06-26  497  
4b638df4c9d556 Bjorn Andersson 2015-06-26  498  	for (i = 0; i < smem->num_regions; i++) {
9f01b7a8f1d79c Alex Elder      2018-06-25  499  		region = &smem->regions[i];
4b638df4c9d556 Bjorn Andersson 2015-06-26  500  
9f01b7a8f1d79c Alex Elder      2018-06-25  501  		if (region->aux_base == aux_base || !aux_base) {
4b638df4c9d556 Bjorn Andersson 2015-06-26  502  			if (size != NULL)
9806884d8cd552 Stephen Boyd    2015-09-02  503  				*size = le32_to_cpu(entry->size);
9f01b7a8f1d79c Alex Elder      2018-06-25 @504  			return region->virt_base + le32_to_cpu(entry->offset);
1a03964dec3cec Stephen Boyd    2015-09-02  505  		}
1a03964dec3cec Stephen Boyd    2015-09-02  506  	}
4b638df4c9d556 Bjorn Andersson 2015-06-26  507  
1a03964dec3cec Stephen Boyd    2015-09-02  508  	return ERR_PTR(-ENOENT);
4b638df4c9d556 Bjorn Andersson 2015-06-26  509  }
4b638df4c9d556 Bjorn Andersson 2015-06-26  510  

:::::: The code at line 406 was first introduced by commit
:::::: 4b638df4c9d556a6d947d6dbac364bee37b68b8e soc: qcom: Add Shared Memory Manager driver

:::::: TO: Bjorn Andersson <bjorn.andersson@sonymobile.com>
:::::: CC: Andy Gross <agross@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3V7upXqbjpZ4EhLz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
TKIxcWf8PXFmd77y6RZIJKsc11LLJcIYjUxOvR0E1MREiSqQ0gT1L5rY39IjOPai4z/z7Z35
2uOih3X8ue9BrsSCjr/0fJingxNvD9kAZyRY5PKiLc3mCNbYTaUiQD+P4CI8enwQgS0XmK0p
OOjITZlzbQZlLmp5vNnrUiYJ1/BcRDwcNOUF9zZQ7xKwRryLlGiyhi2Ib4wC9Nh9bd2UC1nF
JqKpZ0YAcphwRnSTSVzlhrtXgcDUL1Mw1m5ETWn1x7ynhiGo8ty3t297jF1+fsF8Bk1/Rgmk
vw5/g9b5rYHGW0c979XTqKwkaGJg0wA93vVltNHZblHol2+AaMMYDMeoFM7F4FpIFgh4MPLa
MI0qCnKpS+kxo3vao0hfmXHlIVtz8x2LZQT/K8Mogw9CgzHIi2vSQQK7noZDxlmnoMKh6an8
dronEQYioCexKLiqYPoOGkyOOr768I/D993TP94O2/3j8932j4ftzxf0vvcrrasuPg6m0CvB
VOnVB0wmv3v+99PHX5vHzcefz5u7l93Tx8PmxxY6vrv7uHt63d7j+vn4/eXHB7WkFtv90/bn
ycNmf7eltIFxaXUVbB+f979Odk87TEzd/d+mS2EfhlxibBWG52W5Ge5DKIxawSF+rzh6T4y+
PC/tUMOW7VKP9n/RUBHC3kaDNojrPe89V8H+18vr88nt83578rw/UfOhXT1NxPB5c+M+AAN8
6sIjEbJAl7RaBLKIjUtPTIT7CCrJLNAlLfUo5BHGEg46pNNxb0+Er/OLonCpF7q3rm8BQzdc
UmDXYs6028HNxGGFanh/mPngYKMhP66c5uezyelF2iQOImsSHuh2nf4ws9/UMfBapuO2aLCW
gUzdxjC0sKub3K6pOojyvbx9/7m7/eOv7a+TW1rW9/vNy8Mv3Y3TT3fF+d87ZOiursi4+LCH
sYRlWAl3UJpyGZ1++TK57Psq3l4fMGPtdvO6vTuJnqjDmL73793rw4k4HJ5vd4QKN68bZz8G
QeoOCsAenS8NYpCL4vRTkSfXmA/NW2f9Dp3LClbAMZoq+iaX/rGL4GXA5pb9Z06p9gey+oP7
EVN3UIPZ1IWZzp4BylrofTfcZpJy5cBy5nWF6pf9vnXtsX67zR1dY+Fyf5eyuJ8Cd2+EoJvV
Tcq8NcJysY57Mt4cHnyDmgp3VGMOuOa/c5mapWn6zMzt4ZXZSEEZfGaTCw28UloYVhF85lgZ
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

--3V7upXqbjpZ4EhLz--
