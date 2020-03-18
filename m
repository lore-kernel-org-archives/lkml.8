Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CAEC4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C115F20754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCRXTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:19:53 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:51619 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCRXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:19:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tt-L-mT_1584573582;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tt-L-mT_1584573582)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Mar 2020 07:19:49 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: khugepaged: fix potential page state corruption
Date:   Thu, 19 Mar 2020 07:19:42 +0800
Message-Id: <1584573582-116702-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When khugepaged collapses anonymous pages, the base pages would be freed
via pagevec or free_page_and_swap_cache().  But, the anonymous page may
be added back to LRU, then it might result in the below race:

	CPU A				CPU B
khugepaged:
  unlock page
  putback_lru_page
    add to lru
				page reclaim:
				  isolate this page
				  try_to_unmap
  page_remove_rmap <-- corrupt _mapcount

It looks nothing would prevent the pages from isolating by reclaimer.

The other problem is the page's active or unevictable flag might be
still set when freeing the page via free_page_and_swap_cache().  The
putback_lru_page() would not clear those two flags if the pages are
released via pagevec, it sounds nothing prevents from isolating active
or unevictable pages.

However I didn't really run into these problems, just in theory by visual
inspection.

And, it also seems unnecessary to have the pages add back to LRU again since
they are about to be freed when reaching this point.  So, clearing active
and unevictable flags, unlocking and dropping refcount from isolate
instead of calling putback_lru_page() as what page cache collapse does.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/khugepaged.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908..f42fa4e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -673,7 +673,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
 			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
-			release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
@@ -687,6 +686,15 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			pte_clear(vma->vm_mm, address, _pte);
 			page_remove_rmap(src_page, false);
 			spin_unlock(ptl);
+
+			dec_node_page_state(src_page,
+				NR_ISOLATED_ANON + page_is_file_cache(src_page));
+			ClearPageActive(src_page);
+			ClearPageUnevictable(src_page);
+			unlock_page(src_page);
+			/* Drop refcount from isolate */
+			put_page(src_page);
+
 			free_page_and_swap_cache(src_page);
 		}
 	}
-- 
1.8.3.1

