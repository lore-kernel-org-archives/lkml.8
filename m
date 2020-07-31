Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9284C2250E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBH5vfGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbgGaHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGaHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:35:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B8FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:35:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so6595761pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XG1OzhoIoStzjs92yyazweiEB/4D+J+cafe51bT7rtQ=;
        b=rBH5vfGv+lomki5x/FN7kDdxQuPJ/LbAKwn/7qcZm7yfqD9YWeERFo3wZYH916c2TI
         6dO1NSPBQrCnpqCBPSPrZiIyiIqtiDRFPZh1kFUM+oZ1/Vz6TWvZFVYVwBNIgo/NGz2S
         W6z/Ty9lCinBEdohxajE9OPtOW3Mcw0HezJHQZN5W9Z+O54looju/8JRn5WgJlWFsP0v
         r5/UZXqvX7/iPStaYtBjRGRV3j3f5i7OCOvwGTwAzbP7g5UDY92BARxWUdiSA5L/s0Ra
         pIM7EJQUCMECpUmsxBDlbjg230gfWo9XH7jHV0ayyXvgKqoFjYg4JZmMYN2B1EsWdiKe
         UwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XG1OzhoIoStzjs92yyazweiEB/4D+J+cafe51bT7rtQ=;
        b=TBNPTIEkve7VibOLZkm9WtzxF1HFZQBFEIGnGmRMYNlXB2NhOsyfEqSiNjztZqXL1F
         8fetfojno4x/LzVmqPYYCfKeV2orxsj5BSD4H6xhI13n/jtiKx4QffPFcVA3QAX+0BwI
         ydBLo9iHeNxhIHxIFNlsD9C7ldbaIO11cZAC2mjXRc10XPgql9LTW+3kTUPmrUKm4Bi1
         CzXcXCt1nv3dJFmXUeqxHA9WmDD87tG11HW014LRGyWAk6pE4jaCaMU6SFyz1tZt7+5R
         WcxwO6wEDDyypb4lnJVh58KaJD2gYXotw2To2W3qIqFQ7TbKMjWTzGT3M08gotU6Yvux
         pPqw==
X-Gm-Message-State: AOAM533ZXWnjmFNhgPYeepoTnPu90iSAQpjzKNfBsHeFDtX/4GulvMFy
        SUg8cKK+yhxqt6BwoXS7qX8=
X-Google-Smtp-Source: ABdhPJwnVQv/CqRvsbNm14kCYy6anShj+SJtR2oELJWKTlAR9pnZ5I27qpNb0kZ3Hj8ZMwKVTRJuTw==
X-Received: by 2002:a17:90a:1589:: with SMTP id m9mr3025242pja.122.1596180933494;
        Fri, 31 Jul 2020 00:35:33 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 13sm8355522pfp.3.2020.07.31.00.35.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:35:32 -0700 (PDT)
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
Subject: [PATCH v3 2/3] mm/hugetlb: make hugetlb migration callback CMA aware
Date:   Fri, 31 Jul 2020 16:35:05 +0900
Message-Id: <1596180906-8442-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596180906-8442-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1596180906-8442-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index 3990ddc..7b63d72 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1616,11 +1616,7 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
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
index 4645f14..d1706b7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -30,6 +30,7 @@
 #include <linux/llist.h>
 #include <linux/cma.h>
 #include <linux/migrate.h>
+#include <linux/sched/mm.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -1041,10 +1042,16 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
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
@@ -1973,7 +1980,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
 	return page;
 }
 
-struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct page *page;
-- 
2.7.4

