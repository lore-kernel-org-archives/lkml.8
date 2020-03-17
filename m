Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C94C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32E52073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQRnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:43:06 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33721 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgCQRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:43:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tstu6Yh_1584466971;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tstu6Yh_1584466971)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Mar 2020 01:43:00 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     shakeelb@google.com, vbabka@suse.cz, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/2] mm: swap: make page_evictable() inline
Date:   Wed, 18 Mar 2020 01:42:50 +0800
Message-Id: <1584466971-110029-1-git-send-email-yang.shi@linux.alibaba.com>
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

Shakeel Butt did the below test:

On a real machine with limiting the 'dd' on a single node and reading 100 GiB
sparse file (less than a single node).  Just ran a single instance to not
cause the lru lock contention. The cmdline used is
"dd if=file-100GiB of=/dev/null bs=4k".  Ran the cmd 10 times with drop_caches
in between and measured the time it took.

Without patch: 56.64143 +- 0.672 sec

With patches: 56.10 +- 0.21 sec

Fixes: 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs")
Cc: Matthew Wilcox <willy@infradead.org>
Reviewed-and-Tested-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v3: * Fixed the build error reported by lkp.
    * Added Shakeel's test result and his review-and-test signature.
v2: * Solved the comments from Willy.

 include/linux/pagemap.h |  2 +-
 include/linux/swap.h    | 25 ++++++++++++++++++++++++-
 mm/vmscan.c             | 23 -----------------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ccb14b6..654ce76 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -70,7 +70,7 @@ static inline void mapping_clear_unevictable(struct address_space *mapping)
 	clear_bit(AS_UNEVICTABLE, &mapping->flags);
 }
 
-static inline int mapping_unevictable(struct address_space *mapping)
+static inline bool mapping_unevictable(struct address_space *mapping)
 {
 	if (mapping)
 		return test_bit(AS_UNEVICTABLE, &mapping->flags);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7a..e8b8bbe 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/page-flags.h>
+#include <linux/pagemap.h>
 #include <asm/page.h>
 
 struct notifier_block;
@@ -374,7 +375,29 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 #define node_reclaim_mode 0
 #endif
 
-extern int page_evictable(struct page *page);
+/**
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
+static inline bool page_evictable(struct page *page)
+{
+	bool ret;
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

