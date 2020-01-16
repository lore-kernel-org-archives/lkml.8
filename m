Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6567FC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C412465A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgAPDFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:05:54 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39356 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730343AbgAPDFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:05:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TnrJfUT_1579143911;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnrJfUT_1579143911)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:05:11 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     yun.wang@linux.alibaba.com
Subject: [PATCH v8 01/10] mm/vmscan: remove unnecessary lruvec adding
Date:   Thu, 16 Jan 2020 11:05:00 +0800
Message-Id: <1579143909-156105-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have to add a freeable page into lru and then remove from it.
This change saves a couple of actions and makes the moving more clear.

The SetPageLRU needs to be kept here for list intergrity.
Otherwise:
 #0 mave_pages_to_lru              #1 release_pages
                                   if (put_page_testzero())
 if !put_page_testzero
                                     !PageLRU //skip lru_lock
                                       list_add(&page->lru,);
   list_add(&page->lru,) //corrupt

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: yun.wang@linux.alibaba.com
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmscan.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 572fb17c6273..a270d32bdb94 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1852,26 +1852,29 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 	while (!list_empty(list)) {
 		page = lru_to_page(list);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
+		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			list_del(&page->lru);
 			spin_unlock_irq(&pgdat->lru_lock);
 			putback_lru_page(page);
 			spin_lock_irq(&pgdat->lru_lock);
 			continue;
 		}
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
+		/*
+		 * The SetPageLRU needs to be kept here for list intergrity.
+		 * Otherwise:
+		 *   #0 mave_pages_to_lru              #1 release_pages
+		 *   				       if (put_page_testzero())
+		 *   if !put_page_testzero
+		 *				         !PageLRU //skip lru_lock
+		 *                                         list_add(&page->lru,);
+		 *     list_add(&page->lru,) //corrupt
+		 */
 		SetPageLRU(page);
-		lru = page_lru(page);
-
-		nr_pages = hpage_nr_pages(page);
-		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
-		list_move(&page->lru, &lruvec->lists[lru]);
 
-		if (put_page_testzero(page)) {
+		if (unlikely(put_page_testzero(page))) {
 			__ClearPageLRU(page);
 			__ClearPageActive(page);
-			del_page_from_lru_list(page, lruvec, lru);
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
@@ -1879,9 +1882,16 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 				spin_lock_irq(&pgdat->lru_lock);
 			} else
 				list_add(&page->lru, &pages_to_free);
-		} else {
-			nr_moved += nr_pages;
+			continue;
 		}
+
+		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lru = page_lru(page);
+		nr_pages = hpage_nr_pages(page);
+
+		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
+		list_add(&page->lru, &lruvec->lists[lru]);
+		nr_moved += nr_pages;
 	}
 
 	/*
-- 
1.8.3.1

