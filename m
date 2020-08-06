Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D87C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB79E23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgHFQ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:58:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:49498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbgHFQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:58:00 -0400
IronPort-SDR: WLdqZe4tV5KZW1xn3O0Emg85d3+Vn67AdmIpBEeCjw+MwRhCIGI+pIKGeAkwjR+T4S2gA+e6rA
 T+4+HRfk57BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="153943831"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="153943831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 07:25:09 -0700
IronPort-SDR: ah2anX3z0TQP0vyEw5c+uaJdOGWBrH1WybS8y6rEptf+myvDgodfHn1Rz3Xu4D9TCsXM8cp6EV
 +g8yWwfENwGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="437557111"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2020 07:25:08 -0700
Date:   Thu, 6 Aug 2020 22:37:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shannon Nelson <snelson@pensando.io>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/pensando/ionic/ionic_txrx.c:608:3: warning:
 Variable 'done' is modified but its new value is never used.
Message-ID: <20200806143735.GA9232@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b
commit: f9c00e2cf258d215a1ed2a7b2ae5b91ac2f29582 ionic: clean tx queue of unfinished requests
date:   4 months ago
:::::: branch date: 5 hours ago
:::::: commit date: 4 months ago
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/pensando/ionic/ionic_txrx.c:608:3: warning: Variable 'done' is modified but its new value is never used. [unreadVariable]
     done++;
     ^

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f9c00e2cf258d215a1ed2a7b2ae5b91ac2f29582
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout f9c00e2cf258d215a1ed2a7b2ae5b91ac2f29582
vim +/done +608 drivers/net/ethernet/pensando/ionic/ionic_txrx.c

0f3154e6bcb3549 Shannon Nelson 2019-09-03  595  
f9c00e2cf258d21 Shannon Nelson 2020-03-27  596  void ionic_tx_empty(struct ionic_queue *q)
f9c00e2cf258d21 Shannon Nelson 2020-03-27  597  {
f9c00e2cf258d21 Shannon Nelson 2020-03-27  598  	struct ionic_desc_info *desc_info;
f9c00e2cf258d21 Shannon Nelson 2020-03-27  599  	int done = 0;
f9c00e2cf258d21 Shannon Nelson 2020-03-27  600  
f9c00e2cf258d21 Shannon Nelson 2020-03-27  601  	/* walk the not completed tx entries, if any */
f9c00e2cf258d21 Shannon Nelson 2020-03-27  602  	while (q->head != q->tail) {
f9c00e2cf258d21 Shannon Nelson 2020-03-27  603  		desc_info = q->tail;
f9c00e2cf258d21 Shannon Nelson 2020-03-27  604  		q->tail = desc_info->next;
f9c00e2cf258d21 Shannon Nelson 2020-03-27  605  		ionic_tx_clean(q, desc_info, NULL, desc_info->cb_arg);
f9c00e2cf258d21 Shannon Nelson 2020-03-27  606  		desc_info->cb = NULL;
f9c00e2cf258d21 Shannon Nelson 2020-03-27  607  		desc_info->cb_arg = NULL;
f9c00e2cf258d21 Shannon Nelson 2020-03-27 @608  		done++;
f9c00e2cf258d21 Shannon Nelson 2020-03-27  609  	}
f9c00e2cf258d21 Shannon Nelson 2020-03-27  610  }
f9c00e2cf258d21 Shannon Nelson 2020-03-27  611  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

