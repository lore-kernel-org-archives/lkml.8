Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A235D20707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIABqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:46:54 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36271 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgIABqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:46:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7ULtbo_1598924806;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7ULtbo_1598924806)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 09:46:46 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v4 7/7] mm/hugetlb: take the free hpage during the iteration directly
Date:   Tue,  1 Sep 2020 09:46:36 +0800
Message-Id: <20200901014636.29737-8-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
References: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function dequeue_huge_page_node_exact() iterates the free list and
return the first valid free hpage.

Instead of break and check the loop variant, we could return in the loop
directly. This could reduce some redundant check.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

[mike.kravetz@oracle.com: points out a logic error]
---
 mm/hugetlb.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7b3357c1dcec..82ba4cad2704 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1040,21 +1040,17 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 		if (nocma && is_migrate_cma_page(page))
 			continue;
 
-		if (!PageHWPoison(page))
-			break;
+		if (PageHWPoison(page))
+			continue;
+
+		list_move(&page->lru, &h->hugepage_activelist);
+		set_page_refcounted(page);
+		h->free_huge_pages--;
+		h->free_huge_pages_node[nid]--;
+		return page;
 	}
 
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
+	return NULL;
 }
 
 static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
-- 
2.20.1 (Apple Git-117)

