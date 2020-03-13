Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB32C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D392074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCMSe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:34:58 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45552 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbgCMSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:34:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TsV0Vh4_1584124476;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TsV0Vh4_1584124476)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 14 Mar 2020 02:34:45 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     shakeelb@google.com, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: swap: make page_evictable() inline
Date:   Sat, 14 Mar 2020 02:34:35 +0800
Message-Id: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When backporting commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more
skipping pagevecs") to our 4.9 kernel, our test bench noticed around 10%
down with a couple of vm-scalability's test cases (lru-file-readonce,
lru-file-readtwice and lru-file-mmap-read).  I didn't see that much down
on my VM (32c-64g-2nodes).  It might be caused by the test configuration,
which is 32c-256g with NUMA disabled and the tests were run in root memcg,
so the tests actually stress only one inactive and active lru.  It
sounds not very usual in mordern production environment.

That commit did two major changes:
1. Call page_evictable()
2. Use smp_mb to force the PG_lru set visible

It looks they contribute the most overhead.  The page_evictable() is a
function which does function prologue and epilogue, and that was used by
page reclaim path only.  However, lru add is a very hot path, so it
sounds better to make it inline.  However, it calls page_mapping() which
is not inlined either, but the disassemble shows it doesn't do push and
pop operations and it sounds not very straightforward to inline it.

Other than this, it sounds smp_mb() is not necessary for x86 since
SetPageLRU is atomic which enforces memory barrier already, replace it
with smp_mb__after_atomic() in the following patch.

With the two fixes applied, the tests can get back around 5% on that
test bench and get back normal on my VM.  Since the test bench
configuration is not that usual and I also saw around 6% up on the
latest upstream, so it sounds good enough IMHO.

The below is test data (lru-file-readtwice throughput) against the v5.6-rc4:
	mainline	w/ inline fix
          150MB            154MB

With this patch the throughput gets 2.67% up.  The data with using
smp_mb__after_atomic() is showed in the following patch.

Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/swap.h | 24 +++++++++++++++++++++++-
 mm/vmscan.c          | 23 -----------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7a..297eb66 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -374,7 +374,29 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 #define node_reclaim_mode 0
 #endif
 
-extern int page_evictable(struct page *page);
+/*
+ * page_evictable - test whether a page is evictable
+ * @page: the page to test
+ *
+ * Test whether page is evictable--i.e., should be placed on active/inactive
+ * lists vs unevictable list.
+ *
+ * Reasons page might not be evictable:
+ * (1) page's mapping marked unevictable
+ * (2) page is part of an mlocked VMA
+ *
+ */
+static inline int page_evictable(struct page *page)
+{
+	int ret;
+
+	/* Prevent address_space of inode and swap cache from being freed */
+	rcu_read_lock();
+	ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
+	rcu_read_unlock();
+	return ret;
+}
+
 extern void check_move_unevictable_pages(struct pagevec *pvec);
 
 extern int kswapd_run(int nid);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8763705..855c395 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4277,29 +4277,6 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
 }
 #endif
 
-/*
- * page_evictable - test whether a page is evictable
- * @page: the page to test
- *
- * Test whether page is evictable--i.e., should be placed on active/inactive
- * lists vs unevictable list.
- *
- * Reasons page might not be evictable:
- * (1) page's mapping marked unevictable
- * (2) page is part of an mlocked VMA
- *
- */
-int page_evictable(struct page *page)
-{
-	int ret;
-
-	/* Prevent address_space of inode and swap cache from being freed */
-	rcu_read_lock();
-	ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
-	rcu_read_unlock();
-	return ret;
-}
-
 /**
  * check_move_unevictable_pages - check pages for evictability and move to
  * appropriate zone lru list
-- 
1.8.3.1

