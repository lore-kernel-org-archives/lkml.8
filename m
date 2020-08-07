Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11725C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E504921744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHGJN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:13:27 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44575 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727855AbgHGJNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:13:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.6f7D_1596791599;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.6f7D_1596791599)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 17:13:20 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 08/10] mm/hugetlb: return non-isolated page in the loop instead of break and check
Date:   Fri,  7 Aug 2020 17:12:49 +0800
Message-Id: <20200807091251.12129-9-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function dequeue_huge_page_node_exact() iterates the free list and
return the first non-isolated one.

Instead of break and check the loop variant, we could return in the loop
directly. This could reduce some redundant check.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/hugetlb.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b8e844911b5a..9473eb6800e9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1035,20 +1035,18 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 {
 	struct page *page;
 
-	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
-		if (!PageHWPoison(page))
-			break;
-	/*
-	 * if 'non-isolated free hugepage' not found on the list,
-	 * the allocation fails.
-	 */
-	if (&h->hugepage_freelists[nid] == &page->lru)
-		return NULL;
-	list_move(&page->lru, &h->hugepage_activelist);
-	set_page_refcounted(page);
-	h->free_huge_pages--;
-	h->free_huge_pages_node[nid]--;
-	return page;
+	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
+		if (PageHWPoison(page))
+			continue;
+
+		list_move(&page->lru, &h->hugepage_activelist);
+		set_page_refcounted(page);
+		h->free_huge_pages--;
+		h->free_huge_pages_node[nid]--;
+		return page;
+	}
+
+	return NULL;
 }
 
 static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-- 
2.20.1 (Apple Git-117)

