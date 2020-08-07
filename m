Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA4C2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgHGJNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:13:36 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44961 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgHGJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:13:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.RnvZ_1596791601;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.RnvZ_1596791601)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 17:13:21 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page to workaround the nasty free_huge_page
Date:   Fri,  7 Aug 2020 17:12:51 +0800
Message-Id: <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's always increase surplus_huge_pages and so that free_huge_page
could decrease it at free time.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/hugetlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f2010c9dd8d..a0eb81e0e4c5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1913,21 +1913,19 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 		return NULL;
 
 	spin_lock(&hugetlb_lock);
+
+	h->surplus_huge_pages++;
+	h->surplus_huge_pages_node[page_to_nid(page)]++;
+
 	/*
 	 * We could have raced with the pool size change.
 	 * Double check that and simply deallocate the new page
-	 * if we would end up overcommiting the surpluses. Abuse
-	 * temporary page to workaround the nasty free_huge_page
-	 * codeflow
+	 * if we would end up overcommiting the surpluses.
 	 */
-	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
-		SetPageHugeTemporary(page);
+	if (h->surplus_huge_pages > h->nr_overcommit_huge_pages) {
 		spin_unlock(&hugetlb_lock);
 		put_page(page);
 		return NULL;
-	} else {
-		h->surplus_huge_pages++;
-		h->surplus_huge_pages_node[page_to_nid(page)]++;
 	}
 
 out_unlock:
-- 
2.20.1 (Apple Git-117)

