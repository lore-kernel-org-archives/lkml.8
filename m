Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F578C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A5D20870
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgD3Ulj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:41:39 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:38284 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbgD3Ulj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:41:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tx7vcUa_1588279287;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tx7vcUa_1588279287)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 May 2020 04:41:35 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 linux-next PATCH 2/2] mm: khugepaged: don't have to put being freed page back to lru
Date:   Fri,  1 May 2020 04:41:19 +0800
Message-Id: <1588279279-61908-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588279279-61908-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1588279279-61908-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When khugepaged successfully isolated and copied data from old page to
collapsed THP, the old page is about to be freed if its last mapcount
is gone.  So putting the page back to lru sounds not that productive in
this case since the page might be isolated by vmscan but it can't be
reclaimed by vmscan since it can't be unmapped by try_to_unmap() at all.

Actually if khugepaged is the last user of this page so it can be freed
directly.  So, clearing active and unevictable flags, unlocking and
dropping refcount from isolate instead of calling putback_lru_page().

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
v2: Check mapcount and skip putback lru if the last mapcount is gone

 mm/khugepaged.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0c8d30b..1fdd677 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -559,10 +559,18 @@ void __khugepaged_exit(struct mm_struct *mm)
 static void release_pte_page(struct page *page)
 {
 	mod_node_page_state(page_pgdat(page),
-			NR_ISOLATED_ANON + page_is_file_lru(page),
-			-compound_nr(page));
-	unlock_page(page);
-	putback_lru_page(page);
+		NR_ISOLATED_ANON + page_is_file_lru(page), -compound_nr(page));
+
+	if (total_mapcount(page)) {
+		unlock_page(page);
+		putback_lru_page(page);
+	} else {
+		ClearPageActive(page);
+		ClearPageUnevictable(page);
+		unlock_page(page);
+		/* Drop refcount from isolate */
+		put_page(page);
+	}
 }
 
 static void release_pte_pages(pte_t *pte, pte_t *_pte,
@@ -771,8 +779,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 		} else {
 			src_page = pte_page(pteval);
 			copy_user_highpage(page, src_page, address, vma);
-			if (!PageCompound(src_page))
-				release_pte_page(src_page);
 			/*
 			 * ptl mostly unnecessary, but preempt has to
 			 * be disabled to update the per-cpu stats
@@ -786,6 +792,8 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			pte_clear(vma->vm_mm, address, _pte);
 			page_remove_rmap(src_page, false);
 			spin_unlock(ptl);
+			if (!PageCompound(src_page))
+				release_pte_page(src_page);
 			free_page_and_swap_cache(src_page);
 		}
 	}
-- 
1.8.3.1

