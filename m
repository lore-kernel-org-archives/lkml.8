Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A977C4345A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F1820792
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 13:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGYNBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 09:01:02 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54225 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727775AbgGYNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 09:00:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U3l6fmD_1595682015;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3l6fmD_1595682015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Jul 2020 21:00:25 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
Subject: [PATCH v17 11/21] mm/lru: move lru_lock holding in func lru_note_cost_page
Date:   Sat, 25 Jul 2020 20:59:48 +0800
Message-Id: <1595681998-19193-12-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a clean up patch w/o function changes.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memory.c     | 3 ---
 mm/swap.c       | 2 ++
 mm/swap_state.c | 2 --
 mm/workingset.c | 2 --
 4 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 87ec87cdc1ff..dafc5585517e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3150,10 +3150,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				 * XXX: Move to lru_cache_add() when it
 				 * supports new vs putback
 				 */
-				spin_lock_irq(&page_pgdat(page)->lru_lock);
 				lru_note_cost_page(page);
-				spin_unlock_irq(&page_pgdat(page)->lru_lock);
-
 				lru_cache_add(page);
 				swap_readpage(page, true);
 			}
diff --git a/mm/swap.c b/mm/swap.c
index dc8b02cdddcb..b88ca630db70 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -298,8 +298,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
+	spin_lock_irq(&page_pgdat(page)->lru_lock);
 	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
 		      page_is_file_lru(page), hpage_nr_pages(page));
+	spin_unlock_irq(&page_pgdat(page)->lru_lock);
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 05889e8e3c97..080be52db6a8 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -440,9 +440,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	}
 
 	/* XXX: Move to lru_cache_add() when it supports new vs putback */
-	spin_lock_irq(&page_pgdat(page)->lru_lock);
 	lru_note_cost_page(page);
-	spin_unlock_irq(&page_pgdat(page)->lru_lock);
 
 	/* Caller will initiate read into locked page */
 	SetPageWorkingset(page);
diff --git a/mm/workingset.c b/mm/workingset.c
index 50b7937bab32..337d5b9ad132 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -372,9 +372,7 @@ void workingset_refault(struct page *page, void *shadow)
 	if (workingset) {
 		SetPageWorkingset(page);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
-		spin_lock_irq(&page_pgdat(page)->lru_lock);
 		lru_note_cost_page(page);
-		spin_unlock_irq(&page_pgdat(page)->lru_lock);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
 	}
 out:
-- 
1.8.3.1

