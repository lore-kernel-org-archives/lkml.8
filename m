Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E98C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0520720575
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgC0T3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:29:52 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35767 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbgC0T3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:29:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TtnYtzc_1585337380;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TtnYtzc_1585337380)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 28 Mar 2020 03:29:47 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: don't need drain lru cache when splitting and mlocking THP
Date:   Sat, 28 Mar 2020 03:29:40 +0800
Message-Id: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 8f182270dfec ("mm/swap.c: flush lru pvecs on compound
page arrival") THP would not stay in pagevec anymore.  So the
optimization made by commit d965432234db ("thp: increase
split_huge_page() success rate") doesn't make sense anymore, which tries
to unpin munlocked THPs from pagevec by draining pagevec.

And draining lru cache before isolating THP in mlock path is unnecessary
either.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/huge_memory.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199..1af2e7d6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1527,7 +1527,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 			goto skip_mlock;
 		if (!trylock_page(page))
 			goto skip_mlock;
-		lru_add_drain();
 		if (page->mapping && !PageDoubleMap(page))
 			mlock_vma_page(page);
 		unlock_page(page);
@@ -2711,7 +2710,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
 	int count, mapcount, extra_pins, ret;
-	bool mlocked;
 	unsigned long flags;
 	pgoff_t end;
 
@@ -2770,14 +2768,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		goto out_unlock;
 	}
 
-	mlocked = PageMlocked(head);
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
-	/* Make sure the page is not on per-CPU pagevec as it takes pin */
-	if (mlocked)
-		lru_add_drain();
-
 	/* prevent PageLRU to go away from under us, and freeze lru stats */
 	spin_lock_irqsave(&pgdata->lru_lock, flags);
 
-- 
1.8.3.1

