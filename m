Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B82206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgFZWUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:20:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:46061 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgFZWUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:20:51 -0400
IronPort-SDR: jQuPlaECrNA3bIteYV6oN5kYssEgq/b2bTZlx6atXOXS3CDblyzDPOvzXglLcINDHpVcW5BfbO
 gs0lBW4B80dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="207009036"
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="207009036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 15:20:50 -0700
IronPort-SDR: ZRK/Scww/abTcQTZCtwAphfFzhtSJkBRgtZAxUb2dx6iS2Om0bFchbahkgMl53kPUpZvPDt6/8
 HI26odnZzifw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,285,1589266800"; 
   d="scan'208";a="480143426"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2020 15:20:50 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [Patch] mm: Increase pagevec size on large system
Date:   Fri, 26 Jun 2020 14:23:03 -0700
Message-Id: <d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages to be added to a LRU are first cached in pagevec before being
added to LRU in a batch via pagevec_lru_move_fn.  By adding the pages
in a batch with pagevec, the contention on LRU lock is mitigated.
Currently the pagevec size is defined to be 15.

We found during testing on a large SMT system with 2 sockets, 48 cores
and 96 CPU threads, the pagevec size of 15 is too small for workload
that caused frequent page additions to LRU.

With pmbench, 8.9% of the CPU cycles are spent contending
for the LRU lock.

   12.92%  pmbench          [kernel.kallsyms]         [k] queued_spin_lock_slowpath
            |
             --12.92%--0x5555555582f2
                       |
                        --12.92%--page_fault
                                  do_page_fault
                                  __do_page_fault
                                  handle_mm_fault
                                  __handle_mm_fault
                                  |
                                  |--8.90%--__lru_cache_add
                                  |          pagevec_lru_move_fn
                                  |          |
                                  |           --8.90%--_raw_spin_lock_irqsave
                                  |                     queued_spin_lock_slowpat

Enlarge the pagevec size to 31 to reduce LRU lock contention for
large systems.

The LRU lock contention is reduced from 8.9% of total CPU cycles
to 2.2% of CPU cyles.  And the pmbench throughput increases
from 88.8 Mpages/sec to 95.1 Mpages/sec.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/pagevec.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..466ebcdd190d 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -11,8 +11,16 @@
 
 #include <linux/xarray.h>
 
+#if CONFIG_NR_CPUS > 64
+/*
+ * Use larger size to reduce lru lock contention on large system.
+ * 31 pointers + header align the pagevec structure to a power of two
+ */
+#define PAGEVEC_SIZE	31
+#else
 /* 15 pointers + header align the pagevec structure to a power of two */
 #define PAGEVEC_SIZE	15
+#endif
 
 struct page;
 struct address_space;
-- 
2.20.1

