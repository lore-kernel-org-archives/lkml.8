Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56650C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE8120720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atCKzJ3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgGMGm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgGMGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B69C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:25 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so5581289pfn.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V+4QG5y5MI2sik505z3aqneUrvc8k4tfYjh515Z4aV0=;
        b=atCKzJ3Z55CGiaI3Z2TRL5UAnjeKAfjbepbKFRFonYWggBpBy0Z+YsTdkqbuGZKzpA
         c0YtHwCNLjCreSjtN2VH/irIVY7ldvKCFxzyATrexj247qfMBvGZ/oof8D3jEsG1LuRB
         B8c2pm3D0oSTclxUMjV1YsiTiypn2XxAR4xR75BrS20++ERc6hWdJhpdDlPIb8Xu7sOK
         vyC5Ha3+RFhf78yWzP5dO3WkPcl9mzWb8VhJ74wMpkaB2PXpz2vPpZXD06ZcgGrttXZ2
         lf/Nv9JrxDbuNea9SSyAl7C1ANvCW2QV1xroQeFl0HbRYNiQnyS1SyUlpXlHqeQs62rh
         al+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V+4QG5y5MI2sik505z3aqneUrvc8k4tfYjh515Z4aV0=;
        b=ZjRF2CllTilYdrHJKFyVSShOGSW8BNkzMcAhbo6Dq223f4vBrct/HAQGtZdNyIxZ6b
         G095H0Qyjmx0r7rlss87hxvilVbeo0xVRKD+H6DS6aEh9YOn9pWKMs6uH05jmHiTK2Bo
         OPS9+om5fvZ6VJT5IXCInc0M8ILcxp76145Gfv6og+3LcUKa766RB9GJAuWeaTE3aEot
         CWGkWPCLc+wVbcUy7HwPnOF9xrrPNH9sfhDt2eMqIlwbpxVOuPwJTElrIgJ6WNhW4tK+
         HMODsn7xOSb+Os4utZQSGcwNcpxYc4gifNGU08r6iSr7tLo7AqimyxkSl/HcyyUt/HnF
         PH6A==
X-Gm-Message-State: AOAM5312nabKVJmOMN7slUE3sJM3nHBaqOw8htZAiMxAx2iwgepQ6bzW
        /D1nVUyKXt4a8jF3OWJHz84=
X-Google-Smtp-Source: ABdhPJwA0sKwDRvosYFZ+kOvmOyKqwmn3y6398Dv7Stu2LCp+MD46s0LNu6EeVFLVLN0J1AHq3CO8g==
X-Received: by 2002:a63:ca11:: with SMTP id n17mr67131603pgi.439.1594622545556;
        Sun, 12 Jul 2020 23:42:25 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:25 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v5 3/9] mm/hugetlb: unify migration callbacks
Date:   Mon, 13 Jul 2020 15:41:51 +0900
Message-Id: <1594622517-20681-4-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is no difference between two migration callback functions,
alloc_huge_page_node() and alloc_huge_page_nodemask(), except
__GFP_THISNODE handling. It's redundant to have two almost similar
functions in order to handle this flag. So, this patch tries to
remove one by introducing a new argument, gfp_mask, to
alloc_huge_page_nodemask().

After introducing gfp_mask argument, it's caller's job to provide correct
gfp_mask. So, every callsites for alloc_huge_page_nodemask() are changed
to provide gfp_mask.

Note that it's safe to remove a node id check in alloc_huge_page_node()
since there is no caller passing NUMA_NO_NODE as a node id.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h | 26 ++++++++++++++++++--------
 mm/hugetlb.c            | 35 ++---------------------------------
 mm/mempolicy.c          | 10 ++++++----
 mm/migrate.c            | 11 +++++++----
 4 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 50650d0..bb93e95 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/pgtable.h>
+#include <linux/gfp.h>
 
 struct ctl_table;
 struct user_struct;
@@ -504,9 +505,8 @@ struct huge_bootmem_page {
 
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
-struct page *alloc_huge_page_node(struct hstate *h, int nid);
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-				nodemask_t *nmask);
+				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
 struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
@@ -692,6 +692,15 @@ static inline bool hugepage_movable_supported(struct hstate *h)
 	return true;
 }
 
+/* Movability of hugepages depends on migration support. */
+static inline gfp_t htlb_alloc_mask(struct hstate *h)
+{
+	if (hugepage_movable_supported(h))
+		return GFP_HIGHUSER_MOVABLE;
+	else
+		return GFP_HIGHUSER;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
@@ -759,13 +768,9 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *alloc_huge_page_node(struct hstate *h, int nid)
-{
-	return NULL;
-}
-
 static inline struct page *
-alloc_huge_page_nodemask(struct hstate *h, int preferred_nid, nodemask_t *nmask)
+alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+			nodemask_t *nmask, gfp_t gfp_mask)
 {
 	return NULL;
 }
@@ -878,6 +883,11 @@ static inline bool hugepage_movable_supported(struct hstate *h)
 	return false;
 }
 
+static inline gfp_t htlb_alloc_mask(struct hstate *h)
+{
+	return 0;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7e5ba5c0..3245aa0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1089,15 +1089,6 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 	return NULL;
 }
 
-/* Movability of hugepages depends on migration support. */
-static inline gfp_t htlb_alloc_mask(struct hstate *h)
-{
-	if (hugepage_movable_supported(h))
-		return GFP_HIGHUSER_MOVABLE;
-	else
-		return GFP_HIGHUSER;
-}
-
 static struct page *dequeue_huge_page_vma(struct hstate *h,
 				struct vm_area_struct *vma,
 				unsigned long address, int avoid_reserve,
@@ -1979,31 +1970,9 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 }
 
 /* page migration callback function */
-struct page *alloc_huge_page_node(struct hstate *h, int nid)
-{
-	gfp_t gfp_mask = htlb_alloc_mask(h);
-	struct page *page = NULL;
-
-	if (nid != NUMA_NO_NODE)
-		gfp_mask |= __GFP_THISNODE;
-
-	spin_lock(&hugetlb_lock);
-	if (h->free_huge_pages - h->resv_huge_pages > 0)
-		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
-	spin_unlock(&hugetlb_lock);
-
-	if (!page)
-		page = alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
-
-	return page;
-}
-
-/* page migration callback function */
 struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask)
+		nodemask_t *nmask, gfp_t gfp_mask)
 {
-	gfp_t gfp_mask = htlb_alloc_mask(h);
-
 	spin_lock(&hugetlb_lock);
 	if (h->free_huge_pages - h->resv_huge_pages > 0) {
 		struct page *page;
@@ -2031,7 +2000,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask);
+	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index dabcee8..9034a53 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1068,10 +1068,12 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 /* page allocation callback for NUMA node migration */
 struct page *alloc_new_node_page(struct page *page, unsigned long node)
 {
-	if (PageHuge(page))
-		return alloc_huge_page_node(page_hstate(compound_head(page)),
-					node);
-	else if (PageTransHuge(page)) {
+	if (PageHuge(page)) {
+		struct hstate *h = page_hstate(compound_head(page));
+		gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+
+		return alloc_huge_page_nodemask(h, node, NULL, gfp_mask);
+	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
 		thp = alloc_pages_node(node,
diff --git a/mm/migrate.c b/mm/migrate.c
index 7370a66..3b3d918 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1538,10 +1538,13 @@ struct page *new_page_nodemask(struct page *page,
 	unsigned int order = 0;
 	struct page *new_page = NULL;
 
-	if (PageHuge(page))
-		return alloc_huge_page_nodemask(
-				page_hstate(compound_head(page)),
-				preferred_nid, nodemask);
+	if (PageHuge(page)) {
+		struct hstate *h = page_hstate(compound_head(page));
+
+		gfp_mask = htlb_alloc_mask(h);
+		return alloc_huge_page_nodemask(h, preferred_nid,
+						nodemask, gfp_mask);
+	}
 
 	if (PageTransHuge(page)) {
 		gfp_mask |= GFP_TRANSHUGE;
-- 
2.7.4

