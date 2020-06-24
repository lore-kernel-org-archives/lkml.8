Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65442C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF2B2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406685AbgFXUef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:34:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:17669 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406562AbgFXUe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:34:29 -0400
IronPort-SDR: lOk2ctzQ8DJqyPPugZ/3x5p7BgAN+f8wO7LixMUz+vb/te/Ur4bZXXaUnc2n/lvYVICjDaXkZp
 sK+3cRmEwg6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133062261"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="133062261"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 13:34:06 -0700
IronPort-SDR: HvsE2u0a1y7aCj+lOw7E4skBN9C57d0RgG/ZQo1C2Ib4HoJtsFiubMe41fpZGrKcuylf+U68qp
 kXjBWLmP/wSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="385277855"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2020 13:34:02 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joC5p-00017t-LH; Wed, 24 Jun 2020 20:34:01 +0000
Date:   Thu, 25 Jun 2020 04:33:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:368:15: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-ID: <202006250457.eiLExOLP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26e122e97a3d0390ebec389347f64f3730fdf48f
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 days ago
config: alpha-randconfig-s031-20200624 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=alpha CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:302:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] vld_tid @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:302:22: sparse:     expected unsigned int [usertype] vld_tid
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:302:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:305:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] pgsz_tag_clr @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:305:27: sparse:     expected unsigned int [usertype] pgsz_tag_clr
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:305:27: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:306:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] max_offset @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:306:25: sparse:     expected unsigned int [usertype] max_offset
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:306:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:307:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] page_offset @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:307:26: sparse:     expected unsigned int [usertype] page_offset
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:307:26: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:368:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cxgbi_ppm_pool *pools @@     got void [noderef] __percpu * @@
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:368:15: sparse:     expected struct cxgbi_ppm_pool *pools
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:368:15: sparse:     got void [noderef] __percpu *
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:374:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct cxgbi_ppm_pool * @@
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:374:48: sparse:     expected void const [noderef] __percpu *__vpp_verify
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:374:48: sparse:     got struct cxgbi_ppm_pool *
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:484:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cxgbi_ppm_pool [noderef] __percpu *pool @@     got struct cxgbi_ppm_pool *[assigned] pool @@
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:484:19: sparse:     expected struct cxgbi_ppm_pool [noderef] __percpu *pool
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:484:19: sparse:     got struct cxgbi_ppm_pool *[assigned] pool
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:511:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __percpu *__pdata @@     got struct cxgbi_ppm_pool *[assigned] pool @@
>> drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:511:21: sparse:     expected void [noderef] __percpu *__pdata
   drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c:511:21: sparse:     got struct cxgbi_ppm_pool *[assigned] pool

vim +368 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c

47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  291  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  292  void cxgbi_ppm_make_ppod_hdr(struct cxgbi_ppm *ppm, u32 tag,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  293  			     unsigned int tid, unsigned int offset,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  294  			     unsigned int length,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  295  			     struct cxgbi_pagepod_hdr *hdr)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  296  {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  297  	/* The ddp tag in pagepod should be with bit 31:30 set to 0.
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  298  	 * The ddp Tag on the wire should be with non-zero 31:30 to the peer
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  299  	 */
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  300  	tag &= 0x3FFFFFFF;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  301  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  302  	hdr->vld_tid = htonl(PPOD_VALID_FLAG | PPOD_TID(tid));
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  303  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  304  	hdr->rsvd = 0;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14 @305  	hdr->pgsz_tag_clr = htonl(tag & ppm->tformat.idx_clr_mask);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14 @306  	hdr->max_offset = htonl(length);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14 @307  	hdr->page_offset = htonl(offset);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  308  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  309  	pr_debug("ippm: tag 0x%x, tid 0x%x, xfer %u, off %u.\n",
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  310  		 tag, tid, length, offset);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  311  }
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  312  EXPORT_SYMBOL(cxgbi_ppm_make_ppod_hdr);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  313  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  314  static void ppm_free(struct cxgbi_ppm *ppm)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  315  {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  316  	vfree(ppm);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  317  }
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  318  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  319  static void ppm_destroy(struct kref *kref)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  320  {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  321  	struct cxgbi_ppm *ppm = container_of(kref,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  322  					     struct cxgbi_ppm,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  323  					     refcnt);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  324  	pr_info("ippm: kref 0, destroy %s ppm 0x%p.\n",
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  325  		ppm->ndev->name, ppm);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  326  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  327  	*ppm->ppm_pp = NULL;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  328  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  329  	free_percpu(ppm->pool);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  330  	ppm_free(ppm);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  331  }
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  332  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  333  int cxgbi_ppm_release(struct cxgbi_ppm *ppm)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  334  {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  335  	if (ppm) {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  336  		int rv;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  337  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  338  		rv = kref_put(&ppm->refcnt, ppm_destroy);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  339  		return rv;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  340  	}
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  341  	return 1;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  342  }
9d5c44b7c4f434 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2016-07-21  343  EXPORT_SYMBOL(cxgbi_ppm_release);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  344  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  345  static struct cxgbi_ppm_pool *ppm_alloc_cpu_pool(unsigned int *total,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  346  						 unsigned int *pcpu_ppmax)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  347  {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  348  	struct cxgbi_ppm_pool *pools;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  349  	unsigned int ppmax = (*total) / num_possible_cpus();
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  350  	unsigned int max = (PCPU_MIN_UNIT_SIZE - sizeof(*pools)) << 3;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  351  	unsigned int bmap;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  352  	unsigned int alloc_sz;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  353  	unsigned int count = 0;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  354  	unsigned int cpu;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  355  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  356  	/* make sure per cpu pool fits into PCPU_MIN_UNIT_SIZE */
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  357  	if (ppmax > max)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  358  		ppmax = max;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  359  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  360  	/* pool size must be multiple of unsigned long */
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  361  	bmap = ppmax / BITS_PER_TYPE(unsigned long);
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  362  	if (!bmap)
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  363  		return NULL;
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  364  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  365  	ppmax = (bmap * sizeof(unsigned long)) << 3;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  366  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  367  	alloc_sz = sizeof(*pools) + sizeof(unsigned long) * bmap;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14 @368  	pools = __alloc_percpu(alloc_sz, __alignof__(struct cxgbi_ppm_pool));
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  369  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  370  	if (!pools)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  371  		return NULL;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  372  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  373  	for_each_possible_cpu(cpu) {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14 @374  		struct cxgbi_ppm_pool *ppool = per_cpu_ptr(pools, cpu);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  375  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  376  		memset(ppool, 0, alloc_sz);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  377  		spin_lock_init(&ppool->lock);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  378  		count += ppmax;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  379  	}
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  380  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  381  	*total = count;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  382  	*pcpu_ppmax = ppmax;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  383  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  384  	return pools;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  385  }
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  386  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  387  int cxgbi_ppm_init(void **ppm_pp, struct net_device *ndev,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  388  		   struct pci_dev *pdev, void *lldev,
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  389  		   struct cxgbi_tag_format *tformat, unsigned int iscsi_size,
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  390  		   unsigned int llimit, unsigned int start,
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  391  		   unsigned int reserve_factor, unsigned int iscsi_edram_start,
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  392  		   unsigned int iscsi_edram_size)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  393  {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  394  	struct cxgbi_ppm *ppm = (struct cxgbi_ppm *)(*ppm_pp);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  395  	struct cxgbi_ppm_pool *pool = NULL;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  396  	unsigned int pool_index_max = 0;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  397  	unsigned int ppmax_pool = 0;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  398  	unsigned int ppod_bmap_size;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  399  	unsigned int alloc_sz;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  400  	unsigned int ppmax;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  401  
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  402  	if (!iscsi_edram_start)
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  403  		iscsi_edram_size = 0;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  404  
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  405  	if (iscsi_edram_size &&
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  406  	    ((iscsi_edram_start + iscsi_edram_size) != start)) {
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  407  		pr_err("iscsi ppod region not contiguous: EDRAM start 0x%x "
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  408  			"size 0x%x DDR start 0x%x\n",
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  409  			iscsi_edram_start, iscsi_edram_size, start);
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  410  		return -EINVAL;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  411  	}
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  412  
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  413  	if (iscsi_edram_size) {
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  414  		reserve_factor = 0;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  415  		start = iscsi_edram_start;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  416  	}
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  417  
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  418  	ppmax = (iscsi_edram_size + iscsi_size) >> PPOD_SIZE_SHIFT;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  419  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  420  	if (ppm) {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  421  		pr_info("ippm: %s, ppm 0x%p,0x%p already initialized, %u/%u.\n",
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  422  			ndev->name, ppm_pp, ppm, ppm->ppmax, ppmax);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  423  		kref_get(&ppm->refcnt);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  424  		return 1;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  425  	}
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  426  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  427  	if (reserve_factor) {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  428  		ppmax_pool = ppmax / reserve_factor;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  429  		pool = ppm_alloc_cpu_pool(&ppmax_pool, &pool_index_max);
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  430  		if (!pool) {
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  431  			ppmax_pool = 0;
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  432  			reserve_factor = 0;
cc5a726c79158b drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-04-03  433  		}
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  434  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  435  		pr_debug("%s: ppmax %u, cpu total %u, per cpu %u.\n",
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  436  			 ndev->name, ppmax, ppmax_pool, pool_index_max);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  437  	}
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  438  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  439  	ppod_bmap_size = BITS_TO_LONGS(ppmax - ppmax_pool);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  440  	alloc_sz = sizeof(struct cxgbi_ppm) +
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  441  			ppmax * (sizeof(struct cxgbi_ppod_data)) +
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  442  			ppod_bmap_size * sizeof(unsigned long);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  443  
4c303373497015 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c YueHaibing    2018-07-19  444  	ppm = vzalloc(alloc_sz);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  445  	if (!ppm)
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  446  		goto release_ppm_pool;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  447  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  448  	ppm->ppod_bmap = (unsigned long *)(&ppm->ppod_data[ppmax]);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  449  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  450  	if ((ppod_bmap_size >> 3) > (ppmax - ppmax_pool)) {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  451  		unsigned int start = ppmax - ppmax_pool;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  452  		unsigned int end = ppod_bmap_size >> 3;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  453  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  454  		bitmap_set(ppm->ppod_bmap, ppmax, end - start);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  455  		pr_info("%s: %u - %u < %u * 8, mask extra bits %u, %u.\n",
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  456  			__func__, ppmax, ppmax_pool, ppod_bmap_size, start,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  457  			end);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  458  	}
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  459  	if (iscsi_edram_size) {
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  460  		unsigned int first_ddr_idx =
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  461  				iscsi_edram_size >> PPOD_SIZE_SHIFT;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  462  
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  463  		ppm->max_index_in_edram = first_ddr_idx - 1;
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  464  		bitmap_set(ppm->ppod_bmap, first_ddr_idx, 1);
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  465  		pr_debug("reserved %u ppod in bitmap\n", first_ddr_idx);
a248384e6420eb drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c Varun Prakash 2019-06-10  466  	}
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  467  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  468  	spin_lock_init(&ppm->map_lock);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  469  	kref_init(&ppm->refcnt);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  470  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  471  	memcpy(&ppm->tformat, tformat, sizeof(struct cxgbi_tag_format));
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  472  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  473  	ppm->ppm_pp = ppm_pp;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  474  	ppm->ndev = ndev;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  475  	ppm->pdev = pdev;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  476  	ppm->lldev = lldev;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  477  	ppm->ppmax = ppmax;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  478  	ppm->next = 0;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  479  	ppm->llimit = llimit;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  480  	ppm->base_idx = start > llimit ?
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  481  			(start - llimit + 1) >> PPOD_SIZE_SHIFT : 0;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  482  	ppm->bmap_index_max = ppmax - ppmax_pool;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  483  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14 @484  	ppm->pool = pool;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  485  	ppm->pool_rsvd = ppmax_pool;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  486  	ppm->pool_index_max = pool_index_max;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  487  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  488  	/* check one more time */
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  489  	if (*ppm_pp) {
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  490  		ppm_free(ppm);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  491  		ppm = (struct cxgbi_ppm *)(*ppm_pp);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  492  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  493  		pr_info("ippm: %s, ppm 0x%p,0x%p already initialized, %u/%u.\n",
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  494  			ndev->name, ppm_pp, *ppm_pp, ppm->ppmax, ppmax);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  495  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  496  		kref_get(&ppm->refcnt);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  497  		return 1;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  498  	}
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  499  	*ppm_pp = ppm;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  500  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  501  	ppm->tformat.pgsz_idx_dflt = cxgbi_ppm_find_page_index(ppm, PAGE_SIZE);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  502  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  503  	pr_info("ippm %s: ppm 0x%p, 0x%p, base %u/%u, pg %lu,%u, rsvd %u,%u.\n",
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  504  		ndev->name, ppm_pp, ppm, ppm->base_idx, ppm->ppmax, PAGE_SIZE,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  505  		ppm->tformat.pgsz_idx_dflt, ppm->pool_rsvd,
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  506  		ppm->pool_index_max);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  507  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  508  	return 0;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  509  
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  510  release_ppm_pool:
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14 @511  	free_percpu(pool);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  512  	return -ENOMEM;
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  513  }
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  514  EXPORT_SYMBOL(cxgbi_ppm_init);
47da7e62b391a7 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ppm.c     Varun Prakash 2016-02-14  515  

:::::: The code at line 368 was first introduced by commit
:::::: 47da7e62b391a74465c942d821bcbf879457a014 cxgb4: add iSCSI DDP page pod manager

:::::: TO: Varun Prakash <varun@chelsio.com>
:::::: CC: Nicholas Bellinger <nab@linux-iscsi.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Y9LD6tlsKg32f7qO25DmGQIA

--BXVAT5kNtrzKuDFl--
