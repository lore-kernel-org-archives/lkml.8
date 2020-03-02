Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DACC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB075246DD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgCBLB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 06:01:27 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53951 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727775AbgCBLBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 06:01:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrR9JVc_1583146858;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrR9JVc_1583146858)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:00:59 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/20] mm/mlock: clean up __munlock_isolate_lru_page
Date:   Mon,  2 Mar 2020 19:00:22 +0800
Message-Id: <1583146830-169516-13-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clean up __munlock_isolate_lru_page func for later lru lock change.
No functional change.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mlock.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 7ddc52ca14b1..a43b3da78541 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -103,25 +103,6 @@ void mlock_vma_page(struct page *page)
 }
 
 /*
- * Isolate a page from LRU with optional get_page() pin.
- * Assumes lru_lock already held and page already pinned.
- */
-static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
-{
-	if (TestClearPageLRU(page)) {
-		struct lruvec *lruvec;
-
-		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-		if (getpage)
-			get_page(page);
-		del_page_from_lru_list(page, lruvec, page_lru(page));
-		return true;
-	}
-
-	return false;
-}
-
-/*
  * Finish munlock after successful page isolation
  *
  * Page must be locked. This is a wrapper for try_to_munlock()
@@ -311,26 +292,34 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	spin_lock_irq(&zone->zone_pgdat->lru_lock);
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
+		struct lruvec *lruvec;
 
-		if (TestClearPageMlocked(page)) {
-			/*
-			 * We already have pin from follow_page_mask()
-			 * so we can spare the get_page() here.
-			 */
-			if (__munlock_isolate_lru_page(page, false))
-				continue;
-			else
-				__munlock_isolation_failed(page);
-		} else {
+		if (!TestClearPageMlocked(page)) {
 			delta_munlocked++;
+			goto putback;
+		}
+
+		if (!TestClearPageLRU(page)) {
+			__munlock_isolation_failed(page);
+			goto putback;
 		}
 
 		/*
+		 * Isolate this page.
+		 * We already have pin from follow_page_mask()
+		 * so we can spare the get_page() here.
+		 */
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+		del_page_from_lru_list(page, lruvec, page_lru(page));
+		continue;
+
+		/*
 		 * We won't be munlocking this page in the next phase
 		 * but we still need to release the follow_page_mask()
 		 * pin. We cannot do it under lru_lock however. If it's
 		 * the last pin, __page_cache_release() would deadlock.
 		 */
+putback:
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
 	}
-- 
1.8.3.1

