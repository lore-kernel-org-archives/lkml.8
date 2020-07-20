Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C48C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C97C208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYXv9eft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGTE4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGTE4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:56:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67CC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:56:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so8118190plo.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WxQvsZ6QmcUkdn7bmiYYmJhxUakC2I6RnR8rzuhXmYI=;
        b=iYXv9eftR84ZHA/raJZbczowGT4NKjrV8526WC8U95iR7EuvEcIqalEjIbB59y3oPu
         OL6AvUcKU6L2I3zjzLUwCs2cAgbVakZ1QPgvgNIZOTdluu3dtek4uaCnu0oa3xzURgs/
         QG7wjeVXnfxVo8JhZvFjcAFtbSfOVWVCP6WUpAacx1/q1PJCwkbVowxQTpi61dV9SOpm
         NPX0wCUSOtDwA7tWaflIHY3p607XyjKY+pqHlyPYUdczUX8QKOXAdFn+5ib1roKDJexC
         n9iFbleMRgpfi8GCy8b5Z2hdJJj1TZZ1NFx1ksaxeffoCcxYEnVAWtyJJlDE4/LxxiNT
         tfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WxQvsZ6QmcUkdn7bmiYYmJhxUakC2I6RnR8rzuhXmYI=;
        b=YHzuRIBV8KvBIKSvYoMqBiZPOLcwYLqyTmbp00R8tBk9RUhDqlhtGgyKAUAv9rjudR
         cH+H7BlWsBQX+hIH8F+vtbJ/jkvB2IM6/Iwh+B/VNOk1wuNCf5XHgOUsn/bHjVWfTu/W
         6JUMQkoFnz2zRQF0nLiwa8dB/AnrhzTlEHsNm4zTf6wEWlQ8br4mjIzHZT+ADWOpKP2t
         /791883KFgt6m8HvWPNQr4ijSI+PtP0VPsdmKqdtCP4z+TXxZYyW0Ncm7C6CwyNJAWOM
         8OIG5UYHJWrzFAJNkV+dxgCcdouoguCXcflzuu0ERUjJY4HBZT73YoZMqwSYB6mZRRys
         EmDg==
X-Gm-Message-State: AOAM530vDdi7wPcE3v4KONNZ4pviwNnllroDGXwZB0RdDhczbeXIfg7B
        W385/zUQNU86yZBJ6w+iK9s=
X-Google-Smtp-Source: ABdhPJw0rKezzDSAU6tqpn6flMPuV+16J+ebbVLnAeiSiY9g1d3Fxj4/34wxckGgtOme7S/i7vBDOw==
X-Received: by 2002:a17:90a:32cb:: with SMTP id l69mr19545057pjb.205.1595221006220;
        Sun, 19 Jul 2020 21:56:46 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id w2sm10177532pjt.19.2020.07.19.21.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 21:56:45 -0700 (PDT)
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 3/4] mm/hugetlb: make hugetlb migration callback CMA aware
Date:   Mon, 20 Jul 2020 13:56:17 +0900
Message-Id: <1595220978-9890-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

new_non_cma_page() in gup.c requires to allocate the new page that is not
on the CMA area. new_non_cma_page() implements it by using allocation
scope APIs.

However, there is a work-around for hugetlb. Normal hugetlb page
allocation API for migration is alloc_huge_page_nodemask(). It consists
of two steps. First is dequeing from the pool. Second is, if there is no
available page on the queue, allocating by using the page allocator.

new_non_cma_page() can't use this API since first step (deque) isn't
aware of scope API to exclude CMA area. So, new_non_cma_page() exports
hugetlb internal function for the second step, alloc_migrate_huge_page(),
to global scope and uses it directly. This is suboptimal since hugetlb
pages on the queue cannot be utilized.

This patch tries to fix this situation by making the deque function on
hugetlb CMA aware. In the deque function, CMA memory is skipped if
PF_MEMALLOC_NOCMA flag is found.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h |  2 --
 mm/gup.c                |  6 +-----
 mm/hugetlb.c            | 11 +++++++++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2660b04..fb2b5aa 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -509,8 +509,6 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
-				     int nid, nodemask_t *nmask);
 int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
diff --git a/mm/gup.c b/mm/gup.c
index bbd36a1..4ba822a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1634,11 +1634,7 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
 		struct hstate *h = page_hstate(page);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
-		/*
-		 * We don't want to dequeue from the pool because pool pages will
-		 * mostly be from the CMA region.
-		 */
-		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
+		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask);
 	}
 #endif
 	if (PageTransHuge(page)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3245aa0..d9eb923 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -29,6 +29,7 @@
 #include <linux/numa.h>
 #include <linux/llist.h>
 #include <linux/cma.h>
+#include <linux/sched/mm.h>
 
 #include <asm/page.h>
 #include <asm/tlb.h>
@@ -1036,10 +1037,16 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
 static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
 {
 	struct page *page;
+	bool nocma = !!(current->flags & PF_MEMALLOC_NOCMA);
+
+	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
+		if (nocma && is_migrate_cma_page(page))
+			continue;
 
-	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
 		if (!PageHWPoison(page))
 			break;
+	}
+
 	/*
 	 * if 'non-isolated free hugepage' not found on the list,
 	 * the allocation fails.
@@ -1928,7 +1935,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct page *page;
-- 
2.7.4

