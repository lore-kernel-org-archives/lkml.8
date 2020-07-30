Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6991DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7262074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgG3Ma7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:30:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:60675 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgG3Ma6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:30:58 -0400
IronPort-SDR: NHH1BW3UVWNz7wMZd5GKju76C91AXAIWej9Zt9KdSohEziFC5vJMf2vJpkNZHKmU72TD9TUKh5
 C/2T6Cw8UFOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="149414432"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="gz'50?scan'50,208,50";a="149414432"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 04:36:43 -0700
IronPort-SDR: YewwhsDJJUJ3XzmHp4h949WeNyTNIebMu10DdaTMSsawAhXG9sDphZLX683b6N89qy18xEfmKd
 HN+PF6fM1zbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="gz'50?scan'50,208,50";a="491095227"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2020 04:36:40 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k16rY-000042-7s; Thu, 30 Jul 2020 11:36:40 +0000
Date:   Thu, 30 Jul 2020 19:36:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     SrujanaChalla <schalla@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/marvell/cesa/tdma.c:117:40: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202007301910.TE2Q0Ew4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi SrujanaChalla,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   83bdc7275e6206f560d247be856bceba3e1ed8f2
commit: 655ff1a1a727f9b83df317c4ad3b2f4a48f6206c crypto: marvell - create common Kconfig and Makefile for Marvell
date:   4 months ago
config: arm-randconfig-s031-20200730 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-98-g4932334a-dirty
        git checkout 655ff1a1a727f9b83df317c4ad3b2f4a48f6206c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/crypto/marvell/cesa/tdma.c:86:37: sparse: sparse: restricted __le32 degrades to integer
   drivers/crypto/marvell/cesa/tdma.c:89:37: sparse: sparse: restricted __le32 degrades to integer
>> drivers/crypto/marvell/cesa/tdma.c:117:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] next_dma @@     got unsigned int [usertype] cur_dma @@
   drivers/crypto/marvell/cesa/tdma.c:117:40: sparse:     expected restricted __le32 [usertype] next_dma
>> drivers/crypto/marvell/cesa/tdma.c:117:40: sparse:     got unsigned int [usertype] cur_dma
>> drivers/crypto/marvell/cesa/tdma.c:240:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] src @@     got unsigned int [usertype] src @@
   drivers/crypto/marvell/cesa/tdma.c:240:19: sparse:     expected restricted __le32 [usertype] src
>> drivers/crypto/marvell/cesa/tdma.c:240:19: sparse:     got unsigned int [usertype] src
   drivers/crypto/marvell/cesa/tdma.c:292:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] src @@     got unsigned int [usertype] src @@
   drivers/crypto/marvell/cesa/tdma.c:292:19: sparse:     expected restricted __le32 [usertype] src
   drivers/crypto/marvell/cesa/tdma.c:292:19: sparse:     got unsigned int [usertype] src
>> drivers/crypto/marvell/cesa/tdma.c:293:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] dst @@     got unsigned int [usertype] dst @@
   drivers/crypto/marvell/cesa/tdma.c:293:19: sparse:     expected restricted __le32 [usertype] dst
>> drivers/crypto/marvell/cesa/tdma.c:293:19: sparse:     got unsigned int [usertype] dst

vim +117 drivers/crypto/marvell/cesa/tdma.c

db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   78  
53da740fed302f drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21   79  void mv_cesa_dma_prepare(struct mv_cesa_req *dreq,
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   80  			 struct mv_cesa_engine *engine)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   81  {
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   82  	struct mv_cesa_tdma_desc *tdma;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   83  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   84  	for (tdma = dreq->chain.first; tdma; tdma = tdma->next) {
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   85  		if (tdma->flags & CESA_TDMA_DST_IN_SRAM)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  @86  			tdma->dst = cpu_to_le32(tdma->dst + engine->sram_dma);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   87  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   88  		if (tdma->flags & CESA_TDMA_SRC_IN_SRAM)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   89  			tdma->src = cpu_to_le32(tdma->src + engine->sram_dma);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   90  
b99acf79a17bf4 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21   91  		if ((tdma->flags & CESA_TDMA_TYPE_MSK) == CESA_TDMA_OP)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   92  			mv_cesa_adjust_op(engine, tdma->op);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   93  	}
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   94  }
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18   95  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21   96  void mv_cesa_tdma_chain(struct mv_cesa_engine *engine,
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21   97  			struct mv_cesa_req *dreq)
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21   98  {
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21   99  	if (engine->chain.first == NULL && engine->chain.last == NULL) {
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  100  		engine->chain.first = dreq->chain.first;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  101  		engine->chain.last  = dreq->chain.last;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  102  	} else {
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  103  		struct mv_cesa_tdma_desc *last;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  104  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  105  		last = engine->chain.last;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  106  		last->next = dreq->chain.first;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  107  		engine->chain.last = dreq->chain.last;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  108  
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  109  		/*
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  110  		 * Break the DMA chain if the CESA_TDMA_BREAK_CHAIN is set on
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  111  		 * the last element of the current chain, or if the request
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  112  		 * being queued needs the IV regs to be set before lauching
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  113  		 * the request.
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  114  		 */
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  115  		if (!(last->flags & CESA_TDMA_BREAK_CHAIN) &&
8759fec4af222f drivers/crypto/marvell/tdma.c      Romain Perier    2016-12-14  116  		    !(dreq->chain.first->flags & CESA_TDMA_SET_STATE))
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21 @117  			last->next_dma = dreq->chain.first->cur_dma;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  118  	}
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  119  }
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  120  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  121  int mv_cesa_tdma_process(struct mv_cesa_engine *engine, u32 status)
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  122  {
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  123  	struct crypto_async_request *req = NULL;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  124  	struct mv_cesa_tdma_desc *tdma = NULL, *next = NULL;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  125  	dma_addr_t tdma_cur;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  126  	int res = 0;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  127  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  128  	tdma_cur = readl(engine->regs + CESA_TDMA_CUR);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  129  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  130  	for (tdma = engine->chain.first; tdma; tdma = next) {
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  131  		spin_lock_bh(&engine->lock);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  132  		next = tdma->next;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  133  		spin_unlock_bh(&engine->lock);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  134  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  135  		if (tdma->flags & CESA_TDMA_END_OF_REQ) {
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  136  			struct crypto_async_request *backlog = NULL;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  137  			struct mv_cesa_ctx *ctx;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  138  			u32 current_status;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  139  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  140  			spin_lock_bh(&engine->lock);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  141  			/*
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  142  			 * if req is NULL, this means we're processing the
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  143  			 * request in engine->req.
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  144  			 */
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  145  			if (!req)
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  146  				req = engine->req;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  147  			else
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  148  				req = mv_cesa_dequeue_req_locked(engine,
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  149  								 &backlog);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  150  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  151  			/* Re-chaining to the next request */
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  152  			engine->chain.first = tdma->next;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  153  			tdma->next = NULL;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  154  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  155  			/* If this is the last request, clear the chain */
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  156  			if (engine->chain.first == NULL)
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  157  				engine->chain.last  = NULL;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  158  			spin_unlock_bh(&engine->lock);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  159  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  160  			ctx = crypto_tfm_ctx(req->tfm);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  161  			current_status = (tdma->cur_dma == tdma_cur) ?
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  162  					  status : CESA_SA_INT_ACC0_IDMA_DONE;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  163  			res = ctx->ops->process(req, current_status);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  164  			ctx->ops->complete(req);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  165  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  166  			if (res == 0)
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  167  				mv_cesa_engine_enqueue_complete_request(engine,
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  168  									req);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  169  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  170  			if (backlog)
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  171  				backlog->complete(backlog, -EINPROGRESS);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  172  		}
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  173  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  174  		if (res || tdma->cur_dma == tdma_cur)
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  175  			break;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  176  	}
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  177  
655ff1a1a727f9 drivers/crypto/marvell/cesa/tdma.c SrujanaChalla    2020-03-13  178  	/*
655ff1a1a727f9 drivers/crypto/marvell/cesa/tdma.c SrujanaChalla    2020-03-13  179  	 * Save the last request in error to engine->req, so that the core
655ff1a1a727f9 drivers/crypto/marvell/cesa/tdma.c SrujanaChalla    2020-03-13  180  	 * knows which request was fautly
655ff1a1a727f9 drivers/crypto/marvell/cesa/tdma.c SrujanaChalla    2020-03-13  181  	 */
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  182  	if (res) {
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  183  		spin_lock_bh(&engine->lock);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  184  		engine->req = req;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  185  		spin_unlock_bh(&engine->lock);
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  186  	}
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  187  
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  188  	return res;
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  189  }
85030c5168f1df drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  190  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  191  static struct mv_cesa_tdma_desc *
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  192  mv_cesa_dma_add_desc(struct mv_cesa_tdma_chain *chain, gfp_t flags)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  193  {
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  194  	struct mv_cesa_tdma_desc *new_tdma = NULL;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  195  	dma_addr_t dma_handle;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  196  
472d640bd0fe5b drivers/crypto/marvell/tdma.c      Julia Lawall     2016-04-29  197  	new_tdma = dma_pool_zalloc(cesa_dev->dma->tdma_desc_pool, flags,
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  198  				   &dma_handle);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  199  	if (!new_tdma)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  200  		return ERR_PTR(-ENOMEM);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  201  
5d754137ab905a drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  202  	new_tdma->cur_dma = dma_handle;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  203  	if (chain->last) {
5d754137ab905a drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  204  		chain->last->next_dma = cpu_to_le32(dma_handle);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  205  		chain->last->next = new_tdma;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  206  	} else {
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  207  		chain->first = new_tdma;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  208  	}
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  209  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  210  	chain->last = new_tdma;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  211  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  212  	return new_tdma;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  213  }
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  214  
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  215  int mv_cesa_dma_add_result_op(struct mv_cesa_tdma_chain *chain, dma_addr_t src,
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  216  			  u32 size, u32 flags, gfp_t gfp_flags)
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  217  {
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  218  	struct mv_cesa_tdma_desc *tdma, *op_desc;
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  219  
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  220  	tdma = mv_cesa_dma_add_desc(chain, gfp_flags);
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  221  	if (IS_ERR(tdma))
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  222  		return PTR_ERR(tdma);
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  223  
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  224  	/* We re-use an existing op_desc object to retrieve the context
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  225  	 * and result instead of allocating a new one.
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  226  	 * There is at least one object of this type in a CESA crypto
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  227  	 * req, just pick the first one in the chain.
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  228  	 */
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  229  	for (op_desc = chain->first; op_desc; op_desc = op_desc->next) {
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  230  		u32 type = op_desc->flags & CESA_TDMA_TYPE_MSK;
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  231  
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  232  		if (type == CESA_TDMA_OP)
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  233  			break;
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  234  	}
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  235  
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  236  	if (!op_desc)
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  237  		return -EIO;
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  238  
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  239  	tdma->byte_cnt = cpu_to_le32(size | BIT(31));
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21 @240  	tdma->src = src;
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  241  	tdma->dst = op_desc->src;
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  242  	tdma->op = op_desc->op;
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  243  
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  244  	flags &= (CESA_TDMA_DST_IN_SRAM | CESA_TDMA_SRC_IN_SRAM);
0c99620f0ac13a drivers/crypto/marvell/tdma.c      Romain Perier    2016-10-05  245  	tdma->flags = flags | CESA_TDMA_RESULT;
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  246  	return 0;
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  247  }
bac8e805a30dc2 drivers/crypto/marvell/tdma.c      Romain Perier    2016-06-21  248  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  249  struct mv_cesa_op_ctx *mv_cesa_dma_add_op(struct mv_cesa_tdma_chain *chain,
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  250  					const struct mv_cesa_op_ctx *op_templ,
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  251  					bool skip_ctx,
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  252  					gfp_t flags)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  253  {
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  254  	struct mv_cesa_tdma_desc *tdma;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  255  	struct mv_cesa_op_ctx *op;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  256  	dma_addr_t dma_handle;
6de59d453ae567 drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  257  	unsigned int size;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  258  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  259  	tdma = mv_cesa_dma_add_desc(chain, flags);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  260  	if (IS_ERR(tdma))
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  261  		return ERR_CAST(tdma);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  262  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  263  	op = dma_pool_alloc(cesa_dev->dma->op_pool, flags, &dma_handle);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  264  	if (!op)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  265  		return ERR_PTR(-ENOMEM);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  266  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  267  	*op = *op_templ;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  268  
6de59d453ae567 drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  269  	size = skip_ctx ? sizeof(op->desc) : sizeof(*op);
6de59d453ae567 drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  270  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  271  	tdma = chain->last;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  272  	tdma->op = op;
6de59d453ae567 drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  273  	tdma->byte_cnt = cpu_to_le32(size | BIT(31));
ea1f662bde0675 drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  274  	tdma->src = cpu_to_le32(dma_handle);
36225b9170ea7b drivers/crypto/marvell/tdma.c      Thomas Petazzoni 2016-08-09  275  	tdma->dst = CESA_SA_CFG_SRAM_OFFSET;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  276  	tdma->flags = CESA_TDMA_DST_IN_SRAM | CESA_TDMA_OP;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  277  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  278  	return op;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  279  }
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  280  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  281  int mv_cesa_dma_add_data_transfer(struct mv_cesa_tdma_chain *chain,
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  282  				  dma_addr_t dst, dma_addr_t src, u32 size,
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  283  				  u32 flags, gfp_t gfp_flags)
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  284  {
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  285  	struct mv_cesa_tdma_desc *tdma;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  286  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  287  	tdma = mv_cesa_dma_add_desc(chain, gfp_flags);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  288  	if (IS_ERR(tdma))
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  289  		return PTR_ERR(tdma);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  290  
6de59d453ae567 drivers/crypto/marvell/tdma.c      Russell King     2015-10-18  291  	tdma->byte_cnt = cpu_to_le32(size | BIT(31));
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  292  	tdma->src = src;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18 @293  	tdma->dst = dst;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  294  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  295  	flags &= (CESA_TDMA_DST_IN_SRAM | CESA_TDMA_SRC_IN_SRAM);
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  296  	tdma->flags = flags | CESA_TDMA_DATA;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  297  
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  298  	return 0;
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  299  }
db509a45339fd7 drivers/crypto/marvell/tdma.c      Boris Brezillon  2015-06-18  300  

:::::: The code at line 117 was first introduced by commit
:::::: 85030c5168f1df03a164d47254cc785331f1dfe2 crypto: marvell - Add support for chaining crypto requests in TDMA mode

:::::: TO: Romain Perier <romain.perier@free-electrons.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJGpIl8AAy5jb25maWcAjDzbcts4su/zFarMy25tZUYX23HOKT+AJChhRBI0AEq2X1CK
o2Rc60uOLGcmf38a4A0Am8psbVVG3Q2g0Wj0DU3/+suvE/J2fHnaHR/ud4+PPyZf98/7w+64
/zz58vC4/99JwicFVxOaMPUbEGcPz29//747PE3Of7v4bfr+cD+brPeH5/3jJH55/vLw9Q0G
P7w8//LrL/D/XwH49A3mOfzPBMa8fzSj3399ftvvPj28/3p/P/nXMo7/Pfn42+K3KdDHvEjZ
UsexZlID5upHC4IfekOFZLy4+jhdTKcdbUaKZYeaOlOsiNRE5nrJFe8nchCsyFhBB6gtEYXO
yW1EdVWwgilGMnZHk56QiWu95WLdQ6KKZYliOdWKRBnVkgsFWCuCpZXo4+R1f3z71m8yEnxN
C80LLfPSmRsW1LTYaCKWOmM5U1eLuRFkwyPPSwYLKCrV5OF18vxyNBO3ozMek6wVxrt3GFiT
ypWH5VxLkimHfkU2VK+pKGiml3fMYc/FZHc5wTE3d2Mj+BjiDBDdLp2l3U2GeMMAIgSXieEQ
fnrGM2TChKakypRecakKktOrd/96fnne/7uTl9wSR0byVm5YGQ8A5t9YZS5XJZfsRufXFa0o
ylcsuJQ6pzkXt5ooReIVSldJmrEI4Z1UcHMDoRMRr2qE4YhkWY8PoFaBQd0nr2+fXn+8HvdP
vQIvaUEFi+1tKAWPnJvkouSKb8cxOqMbmrn8iQRwEkSqBZW0SPCx8crVSgNJeE5Y4cMkyzEi
vWJUGCHcDifPJTOUo4jBOitSJHAhm5m9oYY85SKmiVYrQUnCiqWjFSURkjYjuoN0N5nQqFqm
0j/w/fPnycuX4FAwEeWgsqxhTzgnbA4/BouwlrwC3nRCFBlu1xqzzUA/WrSdAI6uULJVE/Xw
tD+8YpqiWLwGQ0fhwB1VLLhe3RmDlvPClQAAS1iDJyxG9LkexWBP7hgLRS/Gii1XRpPshgQu
ywHnzgUVlOalggUK/IK2BBueVYUi4hbhuaHpt94OijmMGYCZlUftPsvqd7V7/e/kCCxOdsDu
63F3fJ3s7u9f3p6PD89fAynDAE1iO2+tbB2jGyZUgDaniW7KqI9VgJ4W2VYkE3PxYwoWCgid
jYQYvVm4rCgi11IRJTFZSeYZSLh1rflNmDTONUHP8B9IykpUxNVEIioKoteAG56RB4Qfmt6A
ejqblR6FnSgAme0O5wEJZFmv/w6moGAxJF3GUcak8nEpKXhlY4IBEGwpSa9mF730DC7iHA0V
7EI8joxOWIk3gvQF1Jmydf0fjnFbd4LisQtegaGDm9aDMm7CjBTsPUvV1XzaS5gVag2xR0oD
mtkitDcyXoFMrNVp74a8/3P/+Q1iy8mX/e74dti/WnCzDQTbxXlLwatSumoGDjZeolchytbN
AESGNaJmrt9vSpjQPqb356nUEZjkLUsU7snhljpjxxctWeJtoQGLBI2JGmwK2nnneoMGntAN
iykyHSiHucB4bNKOBS+FLCl5vO5oPB9jYijwfmAeelilpC68DZmIqcBMBMQ6IqAFYQS0vWug
agwFAo7XJQctNB5CcUGxbVjNM0Gz3Yq7KnhHOM6EgqmIiUIPS9CMOFGG0SaQtY3yhZtRmN8k
h9lqp+zE4iIJQnAARACYu5wALAyGXdzNHcZa0sTj/ixYAAw2xDgr3wBAusTBWeWQG5koxzht
+CcnRaBIAZmE/8DE3MbGbqBasWR24UivTN2Za0OMKYg/zAZCRmm8iNzIOoxu0jpacpyAjc/r
0MF1DcZwhb91kTM3r3JERbMUxCeciSMCoV9aeYtXit4EP0GxnVlK7tJLtixIljpaZPl0ATZA
cwFyBZbOiQWZk48xrivhRagk2TBgsxGTIwCYJCJCMFeka0Nym3vXsoVp+BdL1Fq0lYa5Kopt
POWBE2+XH0t7hA0OUuzy2VDXpPQ9vzBbEQdnAVG4F4IDMU0S9DpbrTSKrrvYt9UBAwR29CYH
Zq1HtO6oKY6U+8OXl8PT7vl+P6Hf988QmRBwVLGJTSD2rIM9Z6Z6ejTS+Ycztoxt8nqyOtj0
9FhmVVSbb+dW87wkSke2utFbuoxgyaWZwJ2ORCBqsaRtyBZOYf2PiWm0gIvGc3RKl8ykgxAB
eC5Urqo0hYyrJLCQlTUB042bFEVz63tMgYilDCiZG2xB6JKyrA2UG/n69Zpel9x7I3KrV9L4
EC8bNBjwwFYTGIR21RBlwcA4XN8czuXq0uFXy6osuQBfSEo4N7BcAce1AkLE1YRt7VBF4jV4
EEjnmhnc8Cteg48aImp6iPXTjCzlEJ+C6aNEZLfwW3t2o43KVlsK6ZUaIuDCskiATwRN8Byg
vZLdJitbN5C+jED9gKZcgTRMzjKc3NPXcllX3GwdQV7Nm9jQRq8T9ePbvo/xg9OARfKcQMRU
gENlwE0OB3l5Ck9urmbnvSLWJMa5lHBMxvehNsqS0UiS2Wx6gqD8uLi5Gcen4IIjwZIlnoZa
GsbLxfzEHOymPPPXcLEJ922vBZY3eFBhkaKMx5F2vyc2LBfx/OzUjjkIf+ai7cnmu8P3/ePj
JHn5vp+wp2+P+yewfbbm/NoftdkLqMSSxI7u5aTZpU6iABrnmpzPpq4ZOLlQp31w8JoL36h0
sJ4Dy3p5eLnfv76+HAK9NEl5+ceZY4MBsPng/1arKodcjZRG233UYv79Yj0ABeNJBIkFDWct
LTiExiASOgZlbiHDwnl5qzcXAbtZNJigrruzJBhezs6HkOayBnJL3UTPMRlZSbCY0qCs3HwD
Y0GU+kBbHqE3vsvalo0NHinOArOsFktTm8AyLyBKPCIvOgZsBPlDwmL1k0lkSWPlxi21cwRX
DSH3SjeTcDcks5nSimal5/Y3ifTC/po5RSrB5XxEjNmsIbMJur7whedjry5ClwfOw2T3KRW+
9trYo3aFWvAmSewTwG2e32DxvZmWCmH8+tli+vHDwjdbPfL88uLjYsTC9FQX0+mH89PLfJhP
P1x+HFnmw9niYj4muJbmfHb2YT42wfnZ4qcTANF86ou9Qy2m8zmKupxdLubn+vJ8fjZGMZ/V
82KMXc7PL2YfTzN2ef5h/mE2NoFZePazE7BUPz0nu9AcDYldd29tQ/Rmyrnfvr0cjqGt6CQD
Epmis7mD3Rgesz7Ne0peuyybgKH72OSyzJjSC7zK1KNNsowIvCWY+zXdBjrD6i82PuZpKqm6
mv59Oa3/5wujlDEbiwcKoZclJIhdvW51Z0JCCMZdCPh4lyOAzEe8vkGdj6IW46POx1Gw+hTh
f3V3NXO3ai3+vHnkG1HnOuxkCds494SSyCtHc/jdpEhj2WEdNqWF3oBd8xIX8xQBlnDUlcht
+4pUkmLsVLYEUjkbCZNMr6olBU/rX+ycJ5VJjzI3PbXPUCaC1Xe8oBwch7iazbphbTJicgKn
1GRqf6aGv2VqZWukpRNOSRobSTiBDxHEj9hbSPiY4MZZ4eWq7+8LbP3lWxvVufk+qDQmGwUp
jOtY2pqc5SGHBElU7gvFnS1pCQ7RgHH607+nQ0wkpYuI88T2C7x71/Nzw0pEq5xX5RuKPWLF
gkgIRavcKyeaGqO+M2WQJBG4ZXLF0j4QTcqXv/YHiFefd19tjNr1XgAuPez/723/fP9j8nq/
e6zfizylg1T7euxBBRndTcw+P+7Ducyr3Ohc9QAXMuDbzpc+vuzMc83k28vD83Gyf3p79DpK
yHHyuN+9ghye9z128vQGoE97WPdxf3/cf3Z526QlytboUnXYadl76tjD9FFWEJUVCW6eWASa
YfN3zDo76TSk+m0Vpq8C5ab8ZoqpybDC3quMWyVAV9FxtvZWarPo2tQ4d2Z7rUu+hYCRpimL
mbEGfRnHT9/tpk1xVDIvnqsLbv2+XZJO6qNyrY//4fD01+6wnySHh+91ZcyxbTLOmSl/KB7z
zDd7NcpuIHyir9GlN9JzgzXSGYuIMt3qOG0qx45ddaCdhXCfOkUljRVKwfIlVibYi0YXRcg8
9rqeOF+CKU+ZyLfEhv71S/v+62E3+dJK6rOVlPv4NULQ6X0oY18asbgtFd4mY4x5ZdqhBgrn
tTrtDvd/PhzhHoJFf/95/w3W9S9Q607rApyX04AkHHBvSutSEcrVH2BIdUYi1LfbGXuVrgrr
7MyTjvVtgfIaB2NaosBLgf332nrqfqWwYlVDBVUoAoI5FO49FfRhg63IrThfB0iTQ8FvxZYV
r5y5utdR2L8xvk2byZDAIs3zAXhtVZXhjYXEHAIExdLb9v1pSLCmtAyfrTokzNo0KaHbslw1
PlhvV0xR/2HbUi3mEYSyELDqsF9J0KXUpEjqMmdzcGD7Qhk2hXwX5Fm/vnpvZsTgNmGuV2m8
82AzvbIF/NvIzDxa1n09bRceMkUTOcG9zpT3KjUCtyMtV8aAUT/Jb7oWfbTtVwnKw8jYYBAc
EHfff2oJgt5BiGR1c80G6JG2koAKaSgJKCBqbYRT0tiU6p0KnQ1opb2b5iVNDERvBGAx9lWB
3YUGZVjMDQjoDaheeHmQUZfDE2+7UxQvE74t6gEZuTVdGqEky9v2Lij3OS3O4LR0BPIFK584
CG5aM9mycbiLAYLE/utA83hT3yQj72Az3DYXQeLQtDuK7c3PKUaigFrphKlbYbOdQIXDm4QF
G46huuH2iQBC5iT3ykbmvcN98pJDNxXzzftPu9f958l/6+zj2+Hly0MYHhuyUzljw4YlazyW
rp+T+7ekEyv19eJqaXoSuVTg+999/c9//D5c0/pc07iW/zRQm5plYRqJ4Uq7SZtDYi5LmBah
6MHLfvBQ9hNv384NdiI3b9quM7QPv9K8mPZFhebMZZ215kQNLIF72g11nd9mnOCxeENVFSFF
j2/sNTa5FHHXPI0+ZPcsY6Pb9PvkQO01IjhwuSKzkVkBNZ+fndpwS3V+8Q+oFpf/ZK7zGVap
dGjgTqyu3r3+uZu9G8xhDJQA531qHfOku9U5g8yhcHqFNMvtoyHeB1CAcwCTeJtHPMNJwKDk
Ld3adB1gfS5Nf1n3cw2pgWTgca4r6gYsbR9PJJcoMGPREM7AkS4FU2g/UIPSaubV01oCU7XB
FNe2p9VpRx13iHD0NsJKVfW8pvruZjN2wyAfXpKu+7vcHY4PNsU25VW/U4FAzGjzvDZVxexk
Dn6qJ3V0XCZcYgiaMg/cZ44BKy7bOWSvMfO3AjATnrhNLgZsU++6s533fYLezmAk43XnVwLu
2ogXU/qean0b+aJvEVGKl1f8pTthyWLmlN+K+hMViInAIBvj5Wqn/5ROFAQ+sYZE0UlOu24/
uzf69/7+7bj79Li33/ZMbPvI0UnHIlakuTKRlKdEHVSnScmwehbg/JYa88tG0F14ZIYPOkOb
qWUsvFfFzrU2+DRzncDPgObLmU1pvqEp7dc1JsZF9mNJIY7Cuz5rmjtDdIoA7KEw2f1PyMCY
oWVAkFJXBGz0YuyQ6sfv/dPL4YdTMhum1IYVr1fD7rPgCbWvcDkJkz+T19kGKV+7mk9OmORh
C0r95FAqG2dB5C+vzoJBkTHhflO/jUzjkSoVWAhBwkjWZLu6baXqywASaxpqlczG3jkz9igR
V2fTj91LpG2phjjGpiprRzxxRsFymcdLd5kUEiFl0n/s1PxwE36OtsB2ONfIGiBoDZFXH/pZ
7krO8RryXVThOnon604zZN027bfdO2CKBPXOva4GmOehYVIHMrJvEaY934kLq1JHtIhXOWka
w9ouiVGN7CXffQlX7I9/vRz+ayquA70F7VhT7/W9huiEEUy0YBtvPEt5YyqA7ngLC0f34cBI
mHCTityWAUabidcU+8aDFT73rKxbg2IicdMABF2BV0CySLEWNiAqC/fk7G+drOIyWMyAzcsF
/sFcQyCIwPFmX6wc+dquRi6NRad5hfUP1RRaVUVBveKqvC3gKvM1G6nc1QM3io1iU16dwvXL
4guYY9EE77S3OAgux5GsNHZr5LT77bpAo3ABSMVlC/anr5JyXEEthSDbn1AYLJyLKd3c4ooO
q8N/Lk/FaB1NXEVu5aWrbTT4q3f3b58e7t/5s+fJOcT9qPbatiBHCzcXja6bdpV0RFWBqO4Y
l8q8U4ykdGb3F6eO9uLk2V4gh+vzkLMSz5osNtBZFyWZGuwaYPpCYLK36CKBCMF6aXVb0sHo
WtNOsFo3ITZfH4/cBEtopT+Ol3R5obPtz9azZOAL8PY/kO6gGN9H1iWozNgw81G1qYIaL3OS
plzd2voWuKm8DL5Oc4nrSioempUnkGBVkniET2Y+zRmxsyIZST7ZWKukwvsBsrnC7I5UjjOo
20HD35otIeyWBeflsMpqLYb04pcGhD/3ZKTQl9P57BrhJaFx7fO838397sFZFns//CYoRTL8
pG/m57hgSIl1opcrHjjgi4xvgz6K/ggppWZb59jHLmYT7XdbNmy5ftu/7SFo+b1J2LyvLhtq
HUfO00MLXKkoFLUFp3L05liCUjA+zll93a+xmQVq3lusTFF2ZIodb4tV9Dob7kxF6RAYR3II
hEuILarITzYJ8UYynC2RXQQaYODfkd6abqwYD+qsWK9DloaiWkc/YTte8TXF+LsOCwHhQDD+
WG2xxafXNQkidrKmQ2iK6eMKPYuSYdWNDpu5/fb9sUpsqiZiGJTc48fd6+vDl4f7tpfDGRdn
g6kAZGrDaLGhxauYFYn9Ymow1NqgsbttCNItNqxaYKXNblK5KX05tNALbLIU7M/ogRuC0a9K
OwGU6XA9M61rXlt4btrXvBqyjW4tGIM1dZH+O2IHFft9SQ6miG7VmK40JCDEkcE5VdinqQ6F
Chqw282RGKthdprOUqfCl8SekUsKaT7u5ObPn+BxALhgYiuYKJqXtNjILVMjf3hjYz5zpein
7CYOYsU6SAnyMguspIHopeQ+jVViz4PXX7I6p7mSYnAHLacJxTdjKLIF6Io0IfgpqiKWWHzb
fM5rKIwddIoaPSLOiPS6/G1UcKOjSt5q/xPG6NrLFs3Xfn+wofFo6gaT4/71GLzRWU7WavCH
DJryxGBkgHBLEf2kK5ILkoy4ghjtzYw8vY3MB3Q0wTL6yHymH9BmdCRsBJykWTryx34i5RSX
6rbJx7f98eXl+Ofk8/77w33b+eOWeJV9a3DPAHiNc++3UD7+Oibe71XMIlXJCAXaNsbmxTrY
Z0cCC47tt6PJ1Rrfc0ch/L+l06JkgjroGl0Rtz+1h4GcBdwHFLU6Q8EFX7OBXCwmimU55Myi
iFot8IDXIULfGB38Ysu8b4l7zPBse55yFF6fLcrq8gL9WMwhycVmsBosNJ8ubgbgksymN8h5
pXCUo6skKpthZ7zA4+cGnVU0JmKksm9JNiu07z1CtmQA2uiUB7Xn6NOpdUPlrgVQIynUOI3e
Vic/SsFyjn5ml+p1jJXDUwaXI3woNzqTjT29bllOsLMW6Zq5Brv+bQ3WAMiK0m15aaD2EwLP
FXwsw9/9K51n1z8if1vCMcMMrx/FtFzp4G9h9dOmWERZSgIeN4ihWeqZaawo0oYYUun2BaEB
gTcERrLQ04OFMRGBU203RXhT+nfeawjL+MZ/TKRqpYCojSgQHuoupsaBtu4gqdVq0Elb97u5
r6XhD+dPI/T1+JjR/+fsSZYcx3H9lTy9mI6YfmXJS9qHPtBabJa1lSjbyroosquyuzOmOqsi
Mzum5+8fQEoySIH2xDvUYgAEKa4ACIB41wjnONeHgBXK8mruIVww+IjTTrcK2sMOl02Gl53/
FfHFXcXT0K5q7IZidq8JgE33hbhPR1kflPM93ksg3Z0NDZRHiGgmDGR58hQHWcsuXdlxlPuy
QS3NHkYC7CKDuUg4BKf29v5ibv1hf/zy/eX99fs3zKEzkSN0Lwq0nwl3XHsw9uCEbfz09vz7
yxl9j7GG6Dv8R03jtDSb+GxCafel5wbFokp4g5weShD/efHwWnNMex6/PmGCBcA+kf6wg8uG
kIabtKMfA9+5Y8cnL191RILV3R3IUzpXjT0TBmifnoVeNGo07AiNcV2xqh+rGCt9+/fz+5c/
bg06BikZHaNJIpepn8WFAx7MtIl5RIUo81v7cXWRpJemUGx7HAXdKvr5y+Pr17tfX5+//m47
pTwkBatmVvHqPtyQq5l1ONuEtGqsAx1n8e5TWrfOtaikI1Ve/N2fv/Q77F3JBCwZR0QTg8sa
UU9NXqXWXjDAuhzdF1krsChikVkuvlVtahpiBUxiz6G/Ro//b99hlr4Sd4Gz7mxqURhB+nSK
MXD3ggQFHZb2GJBwSVN0KUWCjulXsQRw2mUZOr5yUsxYYPAao/PN/aKhVO+Te6LOFYO8pB3L
eJwDJWOBPlJxLX3mg54gOdWeexdDgGuwZ9PVSV6e2KMp7z6VqjscMQfsuGp7pOYgdPqano+O
LGDYmPIDUTJwGkSTIUUH+myDquak7lQlJtig0l2ys5wHzO9OhtEEpjKZM2XRfWkCOwcTUJ5T
UXGohybUxDiI3uXGhJPbqDSBI98EUdCp4lmlY6Cwkb6pklxHuWq23U6iOlvTZBEnGM2u/0gr
YHhgMm5YJUiLtre9Ttsy5g0aB3ZXKE6gyhtLfYafeiCn3swXr7gfj69v1oaNhUR9r73paPom
ABOnQRclUjWCrfqh33VwpEayB+q0LbqJxzcM9PuOzm4mS1Hz+vjy1kfuZY//mTR6mx1gSTnt
GjyULltKwxrMU2q+wF9dTZziZI+/bO5p7HK6+C+oNOY0BpV3Vi3YvLKsnAb38UNWH46OjTCH
jR1uMqC1yD/UZf4h/fb4BqfpH88/yFFsMYtSTotFzMckTiJnaSMcVv+YrNdlhTbQPgDAMyHR
fQzTFx46nb+wC2zmDja8il048xHqlwEDC7mWajtHwiaHGD8mB70snjKEw1NMocdGOsMJo+AA
SgcgtiopLMnqysj1yWt+/ECTYw9E5z5D9fgFM5zYawBPPfhG7De8yXXmFgY/WPsyAfZxIDwO
vr8mCQE4kiwhmdQpAodPj94vIYdGXd+43lk1S2jMvdMYqqgYQC8I2ovFiIMChLIHEIZ8s1LP
hu6EUU9O1agamIEkeX2uj4HJH/X07befUY59fH55+noHrKYWVbulebRcBp72YWKTNBPadG+V
GhHduZZNYrKU8W48NnnJegfoVRbtq3B+CJcrZy9STbjM3AZso3xx37ZKc/VwVNlkKVT7oVNp
zU0MUG/j9e4dYk9OlMLnt3/9XL78HOEo+GwW+vvLaEeCoLb61hTE9S7/JVhMoc0vi8uw3x5R
WlOB0Ya9S7P1FbBvI87TVbpYEkWoJe0FyDP0+sZDgDG/k4NWnLsr1YA8pdGDdJ9VmDDgf8y/
IShH+d2fxi/TM1tNAd9IGTZdccrZM/52bTY73drSX91xy3v/IW7/AEqCY3C6XM2xiSB00B5m
pRvMXHjk9ontLmYBA+JMwCbgwjLj9jEYxTHL8AdvV+6J0CihFK4GicnY+PxmA/HRlw5kIMhA
qLhKENdbj517aPQNvGrXV/G+JR3FmCKjOjRRfOJrwCw7aMhE6yV/daqtvjd79NYX1sruZXNl
eMoTYlkahEGAuolYh3465bbbBpIavzrhab8m2Z9z1qddI1OxBVWLGoE1NJpU5PjEWShR76ib
FQHq6THlZXCpx8WIkEw88YbLUdp5RnB5fvsy1ZNA/FFlrbpMqnl2moWWwiLiZbhsu7gquWUG
enb+4L59UO1BeS/5+dbINNdDxzCDLt7MQ7WYEfkRVMGsVMc6wZu9k7RyTe9BrcyIqimqWG3W
s1BQe71UWbiZzazcYgbmpo1yeqMBoqUn0dFAs90H9/fXSXSjNjN+A9nn0Wq+5LxVYhWs1kTy
BgGoga+HQ6eaT1I4K+tkx18dZqzxWBhtO0KLiVPbTsUpLYCRLh1oh+T+Lwor8hpOkoD6kXPJ
uQwGtg1PSOMFz3sG9niTc5HpmR6fi3a1vicpB3v4Zh61liPPCG/bBe8I3FOAQNytN/sqUdwV
Wk+UJMFstqCCqNMTY3dt74OZs0kZmJup9wLshFJH83LE5TmOp78f3+7ky9v7619/6vTAb388
voLo8466N1Z59w1EobuvsLSff+B/6WA0qCixm8P/g+90cuOOgYIBp1pTEsvK1N8rgAJTXd6m
eXl/+naXywgEktenb/rhqjd32z+VlW3TOpVEcTrhBUNXO2mprjEmMyDac74GehWILMKs6PbF
y7g+EOErqfHGv4L4pIDyBaoQV0in6bJ0HLpdj7ueTsQQk2llfhgjEuZUwuxJIHp///LXmOr0
w/PXJ/zzv69v71pV+uPp248Pzy+/fb/7/nIHDIzQRw4FgHVtCsd+Xjp1oce2rcgiEMSEyonb
1BGxgFLWqwEI2VlHjIEgB+5QGJGVNQKkgoiPAe4lqyQ7yMJX0heL2+OhUvfbhTp0snTef0KM
NgumU7sedi4qpgAYZt6HX//6/bfnvy1b5SB39imI2Z7UdtM0vdyeSMr9bbpiSFlnAhsIzl5Y
UZ1OJHdVOivTdFsKNvJhIOkt0tOWoy1qFQbeT5oE/CJOJNEK5G4Gkclg2c6niCiPVwumQAPK
eJYwiH3VzFerKfwjbBc1jWIcB0dKho1s1oGdE5RgwmB+bYohQcsVLdT6fhFw6UzHxsRROIMe
wuBXpqkDtkjOHH91Oh+uLRslZS52jICtsnUYBbMlh4k2s2S14qpr6hwkrqsz7CQFcG55X6WB
TbReRbOZdyoNKwOj/Qe7wGRR6FQAsKuROwohcYdprKT6EXUl0GVi+k6ehvSOHPSLNdy3F+h2
9Q26e//Pj6e7f8D5+q9/3r0//nj6510U/wyixE/0AB87l31CZl8bZMMOMXdRORahEsgAoy7G
+jtG6XvyhZG+Xy1Yh1lNkJW7nf1OGkJVhD66ePtlDVUzyBxvzjCh0YEZGNCKWLDUf3MYhUmr
PfBMbuEfBqElCmXfJBpkXRlurGjlfpLTL+fhrTyijyCGVx4NTt/XDDnrnJFod9u5IeMVkYFo
MSWiJNuiDQ2FNZmS0FdqmGfzcwerttWraNK6feWJSdJYKLrhV/yANgNjlxKuV6CFFFHfEAsq
o/uWniY9AA8NpQPK+6eTLo70AwU+X9iY9w+6XP2yJMb2gcQI70lhZ8W2sTkIDr/QtL0je33p
3zQP5v0Zf2dhiY2/swC9WTifiIBpTkqzAZ6ga3288tMxd3c/HXcKU9AF4yVr7e4bwDukNnxQ
5vQmC6eRlVVsROQ5BxQy25Ytg5m8CTAgpgsZ9Kk5Cw1xiWMqXQXnXBCuuVIW3ulAw8HXhRjg
1FSf3F48pmofubPTAF0dY0B18TmCzcGjaVgMJsLjyCPCAAqC99fCvIHhklrpcvplDkrrdJ/M
H2r2vZkeZy1t2IVZr07TmwUVLEcQk/umP6nbebAJpttROmRm9vflDu/FnGOlmhw0+J5wOQUK
k0fbaqf1HJQBPeTLebSGtRl6MSgY4x1cYvInaS0s8NEO8d2YPDlYeahwKmuK1cI9zi40uSdc
QtN9gkMdOh3WgsfmZYhE5x9IxE4OGXMwVv5ScTTfLP92dx5s9OZ+4YALVc3dbj3H98HGHQXH
DmMEtzxij7EqX4PY6T06U2GswRTopiwy5/A+yZQsgbqcylSDaNDfl3o7w52e8b6rYxFN+AF8
X3Xq7GfUJbnbbACK7CioGYKTpq37Af7eh81QYCzWtlmsifJOOnlrEIaZ+GgPIqyy5XIEoR8a
tZSWZYWuaBeLuytnaTjb5vSouHy4GGd8F8w3i7t/pM+vT2f48xNn+kxlnaB/PucF16O6olQP
loHqGu+hNOgZRj6h3gOS9ENx6dSL6FYWMf/iq7baU1Js2e7IS1XJJ50pOJnEqPluJvBGIhHc
AZKLCEPRLUMagBrhTd+QeSK/T60Pg1YIj2f5jr9tF5Gipm9oPyo3ZeaG//bQLn4oBBoUmYue
pLED43RYW6mfh8UMjlnm9GKz7YeWvys58p8I8O6kR1y/Ku4max+6yLmvG8Dmts4K+S8y6+1a
dSx2SY7uIESYrCMnMN9A4DBg98UBO1sGLhO8Fp/AItvFaoCW+Wb299/8vaRF4jm2hhol7DD+
VgKPcDazn2WxELaJykVGo7E+fn57f33+9S+0MivjRS1IVk3rHn/wXf8vi4zLsdljKlPqFRRP
Y25OSRGXdTeP2Mf5CIWIRTW4gA+fZ0DawyjldzPKYJfY207SBPOAv+6ixTLQ0yRU47mTpZRN
4vr9Dy01NwmNutXGXHy285iBrjb25M0G5PzFNSWBPbJoJH8QUrrav2cOJNiq0hOHPBId67Im
xijzuyu26zWVP0mJbV2KOKKub9vFwvphwlkw6DPJEusVcIPTuQCv4AkgynEXpiRFS07oyBLm
G7krC/tdcQ3xXskjM8tmah6I9DmCFK3dkKaPvUeTNjqmO0gn7lzDvM4BVv9Ggl6UbItJepae
FOmcmCae7CSPN1ZvL07SigYJs+GfaxrRnFl6RC5YjgvsnOtcFyc+mo+2WdY16wJo0aiICH5J
YcdxUErMd19wsnIM54L9qJGB9DmGlUS3TJ2BCE9ojoFz4JFaY/Y5GEpgxwfGWUh+KXxDwnle
eYBNNLApb3woxM6XsU1CZx9jSn2O9nKSD6JHpqKGXZ+7badEx4+yUeTtzd6tM81PH4P1JIFH
X8q8fXGd8/4ozon0MJDrcMlavShNHy992d8D9kEpBJP9Uf+kF3w7a+3DT+/SB9zJSsIi2x1n
6kAwrQF/GqYu0Gw8FORUsJh5Mn4BwrPsJBs6mebB7EC/muzGH3Mnfrbv4VzUoJnajqen1WLe
tl6/sPyU8yH86kAvlvAXY6NEKJ4iSrImtsMD1fHhl6vO07ZDw0VRWjM0z9pFl7BZTLN26Sio
GoSX85kDS6udcLiasldYYxm0KNlCF6DU2ecYBcj0zH+ajKxnFA5qvaYSt/kNDCyaz+v1onXN
jQ7XEreLW3u5JlRJzsnWlOyhtr0n4Hcw8zyBmyYiK27Kj4Vo3HpZsgQkRD5brU1Vl0XpeA66
r00x5W7Xf5Ixa8khNOWBPg7f7MuIHeo+j2pS7GRhP0SDT98SFg8JBsilNNqZskkKhc9reIbe
mPhufRaaBECY9Ofp6unq+CarOkEp3psm8EJWJI61nSXDLD7+9GA9lRI56rg3yZLEl1FtoCgz
0JHgD93PLEtgGvURYBQQxXgBbSkkI7y/N+Xtq0CUYs/fmM9KOlYWFW3C2ZzT061S1Mot1cYy
ZUsVbGaeSaPyK4nwxq6KMFqKjfWhZI3eU0jFTQ7zG9eF9UEGOmTVYY8IQzK9E4nPCL94q7hM
+bsB2saj1bl7UVUPOUxjrhHalEJUH8ypVFDDnTyyy1Q9FGVl3bbh/Uyb7XIRcTBbAyOMmmR/
bKzd10Cuf2JDbayYdwAOJxSVlS1mNT4rHGF1uq0Wn+Xnm/Kr8VO9tKr3WxWtxKxj/JbZytpS
eXuBFcEhvdJJ49jqoThJPR7/6uA5FeCwZN0gUQQa7pYti43tyWggaMwuZG6b8g1KNlvB2nI1
GtZfhAZh+q37BydHCQKIiKnOxsB3uYBLYvSV2u0w3HhvKQPGeVzKO4T7I6hUyhlYRYwXbpYx
MY8dQG8/6ZwmiXa9vt+stm57ejR0mL5Dt3gBcH3PAI0x1umEwSziVoxMFut14FZ80XglqPHC
065eKbWbEIM+z9QUV+v5Ogw9nBDbROsgcHhhocWa5bW6v8JrvdrYnPRLwDZIRlV2VA5Mh+a1
Z/FgwzO87G+CWRBEDqJtbECvQLhNHsAgDnqabURch9kgoE7YjYhmMnaUBGVHm6V56VI4FRUt
cPoogsCdUKJZz+YO7NOUay/duEAty7htR9ll+CbuKIFF7hZRDaiwLbfo0DAKE15GzkCeJJyX
KrGB/V66gxUe1jtzsWR1KfQ/aBKbzTJnU3JU9PXgquq2Ku6fFB65IBi2VXzPil1PiL+SyBnR
eVWx2RaqPkW/s91VlX3FinTa88zDQ6dkaOirPiqTFf21t6UFwI4pLdh8vZpC+4FMyuF1vv7f
iimHSfF0mimd+oGcEoiIRBPZkIM4J9RlAWFVshPqaPlX9Kn21oEnpuWC5+JREAuH/f26bV2m
8MdnRUf0XvFXM4iT1d5nPTg7ooWJOnnRL6qcnzHN2T+myR9/unv/fofO7+9/DFTMMXX2XSrm
LXwI/4C9uaZT0meQJem+hi1TxYX9Cy+5aLy0TaF/drGqXFAWlHoe6k/4E0F3fzy+fiVPwtqB
obrQPo0cOXZKoFfNdRI+qZ9Bi1Oe1rL57LZXVUkSp6J14RL+XyTl5JPPqxVN4GOA0KcfrUsu
06I4iyZsKzGFKUFz654sjyf42VVOtGIfhPLjr3ev2/CQF+9iXEPAJOmnhUxTfEsnG3LeWDi0
Ovtufg2F0i+BHXL2+RpDkguQ2NqDySAw5uj49vjy9e755f3p9bfHL3Zapb5Yie+nJVyeMkPw
sXyw0mgaaHJigcbuRrrQF/xtChySBx1KQLtkgIGwyGuShKBaLtd8sKtDtGE+70LSHLZ8Ez6B
POPZIy0aT+AfoQmD1Q2auM8sXK/WfDTcSJkdDp4A2pEE8zbcptATL7nBqonEahHw4XKUaL0I
bgyFmaE3vi1fz0N+37Vo5jdoYL+/ny83N4gi3op0IajqIORvz0aaIjk3nkvpkQZTTqNB90Z1
14xRl4ErsziVat/nHbrBsSnP4ix4xeVCdSxuzqgmD7umPEZ757GkKWXb3GSWN/hmn8e4SPal
a5sSPiVDhLwB0gmQ3Msdh5jHHDSWDDQqt/RSfYTv0pCrc1fb92kWomPfG7qQHCUswrxsGL6o
a9Ui4lBKxskZ0+XXbMVN7tk9L7wnL5hOac6irqUn0cNIhMFBWcbm0L60Ft/7LOst21aN3Drv
sDJkmDudTbl3+eqzjOEH012f90mxP3JDKtQSdFYGgQeflVFuxLSV4KYSgrs09WHsFLsjrlIa
q+yYRgYNrK99e9XWEcM+VVKstu5JrV8VItPK/NaCOIxFJKzjkCJl5bPQE6pdE3GXfYRiLwoQ
vXdsAw5b+MFiGFWmx6qklqCwnwVoYXysef/duIMp0GLd7PL23sM/7ljncuFcB2qQnTgPIXZ6
PA3Jtw4knc2nEP0hpQMP4z6E2qWn07aHhC5kPptAFi5kuRyEtv2gTcgP5Z0bhWU3Tf/Ev/tc
ABYYFI5KhS40k1sDvWjAGl4L1jFZ43rHLoYbgHInCXFfpI4Q6WVpRB+7IUeNYorsRJ64uWYG
WFcokC2vFOoy0tcjMMmPwewQMJg0X89MdvTeJZAbj0s8O6OjGAEflMLHL++YrdVN8GFZNU5k
3KLepbWpRaHMA6E0vL4ZCC6w/ZnALppzQxD4WqrH8Rjfctysu6p5sEM/dDSPBnvGD5a5yeha
xFbiWX3f17hDFT1EmYgTNs9Y2QpjzczovNZgbaqxvanQKIQiOnuaD0jY+oiyWX4uaeyUpO7q
owZ7UUa7HfsUqs5+OXmEy0CVZejS6YysER6FRS+0f1GUGclMv2CHbn7eR9hBB/TlOwLUwcH1
edhenx+/TTMR90OrWxNZLsgGsQ6XMxYINVU1HFmNfuXambeULlgtlzPRnQSAnISdlCzFKcFl
r6VEk8VAkdb9G0Ukrah91XpUEUqSJwWoLGwUFaEq6u6oU30uOGx9LPCVvZGErShpmwQkS9aQ
SXtKZb6vifmHkqxK+HljNbYJ12smE9T3l58RDxA9l3QINROD4UwpOBfyDu3ybvpxmxw0x7kd
ukXhLfPF2JeZZF9R6ilsoYEAvRPpo8qZmlQUFayNf8QHK6nwyoutcUT7MbYwM8Fagk2P3Ub5
at5yHdNjho+8Nt79Mf+xETv3dQ2W0H71ZYrD4dLPqE+WASXaimNcw87xSxAsw9nM1ypNy3yE
TSzTdtWuphNH1NMeRRHFN/SIg0VsWh84yLoKJwUAdln183DyFbBOu6y63q2aRhaYHePo3lKw
FLf7Qye3jrhZrBG3GeB+9zmYL6lA5Bwfbomoqd0HSnoUhqdvj9yurxOGYDk4DT2e4/vTkKKb
iD8Ii8jQ9uE0k2GVVS7/j7EraY7cRtZ/RacX44jxM5fidpgDi2RV0c2tCZaqpEuFLMm2YtSt
Dkk90/73kwlwwZKgfOhQV34JILEQSACJTNzw5JVyJ4BUHucgV33icHqKL1r5AQ+JsGF2biSD
wrhAnBrsUtLgk/OpTy4FiZXU7pJjJ4zklstnKkIUNJ1v5f0ukLeGEHJRoBn2aHFGqTlp11Wl
sNEYXdrwl4/3dl12Vrpkf3zoEACjv20U896FulEe5fae7Cam7KaQOvKQswoya54Y0lkbHfjC
ltPR57UXzA9xhwz+yTFVOKFkxjtIQVXmW4l4yXpZHZoQmLwx/qxmmSOB08ULvYOXGJvjdTuQ
xmXINZUhka4HjNPSt+cbQuDB9287b2NHxmXHEGXGNc9ispqpf7Mzdi6r6sZwNTrF9ljpThyh
oGAfYaJCbxtzOAVxr+FlxI2QvGpi+/FzTmjtViXrbpw57ZCqgcqQWB/PU4H19+f3p2/Pjz9A
ViycO9WlJMBE0+S3fN0jvRqyje9Ywl+PPF2WJsGGsg1UOX4YsqLvCqrUujpnXZWTPbBaLzn/
MbAE7kTUgpkam4CP/mrfbpd4SZjvvIdGp/5Lu42TzBVkAvQ/X97e6UgpSp24xymf8sU0o6Gv
N8TopsqWqM6jIDTS1HnsuvTVA/+QY/KtJYcU5z1IQWdVG72Ehp//etYShL0yjKejlYWVLAgS
W2sAGvqOXixak4bUGw4Er+XIMSOh4yagy6f319v745er3zBAw+jv+x9foPOe/7p6/PLb48PD
48PVLyPXz7BRQI9oP+ndmKGnM+sdGXLkBSv3DQ+7QrnBsPKSBqPIVNTFtadWTtVTJspFOHAo
m1+1YBPI8KmoO9nHF//OrsPNWdW/kdzaL5z4mMjSNQcfoqtq7T0oUoWFkGmP8QPm0q+gmgHP
L+Kbunu4+/ZORR3ijVa2GIr8qE+cedV4epF9u22H3fH29tJa1BRgGtKWgcpUq9kNZXNzUQJb
imGFTqjHm2cufvv+p5iGRtml8SU/0bXOJ9ogH47kCyCEqvS60Kaxiod6485D9aoLryb6YxCC
BSe+D1hsS6G8os1y+VK/cI8xQBnDW8gy5icJoFR59VoDVRdbVDXE5gJkWjHrhKgF1HdvOKiy
Za42jAu4qzAjkhmnnoUjMfF0wiLEaGGrSjE+1VSJy5ev0U/aIZCgqeFwOFGMdomCZoa4xyIa
zjphIdiKsW6pUosvX9SCunOqOFVcaKbskz2iLhHL3BhmeYdeRThHuSstPhh4355L0tMLQGd8
VaKKoRt+I+32pvlcd5f9Z9Fg8zDpXl/eX+5fnsfxoo0O+Ke5hEfq4i+EDs+LPENVhN7ZMVqi
sgUxZB35JuogHwYfuF+3RWMUdzFMjin3NqksnPz8hH565WXtwF3KpDabSSLI0NBBPi/3/6aO
zgC8uEEcXzL0xWIzvhMm1FdoYtQUw6ntuXUrOoWF9ktrjHEiW+HdPTzwSEKwSPCC3/5fnlpN
eabWgXxwf740FxCEfiwxwP+kA+4xItYCSBsGnArHLOnGEpj+2F9D66zzfObEqhSIsLMbOGeT
ziNNmeS8ldeDmRm3HKlJz9gmqtzAAsQ2IFEdWhyE6+AMdjiw0+Fah6Qy4m/FNH4kgGbCBvSd
f6nKGnTswPV0jrL/rM8TosH1uUtKNzszlGmGB1lO5VY9zrIzEkEqvtx9+wZaHy+C0Nt5yvyU
dvSDdQ7jybwdnYfTmiYoBNzGIYso9VbARXPrepFeqw4dbp01KitbnaTPfyI6T51fdtlBPrFY
aZdZj+bUxx/f4ONVZscx4g+3rJO7UaZjN6+0Ae8k6s31AqteG2S6nrfMwnefvt4AI1WNKzci
uziIdP6hKzMvdh25xYgWESNsl5stpbVJX962pNsBMfDSxAk8TQRODHSipvkeBtg1rH03v6bN
7WVQ3U9zQOwSbMmqzk82PtH+OOPYEg0dCwMnDo1kHIhD2qxv4Uhc2vxR5vBI7ZTogtnl9eog
3g6ahfo4JsoLRv68uJS9/cRSCB75yIpDfZ75k5tmKUwqJR8qIavy8QulxNWHp/h8XJ2a+X4c
O/oAL1kre9wUs0SfupsxysV0am7KIiyE2XZdRmWjNGdHJFOFBZ3hKBlOyZEhTy6ekE8zuPvz
f5/GnZShpwGn2A5ww1F5MlyQnHkbeW1TETlqhoy4p5oC1P34Qmf7Uq49IbNcF/Z89x/V0Bpy
Els89OdDbbZnBlYXqmSCjHVxAnkoqxBlgqJwuL4t19ACeJYUsezuW0nhOzbAtUruU4diKkdM
56poWDIQxRY5oti1VKlwNjbEjYieH3t4VrS4C6FUjm35GV/3ZZ2yUxZs3IUwpVZO4dC76sZM
Jejmzplmszkq6fCVIjKainKaZ5dtOsBoV0rnEWp5EiI73G3gA1FUCpxQ6eQxK97sIaUJyAyx
Y0saU0ecCoP0gU90tpVvg0YZFWKdNqlBnJJvP3uqe2gNUI/6dfCQf6YqM8H5cDlCL0Cz6rHY
9MppWsNUD6C7Ad1eHKHu1c6d55znjp8TIh1Uud2xqC779LinTkOmzGFNciNxdWYUPGKUuZ3C
okU3mGoEOhqMHos5/8RUsg7LWOWBQuLEoX1ZCY6qiyMvooRAJKZm0YlBXRqWIvlAMoFq8EPZ
94oiYxKbAAyQjRuQDcShhOpZmcMLIjrXyA9IIIjldXP+Tuqtv4nM8c0HCN4hecmG/NInk7IV
Mfsh2chKr+b6iP8EhSPXSeMR6GF5+dbcvcNuhnx2PoXayiPfpceLxLL5OyzUsFgYateRw5mo
gLJkqxClfKociSVX31KcG0WW4hJY51eLG6Kz61C5DtCKFmDjOnRxCNH3VgpPaDkzlHmij8Te
yFG/ZoD5ESU0yyIResYsDA3DMvKYTmXRzmTnnPGZ43p1hnO33ig5Cz+IQodx4CyPkWYWvmzo
L+coJnJolsGnS1rTBoaCYxe5oAHuzNZFIPZ2ewoJ/ChgJlBnrh/FPkpLCbMbQPk+DrhYrgi0
rwI3ZrWZOwCeoxvRjRDoJKRL7QX3qHSH8hC6/nonlds6tVo2zixdYfEpMrHggZyuxZlcQxyt
Mvyabda/MlAKetf7YNxhUPnU4qFr5uErA3UTrHJEZkeNgG54qIKa3aEEJuQ0hNYOLhm9Webw
XGL64IBHDgAObejXmQqP5a2nyrMmHWpMrkvM9AiETkjIzRGXWDU4EMY0kBA9wg8mIroJBOav
TcwYjjGkFkUO+Ikl2zAkdUiFIyDmdQ7Yq0GPjzrrfOeDybSuzhiRZUe+bJtDg2ZhsKEXwowO
0DKNgTr0icFXU0sXUGleavjWEfWR1RExAKo6pr+eOqb0aAkmC47JghOyQolHUslqJoHnk23M
IdJeSeUgpO2yOPJDQjQENh6pSjVDJo5wSja05GX3xJgN8MERdUEgonoNANgHE22CQCKfT8xA
xz0emUCbZZcupqfTNiOXWn5OnlDt2KkWVnMCmoxqqEdVb4tee3aFCcBaeMl2u45RYpUN6449
OsjsbI8jRsbeD7wPvmbgiZ1wXd8v+44FG+eDjFgVxqC5rI46D/a0ITGWccWKYnIsCwgN6Y5V
Olge3Urcfuyur0TjUrFeZWDynOgDpUYwrS6nYrKNSbUSsc1m82EZcWhx5jAPu3MBS9wHsZo7
tnFgAf+IKfDDiPIKMbEcszxxHGKCQMBzyHnznHeF662tYrdV6FKZssPgkm0HgLfW7oD7P8j8
MmIFHg32qILyuoB1fV2fLEBl35BHLBKH5zrEzAdAePIccvuF7qw2Ub1azZGFWjYEtvUpHYBl
hyDkL1BqNa6FjNOzPYf8tX06GwYWBVQz13VIqWigE7henMcusRanOYtij5waOBR9sKeG9o1X
R0rZpJ5DqIdIp9YRoPsepcYNWUSsR8Ohzij1bKg71yFVSY6sDSbOQDQV0JXA8DKd3uADEpDR
VyeG6zIN4zA187weXI/Sw6+H2PPJsk6xH0W+xWurxBO760cGyJO49Bs8icPLTeE44NuES9aX
DWCpYCKnHakqPKH6BEUC4ZM60G7IVabiQFlzch0rld8XCAKGIRlKdGvATKyoi35fNPh2eHyX
sgRqdHTm6ehxuegYgVNfco8C6P3SonRMrFOktX2LUVeL7nIqSYclFP8uLXuYo1M1XArFie/S
hYOMlayNLAl8FpEqERnQ5PGiexYlOVdl4gZjZhfmxfWuLz7b+xZDGfBX57J88vXUyEhdGBrv
kyaKEQhrBpr2lN60R+oqbuYRb7ZEwFUR0TMnikDfPtzkDXKTo3rODNy8yTChO9293//58PLH
Vff6+P705fHl+/vV/uU/j69fX5RL8CkXDAwqCsE+IORQGS7onvcLIY3G1rQt9Z7Uxt6lSsAW
ik0evRO7WmObTzDW7gaiMxWyVJI0uMSxp5lUHHXKwGKWBlDozxDRBpzDIxOjHZcTJmupR0ea
pky3Zdnj/bKJcDLrCKSuIKdc9tYgrJEJ1t0AjI7rUK1xIivDbYPXqoInLPiMl0qcVmUduY6L
4pETRxn6jlOwrZVBGCvp8NLQl9Rzx8pPdj8//3b39viwDKjs7vVBGkfofCQjJoV8EIbNk+nL
B9kAB5UNQ0c0LWOlEuGXyU8MkIWN1vxyqow/PadTT6hOxLeHeqplNVVYqAUbJcnLdjWHicGS
XjxtnOM+0dKrTHoJI2oxZttmdUpki2T1l4jCjRZcNPeMU2QmB1Pg5EVmDWC7KmUHmpt7WM9q
ZZlScJuRvmDSLTiWF36/f/96j9bRplPt6VvY5XowEqDgbZerKKLoWE1YanrUMS1PlA5eHDnG
8ogYyBkkjsXpOWfIkyBy6xPlMpJnzg0ONCmFEYJyKIV03cx5oekvQiWE0e7VsXlm62glHSeT
r/ZmVD7RnInq2fFCpnb4oi/KzDe6AtcRnzoKnlHZ0gPzGdcz7QmIhKC5Ki2Cblk60UKiCPkA
eqS58haO05QHKrwTMtdXDGQkonpPIwNab6Jta8ebi6gHgsCvPHSrOqDJ7xqRoDx0xNK4RWxW
t7ni0AcA/d0c0uKYh/KliMYI4uTQsX8UeNi2CSL6/GRkiKIwoeo7w/HG1z8FtGmJzO8AyB69
jZvxhDqhXNBYK2kIxQGKmlHR7Dx3W9OuBItb/iCYjKQKiTXbUQkBFe5oSTSZAy3STRT9nnim
W2dcnl+NpvWWwmRrXpk8BI7FIInDWTAEsR1nRWaN3oRwuYnCMzn1sjogX/Vy7NNNDCPMM9NY
Aq6k23PgOKuS3LBM3W8hdcBw2r4fnC8Dy2hLAmSbrcgVGppRERlWNf2ImPdQWtUpddiAVuGu
oxpFCTN0l1rXBBRpExNlt77QE/oseZIaqkNO3HMGcUgVl7gOSfVoqrkqzogxnQICU5Z68DSc
qo3jmz0tM4TOZnUonCrXi3xyUFa1H5B2ulyeWvU2wGlRFYZn0lk4olnox9F5q9ULqIl/3hp5
fa7PMe20gE8x5ziwLevjuwxNDxFEs8knwGhxvuJ7G12wUx24jk0PQFAfA6cap2SCZnwvQN04
9oEJsO+edRWAYrH5zJhYAuejXJJkY6tilie+7Dtl2rzOQ0j28mDTbefE06WXlN9E0qP5LYAI
WHLdVkO6V4btwoI+eY7c11bDjrUlosTCjidb/GCLTGCwg1awF1MAkdeoXqxmkGZDHMs3BRKU
B746NiSsgT/UsiuxCA3fkp7vGdbTT0o8kVwooavJdTVURWRlVEE81yIxx9Yl3qVN4AeqYduC
WraeC0PJqsR3SJHxxteL3JTCcBmMXCtCVpTbIVvaFjFySlNZYsvIwHthzdu9hSuM6Gl14UKV
NoipCzCFJw43CVVLDoWW/hwV248liJMPRpqhzSoQV7lJbNyX6CueyhGRdjAqT5x4lgy6OA6o
K2aJBbRulxw9iHi05JOmbiCm7ixhu+NtoVw9S9h1HDu2nuJgvD6NcZ7ElsGJeuiw4JJia2LV
PlDj9C4Y3uG70Eh0qZPyuFo0Mnm+reZCRbQEI9DZyDe/OlMcWioSBq5PNgDHhI8yW9G2t5ca
W0IqzQaTvTm53kllkZkfEToEoYPjVaUl7n2PXkqyNocFmC5E+JWTbv569HVWgpB1O8geVWDC
1m73RpLuZ1rG66zQAtzIaF+gm0jSgxPGqeyLtL5NO1WGfdt31XGv+p5B+jGVtVIgDQMwlb1S
s8kVhVYN4bLQIoeWxXnbni/5tXzqUaBHJ3wlJrwkL4ePXx4fnu6u7l9eHylvECJdltb89E0k
p9VGzigiMFyG67/Bm5f7cgAF7W8x9yk+yv2Yj+U9xaXWBnbpS0vMGVyXeYHv3K9XHtsJHqF9
1mWDsWbTZl+Yd3w1b1UqMBMXAV3afyQmHnYTYqL0kzeCKTiYUTwTPfn4cFXX2S94yj+5ZFKE
yW543DKoUF+jKxtLNe6+3j89P9+9/rX43Xr//hX+/hM4v7694H+evHv49e3pn1e/v758fYct
wNtPk98SkQvuSVJZiNllgYEKGb+/vb98eXp7vMqvt1e7Kdcp0+Hl5fkNfYzAxuLx+eXb1dfH
/y5lywXYMuI8+9e7b38+3b+ZbvWu9zCee+kTHgncweO+O7J/uaF0qdibDq9ToC2uK2d5ZLLg
y7qrf6TfH55errKX7vUFAGjUn9DR0e9Pf3x/vcMNlJLD30rAU+xe7748Xv32/fff0V2SJMwo
906b+cYSyGQ83fbu/t/PT3/8+X71f1dVlpuRspYJP4M9dJXC+BITOHX/A/NcVe4Pg8KoXLDM
HKNFwGou3ammE1s3LgsLf7l7Um76FzDNQaULHTpzDloCQUmyEc8dzazMzdsCVrUf+uT7FY0n
oaoAm4dAPVJTMPoV5MJCnUJKctv2lVL/KQ8ppbKvA8+Jqo7OeJuDMkedZ0tl99k5axoq7/Fo
Qj6V+GD8igH8ArPa8+PVw9Pbt+e7adozp4j8WNeqA/1pyvkgg4nPmH2mnFl7bJTDc9bkxvxy
KHNTpoPyjLLMl9fRoKw0ezWCNuA2zeiIuVMA5kl8i2Ld+fZ4j06aMa1xi4kJ081QyFc3nJZl
Rx6dRSf3x7MmrCBq4XBUhq4jHUvPmKwqcSKT7dk55YgBW7VGLKpPZaNLsy2GtqOD83C43G+L
RokLhOTsUPTqY3tBLeEXHWCL423P0pI+xhL4cW/xZIRwnWZpVa1kz5UOS0UyaJChxE9p6wSy
G2UOCiVCrw8MrH3b9LRlHDIUNTOaphAh6xVKkam+EQWVvvfh2K0Wp0wZtzWo29oHst/JgeGR
cmgxXq9SKKesDbz9EMa+vf1BJj7GLYJ9uilUEY4ZKNKywRUST2kFA05vjOuyOLG2IZdGLtlN
P5nXSVQMXa2VWQ6Fnvev6banI7cjOpzK5mCJoyoq3bAS5hzSJwUyVJnmlYITi1wnNO11q9Gg
dcypZKLij05pqBkhv1ZE+2O9rYouzT1lWCK0TzaOICr5nQ5FUTH791+n0IM8mp0qZQ3d2LfG
bFKnN9z6xJIb34nu9W4Ugazb3aCRW3TCXhizDI/2agxEhaUZSKeFHOnLvVoObE6KTyqpSxs0
2Kxa9fZXIq99Rl3RQIs1pCt+DsOW8Ub2hMapMHXCWk4SF22AhtXYbDKS6UsFbLsa7DhhhayK
3ZcYZ9jWc5AqN76tvs2y1FZRmOuNlh2DROr5sLVlgz9QR1f5do6hSKlzuhGDEQ5LfaG1EciB
8eFVYl+Xumx7jLeWMuvKwqMt/drejJkt6o5Et39gsCZp0wJMj6zQ54/hAJNQrdPQybvp1Vam
r41TjB5yunSMtGLhU3XWakWeylI9r0LiuYTxrrfabdG3WHNL3rc3OehB+kwg7Osvh+OWpI8e
H8UvTeGpOiXsAaXFzU7DSKWTB/bTFc+uVCaAkceIdix5FpPzXpy4KwUuR2LoHl5XUWVfzXKy
OaiaXIAkV3vIyktVDkNVXIoGFCGpbaWzGpWovyzi0dGL/KLOkjw4eoW+heXPRaRvGm1XxAMt
Cied7HKQZzTlMPEojEa1dE0DE2dWYFha6chUnMA8vd0/Pj/ffX18+f7Gm3qMlS63KGYymXB3
Rc9K0i6Uc900KVqw8SMwrVbtsNd7HUiX0wHms8qeJfJsKz5Vs0EdxBO8U306jM3NeHujlxm0
2qUP1HjzwB4DVH1YX3LxPORfngzXi2c6PhIxKADpaFopPwujs+NgT1lKPePAEh2pJOT0fLun
bahmDqOTBXU8/lOhYilKp/b4jgHa9DIMBDoMOGQYbEuotEIERXhO3zHah64sijAwt1RwZpKq
ow6b89FznUO30rzoHcoNz2a1dzBgIDHV9PxNqueu5NpaOq2dJSZ9/SssTP9eW6K68hRhKfPo
+t6KqKyKXdes/kyGFmop6H+cPcly47iS9/kKHbsjpqa5i5qJOVAkJbEtSiyBcsl1UahtlkvR
tuUny/Ha7+sHCXBBAgn59VzKpczEQiyJRCKXVNu1mziJonAyproA1YAJs6UL5NcCUISQK6Xg
02+s1gMkfTq8vZkqApmFVhsaLluttFN6K7wKKKkFMHXZe56s+IH73yPx3fV6A7FMHppX0P6O
Ti8jlrJi9Mf7ZTRd3ohcUCwbPR8+Og3z4entNPqjGb00zUPz8D8jCGat1rRonl5HP07n0TM8
nhxffpzwh7R0er9bsDUYvkoDigjtJtqCBD+rbCPQt5HUySzR5qZDzrhshoQUFVmwzFNfX1Uc
/39S0yiWZRtnYvtkwIa08apK9vu2rNhiTb/zqITJMtlmtnXZEa1XeaddIiu5STbWtd3RdA8l
fDjTqa2ifMWHZhp5Ia0JFrs5Md9qYFcUz4fH48ujmehKMKwsjfWpENc+dEGAh8TKeI+V0NuW
udBfyQmw+4mEacZX4rjLVswnQGZ5ftEELpCpCfAGsKSWPj1PhwvfQ8+j+dN7M1oePppz/2wk
+AWfm+fTQ6M4QwieUKz5xC7vcO3Zt9Q3IUL8IsD2bsjTvntFw7MhiyYVM2r0TAhqY354eGwu
v2Xvh6cvZ9AOw3eNzs0/3o/nRkplkqQTUeF1i/OfRoTcfzC64VFns4BfYy2CAFLI3kCya5bD
/XGmS6aLArIkJDTUlEp6jLkORPzGyCGB5rnVI8BtZyOV6v0mEUNCPKmKPWi8jvfFsOxLHjl5
WUTa7HGQF+mDm2TbekvbXMhO3LLcNu7LfL6usbJLgPUh6FhNejdOI32z3QlXWG3MMk3FJOSf
Ois0bar4ANCAZ3yUQf7V2VjBxePp7dzGC5daRyFddMqvGdMNNt8UfVp/SzZc9jMObT29hiY2
sryWYsOs2NVbi1GzXCig0ZlRycMBfcfL7rQJ/S7GZafNM0jF/K8XujtdhGH8hsP/44eOT2OC
SA3PI8YIchLyseW3EfgMdfVWPz/ejvf8Vi14HL0Oq4XC0FbrSor8aV6gfCWtjT7k29gyytga
SskY3lray26L+aSvwba9qRJ3V1Ax94YIyoXd8lG4xXmSzcnIx/VdlSvng/i5r9MK3QR6KClz
S+wMpgmHmpCILUh4tlKLzGfM9zzH6IIwiIp36vTVH6/Nl1TNXPdb1qh57Ng/j5f7n6ZqRFYp
MugVvuhn2FquKeP4d2vXu5U8iRRcl2ZUwplCMEnZjayC7Eggk1t1MNdrRHcGSPPOvhU18sUq
U/SDX+rX6Q0B6pQHcYcBK5W9noEWyHWeIYUDYdciTVvsl3Wllk6cQVWzbJFaLOVLyN6XWoIx
iW4VsxJuDIT9Dsd2UXHxl+t+faILmyJdL7Qs4Go7pUgti7w/WzCGpNMxcj0oRRI93oCcE9Rq
RnFOUWLLV6hWy5YtUh2SLYqILwCNsrucbNX7oOjb10VqfHq9Zotimliu00BR1ujuU+YlxACh
UrSD0gur8oVuSJiVqFUM0L3x2IKJphs4YlZwFi++QSjj1Tw33+A5KbXdRA3Cf4ayvRywntE3
MOAgwyEKrG4cLIAyDYpZVQu3u8kJKot9vOwMuHoFZh85mLSmabFhSARe6nFqZKEBqH8UACNi
eKqY9pTrsJqB/DAQIS249QQR6fAl0LqnbgtMXS9gDo58Jqv7RseBFcjrYd7k0su82JJZTa4C
00AdE9j8a6W+NE3AbNnodb1Mw4lLukz2Czb8qzsUh4UvdCB/PB1f/vzF/VWcIZv5VOB5Re+Q
JIR6URj9MjzN/Dqwavn9IEeV2njLoJwaENx2NJB0OhyWn/aRhHV4/z31+fj4iE4OVcGs85ZO
7wxBSYxOtLg15x+LdW3BlnVmwSxyfhBO88RWUn3U1D6wpUgt2VsRUZLWxW1RU+YSiE5PLYyQ
3ZsB1vSKQT2+XuDu+ja6yJEdVsSqufw4gowBie5+HB9Hv8AEXA5nfv/Vl0M/0PzGwQqUGR1/
sjBTtvazSmgbCUS0ymstPaBWBxhTUSptPK5b5IeepGkOUSuKJR9rBey6d/yYSYrlMkdWZC1e
pOzmB+SKEjJyzn/2nI3AOwxLN+qDiUAZT1abOt2j3G4AMM5HAC5SfjLf0TGwAM9x9XpBDSVg
dae9GhIKK5k8OWB0fOEz/+OAVF1AWKzqmZ4UrodXGzWORw9GCbRV6H5b5CK4FEZnm1t0OYPH
QuiTcSPriKU7386sJZlOw++5qhEbMPn6+4SC78iaMsbvZGMbfJ/yNb/d3NH4caDP34CxxNZR
iCLkqNbCCT+zFgMBgSa0a+NAoQcuQKgJZWbaUWxYmPpjjypcsKXrOXSUUExjiQDaEe04Celm
1+JFSFyPmFSBQKEzEMa3YqyImECUgVuriYwwvA2HZHzU9Kvv0SYe/ZInPIYokonmiDngDDcg
g4hxiXZCGih3FLPSd33i6zZ8X9ANc0xIZgNSi+J8Gx0mL33Ho2yH+6K3nCAmegNebT5VJcv4
foyNcw68F67yEJi9iWW2J4Fl4xM7U8BDGh4Q9Qu4hbFMyPEWO5zMkNePzmSMo7kOMxF8NlUR
8o5H2z64wnBIR9BhJ3kutV/LtBpPtLECqxF+nu61lMGQx9Y8Bwimyi9fn/eFGG+x0iYpydkk
zsz6gB8mPulaWq7tB3Y7454lnoJCEtKu1gpBSK+yKA73s6QscA4zTPBZ45HNfXkgGXufVzMO
4mv8HSjimN5D44Dcc17g0Ies1R1eJSB5k4zCdKUoq2/ccZ3QmyKI60/mEkjIuFcqQUiIKCUr
Iy8gF+r0axBf3YqbKkzV8LwdHBY4se0Vr2WxpE8vX+DWcp2R3pr1zGr+P4diLEPEKnOAhDO1
sd/ghsqEU9v1fiiWdXD/U1vIIFiZML8yaueo6XZGGV+xu1W6nxVLy5NHW5DCSRRE/ZyBWEtz
gZaIXyv12Lat6lfrmfLasN21D0bUkwEyXgM9ZYGspAFUwXDN8xWd3RcoMn47aClwbYn6PAAA
fttP1+gJus3raiSNBgS/y+2M3my2jB4iwJYzvvZJ7O2M1JJBlJHOC3NoHKDqyMjfEFNrawDR
Y+oAg/fCJL0zUNNkuVxjvUaLKVYVGdS2a1yL16OA+eEBJsL53rZsy+P9+fR2+nEZLT5em/OX
29Hje/N2QWaZnTfnJ6Rdr+ab/E57nWpB+5yRcfTrZF6slItlugaXFbUCCbG+fvdoqa4Qm6b4
nu9vpv/rOUF8hYwLISqlo5GWBUvNRdAip+tVZgDb+6fe8yrZWP2bW5KCdfEmqfeCrh4wLrT0
J/bCEC+6FpFk/B8z6KmKTaBi11EDFpjoEGdIIAhc+ugiKC0pLEzKiFRbGnSeg9XkJoFHXm4N
Ot9VDzQTHarHoIlGURR79BLmJfLUwPcYN9751nKxGwU23AQllDJwMTkkcD4X7tiSdEMnIwOO
GkQ+0YsOR/W+xUXUWN/KZY65Woctq2UKOD6dluclRFmlnh/Ru6LDR75ubqNRFJ7l6DDoLDlX
Wjr+q87T7uOuUWYJc+Lrn5fVPgqi0oHvVuLZzXWIhTjn3GxRZeZY8NNxZ85SkVbSrchsJfkq
gkB6DskSft/41zt/A1rRrW772Q2TMIHnQ3CdR/Rk9mZakiyxtlJq5W1UpC1iN3h5QA9DCWaa
X69Vvyr2UejRIZNUkms8EAgix5xsgI9p+DKZVim5KVbiiKG3nsSVpLTUkmzqLPSooWARmR21
P2ZV55mhOS7GcAHGwMjo2NZzkM8Zn1U3QqbQaGNhL6+hPT5b+zHE17yyploy4EAB1UI/vLZG
hFh2pYGv20S4M/JWKqoBYerXf7rBOepJ7NJq0qELvIqIfmsd2si25tKR4FmimgIiFCvmJbXZ
bsub2Lm2iLnsYvIfEGiIyoScw65syBv5Fz2JmIcCvTas82lZnxR4s97WBfbm29Qs1HTc8omC
76a3S2si3N9IZeyQ+/vmqTmfnhs9uEvCr20ulyboZ+IWq6fm6gKM4FplSy+Hp9OjiLhyfDxe
Dk/wcse7YrY7jkn9IUe4OGIah3ixpQfXWlP706H/OH55OJ4bGWzS1jPIahxda++z2mR1h9fD
PSd7uW+sw6F8M87aziHjgO7D5/VKJYLoGP8j0ezj5fKzeTuiViexr400hwRkq9bqpANFc/nn
6fynGJ+PfzXn/xwVz6/Ng+hjSn5wOPGl6ryt/9+soV3NIr1389KcHz9GYvXBmi9StYF8HOPE
my3IEhu9w3a2V/0StzUlXymbt9MTGDd8OsEec7vglW3Vn5Xt3RSJbd2F0Tj8+f4KhUQYkbfX
prn/idRFVZ7cbCtyQi2llcLyKr03Qj60++rhfDo+oI3DFqUltXGyyjZrCELA1tTgo7ADkGwE
3o7zUiiiMEJka5BQZVPKriiP8XW+n2clvy3Q1jyd2Z18gadJ2H5WzRPI7UPrgVYF7ySrEioC
bLnGF3f4vU8Nn1YVu8otAcsAaY3CC0jaurdTk2g2Bh0YvmuDI2Z0KCrMl0aCnHg7oGFo0iPW
dJi0AS9D2V0lEhEgrnRpk3wzu2SanfffvymyeZ5hW+oOib1tOygKCd1361tpAhk55ChydAds
LVl1KEPuQ1UR4IBQraPI25/NhQodpmGGimZFvsygAW0ptugbLstot48WZAsN3qHRt3VANGAd
MMMynXDRE04L04RWXG+/0VEXO/aUcxmy3s/om9fX5ZzqNt9s+9t8lYEjPA6UUrmkZse00+1Z
SFVURkh0CLaxz+k9my74vst7/07SnjdfLpPVekf6vLZZpxfrGqJHUqUlARInlzdg6cI3Gj8N
BvAC4l5xHOTM4owMX5sgHibHda8u6en5mQs56dPp/k8Z9w2O6+GEG0qAHnQSxLq03WFZWlou
8wNFVVBd2bMi9APXigpdW5NFGFBxyhWSNEvzsRORdadMboHKUr1hx9mH9yKHrB/9b3zXrFq7
dznGgpKd3s9Ueh/eFIPAqZ2GvmuFKtSvhaRYTtfK5QsMrzfJvkTAgn/Ldp+ooy5BWiTQOYhB
x/uRQI6qw2Mj7PZMDzhZGp4o5iJbol7vgNkvq+QzdP9opY6/QZlsytsx/Wr1Wb/1WsXTgIWj
dBRtAISEsZpv6O2cisfDuwSpXrdICm1h/NLPRL+nd1AJ/9NVajD6TfN8ujSv59M9+bQvwtuC
1Rv57URhWenr89sj8XBZlUw1y4OfYNWOdGsSKiIhzoUv04Z0MZZk/SvX0CXUtBRlee9/YR9v
l+Z5tOZb5ufx9VeQSO+PP/i8Zdpl9pnfwTiYnbCtQycOEmhZDkTcB2sxEysjWZ5Ph4f707NW
rjuF1imXJdKS1VP1E8lC8qa0q36bnZvm7f7AV+DX07n4auvRZ6TSdva/yp2tAgMnkF/fD0+8
a/oH9aVIvHLursGpxViku+PT8eUvepDaVIe36VYdI6pEfzn5t9ZDV39VdulDO07V/qQSZnaJ
RkUOzKKsluD7neVloj7AqURVvoEzGNwY1U2ASEA4Zfw0JXaBStenj7C0xBlBcZvrH0FEFRm+
eJ9zQYZ60M13dTpEK8n/uvCLnjWzpiQWaVR/T1RHrBYxYwk/0h0DjiXlFgihM3w1ucMA11JY
tYiqXoUosVgL39TxZOwnBpyVYaiavbXgzqFxQPDr6Fo1iC1UZAHv5NvZTLXKH2D7dEqCwcmn
Tf2B8TezYiaoMLi19eZXDaot+V/VjlkpY5CKVhksyJ7EU04msHz4Zo+i2+LJyodeiuXUrRpD
bdgdYq3SUJHFOtBEBe2WfhAaAHwx6IDoCiGAqs1xCyCp9Nxx0zJxyYQEHIH8OPnvwDF+4+5N
y5QvTWGbv6ShdnrdkS9LPLJfWYKSPPAr0iZTB1IAVMMlxaxINuQrvOtmx7KJ9lPviQTSmrCb
Xfr7jeu4au6u1Pd85MSXjAOURVACjJyMLdiSkJFjowhXG6NEDxwwCUPX8GsUUK0hDiKTUO1S
PqdqV3dp5Kl9Z2mCXz9ZfRP7ajIuAEyTEGnv/h+6737V7sXTBsSXqhN1NY+dibtB+2Xsqg/e
oAiPIvx74mq/DdU5aUrPEcEYVxU5xu99MYNcR/xumCyX6vpHaG1tgeo6om03BCreU49FgIoN
FfiEtiQXKNuLxTiOKWtujph4vtbAJKBtSQE1oXWHbaZSLfEdQsexju6ucCkkK3HbTIX97oes
mvzkwtDlysN0i4KfncrqWOzGKteQ3hh6EsRlnXrBmB5FgbMYygrchJ5FiSOzRyY711ENmwHg
oqwyEoJzmnGQT1q5giYhUj+yTCtfSzsFoMAjM61xzASVzlf77645SKtkO6ZNViHXYZY6sasG
IGhhqn1TBwuYo/qtSrDruX5sAJ2YuVowgpY6Zpq5sE4RuZYncIHn1bqh1hwbT1T5isPqZRqE
qjJlyMaJl10rvO+6Mfu7L28ik8Io17ItmMj2avf6xEV8jV/GfhShtgcqKRT/bJ5FfAlpkotf
8+plwkWmRXteklJBHsVICoDf+qkuYEj6SFMWq6urSL7ic4pff8cOdhCBThQinTqbV6TTN6uY
etLefo8nO6Tu0b9V2iMfHzp7ZHgukpqnYQgVeUGKktjnWkMPEuIQEZOsX5UgS9ZW0SnK5b2e
VV25vk9YYGVVW26xpXNMmFUggbbWmqVxaOI0XDtp7aOpXMt8WR/kCrW9EYeOxaII8vJF1MwC
Qj/hwsCznXBhENDP4xyBhOwwnHjg6styrW6A0zWEE3+Dq3C0p9Iw8oKNRW7j/N/VErfBkRCR
Pi9QVYwEC/ity/FhNIl04ZFD6Ux3AhGj4uPI1YtGlMYXEJrE5DuaUBDHpDVLxoJAS/MZeb5P
M2p+cIUueUKmVTDGfmgAmpAHWA12JPxU8drwAQgchmNXh419nOm9hUa6EU//pn9ltfcmJQ/v
z89dbgqVhRu4/5CZZJp/vDcv9x+9icC/wI0/y9hv1XLZqfCk0lroZQ+X0/m37Ph2OR//eO9T
2PSzMQn1BGtI722pQjpF/Ty8NV+WnKx5GC1Pp9fRL7wLv45+9F18U7qoHjgzLmg56irhgLGr
MsS/W/eQMefq8CAm9PhxPr3dn16b0Vt/rvU9gtu2o7MTALrksdLh0E4UN/YIfehuw4IQHYZz
NzJ+64ejgGnXgNkuYR4X/cg7pnLizO82a3R/Laut76A08xJAMnhZOtkVjEaBJ98VNO+zga7n
vuegu559QuTh2xyeLj8V4aODni+jjYyN9HK84Pmb5UGgBgyTAMxekp3v0M+RLQoFiCLbU5Bq
F2UH35+PD8fLh7K6hqVUer5L8d5sUasyzwIEWUeLs9+HGC+LDEUyWNTMU8Vj+RvPawvTFtOi
3loOSlZwGYu+wwDKo+3GjG+X3I7zkgsEIHluDm/v5+a54cLpOx9LwmIuICemxeE9JUBYwiy0
TVUQm6oYNlW/pdYsHqu3qQ6Cy/ZQ/Cxf7vApWaxuYW9FzpU8zyqNLV10u6GWrIwytiPH+8rI
qtsSxgpHn1ChgwZVhmIR6ZkI1vg7X4LaQZhkW7iZ0hb1yZIf46Q/elJlbIICXQnIBE3ewh2H
2m91stPS99zYxQDkG1P6KFgT/x1FWL01r7yk4t1PHIdKctBLwGzpTRx8ucY4j9IFCZSLhRJV
w7i0ZRhoCaqN+pj8O0v4hVd1kK02Do7mVG+Q48vylvOyQLVO5vwtCBxNbQAQFDN4tU7AzZ2c
03UFLg00y6h4Bz3HimaF65L51wChqrNZfeP7OBwBmGPdFsyjWGedMj9wEYsXoDHpx9ZOW83n
BkWGEIBYA4xVVTkHBKGvjO+WhW7sKSfsbbpa4uGVEFW7dJuXy8jx0ddJ2JhifLfLyFVX/Xc+
AZ7nIJkJb1jpMnh4fGkuUolKbOWbeDJW9aE3zgQpdFple5nMVyTQfBkYUDZuxpGceVDfqCx5
qCGv12UO+T+Q8FKmfugFaNha/ihaFcLGlflelGmInsg0BGb0OhLx+w65KX2kgcNwusIWpxnD
krMl53EIQomzdqrw9oy9fzq+2GZc1USs0mWxUoeYYk7ytWu/WdcieZXl8CGaFJ3pInmNvoCF
7csDvwO9NLqKYrERobs6tYjlZU0En99sqxqpTxSCGswjwdTxk4pEXCNKB0N3Ft0YXk8XfrAe
ife60FNZRMbcWJU+4boaYFNwAYppDilxtuutdgAByLVEhAFcSCaNFqWQs35dLXWR1/LZ5JDw
IbuoEdvKauI6tJiPi8ir5Ll5A7mF4FHTyomcco7ZTGU4LHQjv1xwFkpF6soqph0m6IjNGXkK
V2gaq6Wrqn7lb7zDW5geYrRacqZHnVolCyMsS0mI5fGwRSJGBDBfeRRo+WGXD5CAklc9iUE1
12GAtTeLynMiql/fq4QLXcrttwXgljqgxveM2R/kz5f/q+xJmtvYeby/X+HyaaYqi/fYU+UD
xWZLHfXmXrT40qXYSqx68VKyPe9lfv0AZC9cwE6+QyoWgOZOEASxoFW+uyjK06vTc+fsM4jb
dfX87+4RLyIYW+Z+96rcOpwCpYhmCk1RwApMRiSahblxJ8d09Jnc8IsvQvQwMR8gyiI8orRm
5erq3DhBgE7Tvy3i89P4aNUftv2ojfbtz/wnNAn+pLyir1zoWmHu5N8Uq3j/9vEFVUfmrjY0
mlee4JnA/6KkkUHWM57V/lSiXegPkWhWt0m8ujq6OD6zIcZ7UpIfHRmB5SWEYrkVHBhmoCUJ
OSFDDrPV6fHlufGYQo1DR59W2lUMfsBWNtgGgiIydhxiVNDnSo/OgWBch3mmr0WEVlkWW3Si
CO3KoH4n0LNeCIZ+NOMZLhLR5tSSsws/Dyb73f2PLWVWhcQViPln1DUJkSGbC6Oo583+3jWn
WiQRUsM98Fyn9llfIa0ZotRwK4AfdrRDBMmou6cmTEaovewrxWAqdw+7FzfeOAafKVijYqkM
kpJN3/OfHDNBGLnJ1FNhhZ7qpnSJKRbgg4xXenpcYN6ikl7rRRbHpnikcK0ZJf7ijM4apQg9
FuQKWUU4VnywfMtn64Py/durNCYcBqANBWM6gEx40syzlMlY/yYK4+jnK9acXKaJDO2vd8BA
4rcU+wUaDvOTm2GvESwtaVXKAC9Cj1qDqDbLo6zNxFQA6n3NNDhKqHEj4IZCSsnmOPUFomUj
172wEt0wLuFWijkExLkxOAWRzWbwHuu4uHIQ0+56rcfYJEphpcJ64j6cvi+sr7r8doffdhhO
9sPDP+0f//t0r/469Ndnmp3bvmad1MY01UcXwHRgWQhQe5dezyrxeCPQfjtxRmm2PHjbb+6k
1OCmNiwr2tdOzXM1I2eZKLLXGuZT3RpJOQrkOBSW/RUSNsm06GlKR/dvUfAFlb+up2pNDExd
Z4dMGJ+tshMCq3y4DDWfqg5TVt2KFk9U3NaX4wJR53dhFV2IqeGTKIFBGDudBFgTJlQlPZqF
tVuQuWsq0Z8q8Cdl5Z/liKBmVP+g37UJfKDt2TLSNXT4q3H93Mo4SgwOjwDFgnhVGF2Xl134
OxXcF4ZIBuSgXx3NU1C9Gu7QA1WyHt1Um8Pci2aJyYBVcGRDG8VQBgb5F67LOStK8kYNuChL
mOG6I1bVieUwNmBOG52ftABgg2W0gjbELqoUvC6MZw7AnNmlnOEB34QgDGLtDq2ngjOrAr0L
Z94IVhI5r9NIZcnRGvJ1EhgCP/72FgNVJxM5A+ZZHZXIc+kB/CoRWoVW14aatY55ynFScchv
UM+D2R2o2ldW7fj7ps50I8uVr0GIILOCIiJLZeCzLoC28VGLQw+6iA7Wj1RLVtAJ0FddT4mq
p2F5ojo08AGuYGRZk8o7MWkUu4WFJz5y34pE2dpc2QrSJmvJ9HxnGKawQbAVvgI9LdApd21Q
kB2CgkXKi3Vu6/YG/EKYm68H2RHGB8SkjuIqStEKN2WYP0pvdJlmVRQamy1QIEpfpzCW8B6y
vgwL0nIxvNpgVjXolDEfcq2SAyEx6LYq3a0k+0XTW6JJkpJXuq1uXWVhaXIkBTNAoWRQZhgY
AFEXIRUTUP84g6GN2doDw6T0UQFnRRNEhuBPkbB4ydbQNLglZFT6Ge0bFNVWnvJSXDsrb5w8
jXIFsygH5HeEiYCRzfK1I6fxzd2DHqM+LB222YIk/6I3b0cxA/aWTQtGC3cdlcMyHIps8hWH
05NMWdLg/tNjAvUwe+9omL55ulTcDoAajOAjyLKfg0UgT3XnUI/K7Ori4shaal+zOCKzf91G
VuLBIOw+7SqnK1Ra4Kz8HLLqc1rRjVGu47qqEr6wmrZw/cu1rztPUJ4FcAKAOHp2+mVQSYR2
YRLknzyJLpa03ET3RV1yX7fv988H36k+omuo1QoJWiQep36JxUu0zkUkEDuIObCjyszZJ5F8
FsVBISg+PRdFqg+zpc2oktxsnwQMJxBtCy1pVqyqyAgcQvnhC2ZGA8P/hknprr7u6PXlYNBO
ufJlRBKdvRWY6smZYBb4zlQWWhxXyJONBkEHyrILZTqot52ydVQe156qJ247JcgneEwccuGv
+WvoiiTdeAOf0Lunfithwcqf0qKSitJbljc1K2dmizqYkiIkhxr5UlGpI0Zbhx0W74FJDhJB
OjWTq9gUMoQhbTZAUeJJb6XYscnlCiaadKvsYNzy41va8FgjoKLqDRXeksXelqND35zJ5NcT
GU7hlh4jkUxEEIjRYsKCTRORVk17HmJZp71ksXIWXhKlwATI1ZUlDvUs96/Tm3R15tubgLtw
CmuBfm5dtC2geCime9Z9AeRvPC1ivLLiCjGfv1oCmDsdOXDYDn3Wo2nblp5uxv+I8vLs5I/o
cHmQhCaZt2N2z7uDk+xk5pD9vsa+wMP77fefm7ftoVMwV8mTxrqJIQv8dSmxZzjEFgbzri3+
rn43y0JFpOyrqkcXlSgy/xqGG8AyK+b6iURd9mKtFfBjGJrd6/Pl5fnVx+NDHd3JLs2Z/kxr
YL74MbqFjoG5NEPaWThKR26R+Av2NeZSt8yzMMdezIm/maRbmkVy5i34fKRg2rfOIrr6Xe1X
pxfeOq7OqfdS63N/332+kWYTv1APxkgCcjsutebSW8HxyTltJGFTUQYiSMNKHkXm4He1HtNg
p7cdwjfNHf6MLu+cBl/Q4C80+MrXqOPftcq0JjQwlC0HEsyz6LIp7M8klBJTEJkwjkedniW8
A3MBQg6n4Gkl6iIjMEXGqogsa11EcWw+rHW4KROAGWnftBBi7pYZccxuHhCItI4qqibZUWjf
SF1VXcyNWGCIqKvQWOlBTF/g6zTiVmLlFhNlzdJ4jTWU4sqdbnv3vkeLiiE1SH/DWhvyAv5u
CnFTY5p0n3AMwmkJ13mUxoC+AOHXvCK05VBGB0UN3wVdtd3RpXR1Dhx+NcGsyaA+aaVnyvGt
Fhjze5TyFbcqIk4d+K6mvYMYd8uuvPasJDA5q7TZk1HQZqwIRAotr2XykHzdYAYNbgYPdIgM
0dMpIYQivHENw6yQGsEyqwtOiyRS181leZiLeybi3H5SsXtWwjZJa9pxfSBKfI3qSaosydbk
LaKjYHnOoFkFOZUdEgalpAJjuYSWwslDABwfBqOi149Fqi7Qglq97ifDawlZdJyxII8ontCT
rJkZ2HAYbRaiYUJE3oqGCuBCnC1TdKLwtGAgaAQr4jU5gVILL+lQ5SJiXGZcNGmW0kvMQ48K
5qnnacbzicTCBgDeHluPVWOldeqz0XXlEAWMzNAKY3eIXoH3z/88ffi1edx8+Pm8uX/ZPX14
3XzfAuXu/gPmFP2BPPTD2/Pj86/nD99evh8q7jrf7p+2Pw8eNvv7rTTVc7jslPMGoy7i4wGw
QF7FgvXR+5Lt4/P+18HuaYeeLrv/29jOjBGuMdjUMH72hIyV370u9OXQVJN1IegImiP0yOX+
g28WGCGgpJeS7B3GkEK+6cn2a5HiO71GqZ99nsHs0P6p6t3G7aNy0EHBEZV1k8b3v17eng/u
nvfbg+f9wcP254v0cjWIoU9TIzqiAT5x4YIFJNAlLec8ymf665GFcD9BnkoCXdLCyITUw0hC
7UJuNdzbEuZr/DzPXeq5bpHQlYC3d5cURDA2Jcpt4e4H5gOcSd1HWrQew1uqaXh8cmmk/20R
aR3TQLd6+R8x5XU1A5nIVHNKjMeGscWKFPZdbxGSv3/7ubv7+Pf218GdXK0/9puXh1/OIi1K
5rQgcFeK4JyASUK7lYIXAZ0boe12XSzEyfn58VXXVvb+9oC283ebt+39gXiSDcbg+P/s3h4O
2Ovr891OooLN28bpAeeJOz0EjM9AoGUnR3kWr81Ep/1em0aYyNLdVeImWhDdnzHgSYuuFxPp
Wv74fK8/6nV1T9zh4+HEhVXuguTE8hPc/TYulg4sCyfEDOXQHP/8rIj6QBZfFqY9TDdoAVx7
qpq+tnStxQCFrp3a5vXBN1wga7rMigKu1MjaNS4S86zvnDu2r29uZQU/PSGmB8FE0auVRzxt
8ZOYzcUJNewKQ794dFVWx0dBFLrrmWTf2kq260oCMnRxhyQ/iWBBg2SWkFfmjl0kAbVDEGzG
9hgQJ+dk3p0ef2pkO2t33IwdU8CT8wsKfH5MnJEzduoCk1OikSCrCDHJyLx+LeedFiq9iAle
5qpmJRTsXh7M0MsdWympfSPKxvMm1FGk9YT0+uvwBT8jV1m2xBDjY0VzhsHCozEmzVADYEX8
0XAu90SoOzmBcJlJKP93ecyM3RISUMnikhFLpGPnBLcWRCmiyFWISntBUGNYCdqgpkMvM3uE
/2qjnb+g089Oj6LUD4R8yXC59m3mwC7PKMZjveA5yJnLw/D5pVuexebp/vnxIH1//LbddxFQ
qJaytIwanlNSYFBMplamUR3Tcmi74QrHxpekJOLkq7xG4dT7NaoqUQj0D8jXDhYFvIaSwTsE
LRb3WK+c3VMU5lO7jUbxfazXjmGPK5/DvSe0Lx4/d9/2G7jo7J/f33ZPxAGKcQ8YsfUkXPEN
F9GeT26+W5eGxKkdOfq5IqFRvVioleDsAYNwZDsAHcV6EN6dmiD64jPy1RjJWF+8cuTQ0RFh
E4k8B9rMleMwD8MsCtPmy9X5itpiOh4X5ehWA2JWJejWwT3ZJmxCbOnR2ch5gaQJg4khbj8a
ruGCum8AAZ+JuIxcXog4O+WxhkI92coIsqu3PYmzacSb6eq3eFuVyMp1kgjUKUs9dLXOBYnM
60nc0pT1xEtW5QlNszo/uoJBQa1uxPGlW9mk61Ocz3l52eRFtEA8luLarQ/2TW1FXtN2LO1L
p+YcajOweM/EUgydYjRFNXUulE0MGsXKFlsmtopLYdiW7/I693rw/Xl/8Lr78aR8Be8etnd/
755+aD5lWVDHaNIhNf7Xh3fw8etn/ALIGri/fnrZPvYPz22KJ+0loTAcVF18eX2ovem3eLGq
0MFkGHefYjtLA1as7foopawqGPgjn6P1pLdpA4Xk7viXamFnmPgHg9d6EjuHwLBmmGMe3WIm
EQi7mLlRW4TyLQOOhRmJ7XzeQEpOOT5QFNK9TF82OkksUg8W8+fUVaSbGfCsCHT2ql56dA/A
3uOOR71PRre/sMVof8yTfMVnSslcCOP2xBvOQUQwQMcXJoV75+JNVNWN+ZV9GQRA7+tF8kVJ
AMxBTNaXxKcK48kvq0hYsfQtTUUB00VXfWFJtZwWHbn2tgwHknsT5tpVT118teGvg6iizuqC
pUGWjA+PbkA0FIlQZQhnwtGqDeUgU4K+Vae8BbVsoTQoVbJp8mTA6ZboBk0WmKJf3SLY/t2s
9OCWLUw6TeYubcR0W5EWyIqEglWzOpk4CMw355Y74V8dWPuW1QKHDjXT2ygnERNAnJAY42bT
bWPifRTu3kFTZnFm3DV1KD4RX3pQUKGGmvCZ8UMab1UyFLluhVsB/y8F8g8K1sx1x3sNPklI
cFhqcFaWGY+AjUmWWjA9kB2TbmUisUHob9AYrA3hKudZC0hln2VQ/wY47FR/ipY4REAR8kah
JwqREeN5zKQh20xelSwOinWVoqpzSWw44/R4uBAX8vXOIUFAmqVd2RhTPzexhXBAXHZNKeW2
3zfvP98w0MLb7sf78/vrwaN6xdnst5sDjHT5P9r1Bj5Gqb1JJmtYq9fHFw6mRBWWwuosUEej
eS20lU09vNUoKqI9sEwiRiYWBhIWg9yElqvXl9rLJCLgdugzpC6nsdoo2qjd6GdinBn6Rfw9
xmzT2LQW5vFtUzE9Xl5xg9cZrYokN5MXB1Fi/IYfK12njU7Q6P4KEoCx4mEXdFt/EZQEQ5iK
CgMlZWGgbxX9m0YPcVGic7ke86GEM9Dy1ERTkHRKDogWWcUSnsy33E5GldCX/e7p7W8Vj+Rx
+0q88IJwnlbzBjtiSO4KzDENAqnYUJalmOoyBqkr7h/TvngpbupIVNdn/TS1crxTwplmkJNl
VdeUQMSMfFBfpyyJuGNQsU4mGd5vRFEAgZGACK0l4F/7uHutvcJ6x6tXku1+bj++7R5bifZV
kt4p+N4dXVVXqwZxYOgDVnNhhPrSsGUeR7Qzl0YULFkR0qKYRjWpPC/lwQSdPKOcVOWIVD4j
JjUqVGdCT5MUwqkkpJPnNdyuL//S1m8OBwnGAEgMLlYIFqi0dSX94DITGKEDfdzgHDAf6buN
msMqRb4VoQeqcUFRXYVLD8rg6MOSsEo/IW2MbDl6sq6tE2PJ4CBQncsz6XZY2p1u4e6kKbuQ
JdoNYMYiyw1Cz5L4Z6voLz0FYbu/g+239x8yM3L09Pq2f8e4otp6SxgqBeC6JsOcuMDe+EBN
7fXRv8cUlYppYg+vbnQ23LvmsIb0scDftCHgpCStDCVcO2207fhHnTcbqWx07KajV9O1abbS
F6bxQuRHIBxhzoLWOsMoBfHycKMN6vFrEDRo3YVUWWRRmaWWi5OJAYEELk8pbTtkkd6KInMb
WWQBq5jz4G5RKWdJ0lYsricdkSbUSrDU+VqLoB12kA1b2yCrpg4z0hhlIlSXPqmmBOYTtFQi
DRQvGilvQSVn7AXCliYqqprFbntbBGm6pczsMMWaNOnRxBIui54zXMqO5lWBZfuvjx2Tn2Eh
OuMyw/hEzlsw0h9kzy+vHw4wHvv7i+Ifs83TD0uTksKOBq6XgdhLLicNj9ElamAIJlLKN3UF
4GEysrBCbQUK3aKCRZTR6jyFbGYYs6diJT1fyxvguMCPAztjdh86Y6yvykQYWOj9O/JNYker
leMEVpBgwjO5M6UiirTnBkdmLkROq6pafgHXvSTvk8thBzQe9l+vL7snNLyAvj2+v23/3cIf
27e7T58+/bcWt1FaH2JxMvnzkKBWE9WyxXhUAVkGdndkz+A1roaboaD9cNoF2ebvHSH5fSHL
pSIClpIt0TJ5rFXL0vL4sQhk1xyebJDAlR3lwzKG2XK3eztu6s2sFbvpCmVVsNoxgILPnmno
GxFK6T+Z/0GgAqZRFUYGTSm7QJ+bOsUHY1jgSm1F8F7F5j0s5G91qt5v3uCyCsfpHWpqDQ7S
DlE0epTkv8GX9KJUSBkmIgIpi6RRh1AjDzSeyWizvpi3o12ya+UgeCvLXTdSV8Frg5MMEiyv
ZYg+/9GKFL9ZIEgCgmEjZdyevZ4c6/huuo1yxQ3pQ9fFfzQa7ey4m1Y2LQip1LwVyUUOIhA+
MtGdRJVlytdVRkW4khJBWKdK2pYdKSx5ocdOC5bPaJruThdaK59ANsuomuH93ZZLWnQiIzMB
AerrLRJ0+ZfTgJRSrLcL4e2HqhRNhSbL5m0u826akI/YSU81oORTy6Zc6jolLMnD2FUPaImI
YR5f0ul+EHNkLLaoVNWK3ppis3+kFzhm6s6roE7yZiwheLumKLVRnS5VNDnvTamngMpGSq99
j4QtR/KLZzCdGEi7DsT14ePm7uHzPXb1I/y5f/5UHg4t7ZW9Jvn7011rCvPpQXeojQIglOEc
YXdEAR3pyxxaXS9TbV/fkOmj8MIxR/Pmx1ZzZqoNadJwzjBgYiUn3nHc6NgoajtkKPGv6sJL
e+LIGyBJYy+iOc8WjpQLwiyA2z1ghj5EeorrweaJEtVsXOytHc7AU+aBJ7affM+VT46lL7KN
JPFiJ935KY/kEd49QUu6EbyuufdSyfUOknQzXpgKkuA7I5TAcnFmChF6b2dihdt0ZDiUHlF5
UJH+bC1VyU2nLvV+Dogqoza4REuFXOh8pbSZ/jYBHpZoTBsVSYq6jkawK/km4cdj4KLQCqFk
UhT4Clih4sNP4zX2ktgooK3r1DKdj6zhReLXHKjOo+GVHW3JGsGc1uIpJD7Oz1DjCpyf3vfA
eXEWmgkc4LOEFXPfDIdRkYCUKZw5VkFyaBsCQJCcS5kUkP5mquOOZtdey9Ir0HbMtJZsko0s
HTgIOYOF698I0uggchsHXyKcLBpwXiX9KNt3nHqUzv7/Af5GA0yp3AEA

--C7zPtVaVf+AK4Oqc--
