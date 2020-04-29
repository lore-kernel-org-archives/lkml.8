Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30FAC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8702083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgD2W4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:56:41 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47949 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbgD2W4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:56:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tx2rN9y_1588200990;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tx2rN9y_1588200990)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Apr 2020 06:56:38 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [linux-next PATCH 2/2] mm: khugepaged: don't have to put being freed page back to lru
Date:   Thu, 30 Apr 2020 06:56:22 +0800
Message-Id: <1588200982-69492-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When khugepaged successfully isolated and copied data from base page to
collapsed THP, the base page is about to be freed.  So putting the page
back to lru sounds not that productive since the page might be isolated
by vmscan but it can't be reclaimed by vmscan since it can't be unmapped
by try_to_unmap() at all.

Actually khugepaged is the last user of this page so it can be freed
directly.  So, clearing active and unevictable flags, unlocking and
dropping refcount from isolate instead of calling putback_lru_page().

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/khugepaged.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0c8d30b..c131a90 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -559,6 +559,17 @@ void __khugepaged_exit(struct mm_struct *mm)
 static void release_pte_page(struct page *page)
 {
 	mod_node_page_state(page_pgdat(page),
+		NR_ISOLATED_ANON + page_is_file_lru(page), -compound_nr(page));
+	ClearPageActive(page);
+	ClearPageUnevictable(page);
+	unlock_page(page);
+	/* Drop refcount from isolate */
+	put_page(page);
+}
+
+static void release_pte_page_to_lru(struct page *page)
+{
+	mod_node_page_state(page_pgdat(page),
 			NR_ISOLATED_ANON + page_is_file_lru(page),
 			-compound_nr(page));
 	unlock_page(page);
@@ -576,12 +587,12 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 		page = pte_page(pteval);
 		if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
 				!PageCompound(page))
-			release_pte_page(page);
+			release_pte_page_to_lru(page);
 	}
 
 	list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
 		list_del(&page->lru);
-		release_pte_page(page);
+		release_pte_page_to_lru(page);
 	}
 }
 
-- 
1.8.3.1

