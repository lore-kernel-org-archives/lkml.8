Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A0C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0010F2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW76YEKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgGOFFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOFFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:05:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:05:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n5so2412459pgf.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AKrEHiEzPuoCEsO4TLc5HH/VubY2AXZn4AqF30isMQ=;
        b=NW76YEKerrPYarzLcXnVQVWD6TxcJG9J0lXNL/HGI7507rHkwHGlZ8TVCyj037c3AM
         sR5zgx2v2HDPWkCfroy5gIuGXerzk+N1WneD4s4wd+uHNAqw2HM7ptR9Wuo88t+WkVdI
         HJqYIFnr6nCAB5Fw+D+thZM797p6zrRGcZbh0o+bnr52xk0OPpsnlpQZGQdmxjkpzd86
         vAHjW4K5pzgXAwjljpRzbgYDXsmz4AkGMu1hUgAMzzHCO+3jtMvdSM3gHVLjI6Y/vLgj
         /ug729iHvy+svuYUY5Pnzu4WvuOkLe66qjhQp7GTK17WeDcBMd6pHxQq1a5MSy0bmRkb
         GpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0AKrEHiEzPuoCEsO4TLc5HH/VubY2AXZn4AqF30isMQ=;
        b=L06iBH17miSrTsVRXXAktR1eqO6xEcyGn3umaCJa4vcWDLlq7y2xuKfsksC592bZK3
         lYJkSXCWjahdNDqFzg6JyMEspKj5/8kFT/g0g2Ji1uO7BN03sHb9ZsSJu51DBAt2YUO/
         fA8p2Jre+pqvs9BZ83eRtvGyhf2RtvAgYPu14uF1yIclWymCijgaA1qoMXP0i0fn9XFp
         PcU4weSQm9JtwBduQfWq2GrZM++c32lZ62HgUOh8p7lq8hEylLIandGBthHtMOOt2MEW
         QhAnJusn90V0WJ0Rhe74tv1LUErqQmC97O9np14lfnJhcB9/EbP2soUHNPEyybgLi449
         XMIg==
X-Gm-Message-State: AOAM530JF496h0i/zHYwMEAvfqff/be3/YMW51AvfKm911GK/IE3SyLR
        fPjzLauUvadvtLFL+8c5CY3QBnnW
X-Google-Smtp-Source: ABdhPJwNMsauklBHBIb0B1nsPp0Np6cFzW1wF3KaWP7sM5TueUd92REoB48cljvZTwzyWVvwUQqEgA==
X-Received: by 2002:a62:80d5:: with SMTP id j204mr7331645pfd.115.1594789551624;
        Tue, 14 Jul 2020 22:05:51 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm747251pfa.18.2020.07.14.22.05.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 22:05:51 -0700 (PDT)
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
Subject: [PATCH 3/4] mm/hugetlb: make hugetlb migration callback CMA aware
Date:   Wed, 15 Jul 2020 14:05:28 +0900
Message-Id: <1594789529-6206-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index 3245aa0..514e29c 100644
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
+	bool nocma = !!(READ_ONCE(current->flags) & PF_MEMALLOC_NOCMA);
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

