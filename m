Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626F820738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f283josl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGGHpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGGHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j20so2402552pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vQ5GSoRjpV3R4SO9Acoy8xbibvkjIyOIkvQQtOlm5pQ=;
        b=f283josljPq6DKf1JQSdsMSFFQredCoAwLG3Yvmiem7LiGKNwz3J7BUtwDqrzZv4SH
         1SPNgz/774QEYHIPwHCfX/xQ8NjTsLxGDijd1TsdmRnHuu9U1HUhjo/Njc0jd85ivtbH
         S1QycfVPg4GGLLlxKRGJK5dRI2ZVbwoYz2NZSAQkO+RH8xd0kx9Nsq7XTbP8MoQ0A+5M
         gjMciWUXhzIQ78c81cPjrV41sEs0jEmtKekDudymRx6tzIFxpiC5ctdulsioavSJE0ue
         XLbbRoAw2n/37dZpgo4v/d3etiP7cGSzdQ4YaTP3Cl+bQ+rY4rNKxu+pFW+2iqZ+fU82
         ZwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vQ5GSoRjpV3R4SO9Acoy8xbibvkjIyOIkvQQtOlm5pQ=;
        b=MbYkkkAdELaBYjhZMDInKXs0I7FRgOAokW6VJgnpqzMtdIhW4tQQGvcM69dFLLGAEO
         3wZSgdDSWzXA0hJGl7MdEzQFq7Fs1qkINbUPUUG/m1hxwHiTNMyMteXYqeje0PS8Mjl/
         gYPUbnIZYLUZ2CHP7QVoIcbClJLcbr9NVuGI3mIJhyCwuREY/yAIGASNGwaA7/lZoWgD
         yLE+OgcE+8PEVNjBFGrp+niiJlg7GASnFjiLswmDyM5435iVufg/HOlR5R5Bgc62rij7
         ffsEsaS1q16XERnfiq/6tbTBDN1aZ06Z8Ucr4BoxIngANgIs8UAeukpV7wLt+xJwdzfd
         hJiQ==
X-Gm-Message-State: AOAM5332JduXRqGF7zPY/XC93gUJNoUjZpIOae2SEyj5t34/h7iHAw92
        A3ZA34Q+I1i8T9HUfQVtQJw=
X-Google-Smtp-Source: ABdhPJy9xbFX1kg3Yu/H+ipD+c5/vdn4TdKwlrP/IwLzgfvlvEHoXzzt3paVxtngRaqFAp6l1At4KQ==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr42664298pgh.309.1594107929940;
        Tue, 07 Jul 2020 00:45:29 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:29 -0700 (PDT)
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
Subject: [PATCH v4 06/11] mm/migrate: make a standard migration target allocation function
Date:   Tue,  7 Jul 2020 16:44:44 +0900
Message-Id: <1594107889-32228-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There are some similar functions for migration target allocation.  Since
there is no fundamental difference, it's better to keep just one rather
than keeping all variants.  This patch implements base migration target
allocation function.  In the following patches, variants will be converted
to use this function.

Changes should be mechanical but there are some differences. First, Some
callers' nodemask is assgined to NULL since NULL nodemask will be
considered as all available nodes, that is, &node_states[N_MEMORY].
Second, for hugetlb page allocation, gfp_mask is ORed since a user could
provide a gfp_mask from now on. Third, if provided node id is NUMA_NO_NODE,
node id is set up to the node where migration source lives.

Note that PageHighmem() call in previous function is changed to open-code
"is_highmem_idx()" since it provides more readability.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/migrate.h |  9 +++++----
 mm/internal.h           |  7 +++++++
 mm/memory-failure.c     |  7 +++++--
 mm/memory_hotplug.c     | 14 +++++++++-----
 mm/migrate.c            | 27 +++++++++++++++++----------
 mm/page_isolation.c     |  7 +++++--
 6 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 1d70b4a..cc56f0d 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -10,6 +10,8 @@
 typedef struct page *new_page_t(struct page *page, unsigned long private);
 typedef void free_page_t(struct page *page, unsigned long private);
 
+struct migration_target_control;
+
 /*
  * Return values from addresss_space_operations.migratepage():
  * - negative errno on page migration failure;
@@ -39,8 +41,7 @@ extern int migrate_page(struct address_space *mapping,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
 		unsigned long private, enum migrate_mode mode, int reason);
-extern struct page *new_page_nodemask(struct page *page,
-		int preferred_nid, nodemask_t *nodemask);
+extern struct page *alloc_migration_target(struct page *page, unsigned long private);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
@@ -59,8 +60,8 @@ static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
 		int reason)
 	{ return -ENOSYS; }
-static inline struct page *new_page_nodemask(struct page *page,
-		int preferred_nid, nodemask_t *nodemask)
+static inline struct page *alloc_migration_target(struct page *page,
+		unsigned long private)
 	{ return NULL; }
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
diff --git a/mm/internal.h b/mm/internal.h
index dd14c53..0beacf3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -614,4 +614,11 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+struct migration_target_control {
+	int nid;		/* preferred node id */
+	nodemask_t *nmask;
+	gfp_t gfp_mask;
+};
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c5e4cee..609d42b6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1679,9 +1679,12 @@ EXPORT_SYMBOL(unpoison_memory);
 
 static struct page *new_page(struct page *p, unsigned long private)
 {
-	int nid = page_to_nid(p);
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(p),
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
-	return new_page_nodemask(p, nid, &node_states[N_MEMORY]);
+	return alloc_migration_target(p, (unsigned long)&mtc);
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index cafe65eb..86bc2ad 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1267,19 +1267,23 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 
 static struct page *new_node_page(struct page *page, unsigned long private)
 {
-	int nid = page_to_nid(page);
 	nodemask_t nmask = node_states[N_MEMORY];
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(page),
+		.nmask = &nmask,
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
 	/*
 	 * try to allocate from a different node but reuse this node if there
 	 * are no other online nodes to be used (e.g. we are offlining a part
 	 * of the only existing node)
 	 */
-	node_clear(nid, nmask);
-	if (nodes_empty(nmask))
-		node_set(nid, nmask);
+	node_clear(mtc.nid, *mtc.nmask);
+	if (nodes_empty(*mtc.nmask))
+		node_set(mtc.nid, *mtc.nmask);
 
-	return new_page_nodemask(page, nid, &nmask);
+	return alloc_migration_target(page, (unsigned long)&mtc);
 }
 
 static int
diff --git a/mm/migrate.c b/mm/migrate.c
index ecd7615..00cd81c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1531,19 +1531,27 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
-struct page *new_page_nodemask(struct page *page,
-				int preferred_nid, nodemask_t *nodemask)
+struct page *alloc_migration_target(struct page *page, unsigned long private)
 {
-	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+	struct migration_target_control *mtc;
+	gfp_t gfp_mask;
 	unsigned int order = 0;
 	struct page *new_page = NULL;
+	int nid;
+	int zidx;
+
+	mtc = (struct migration_target_control *)private;
+	gfp_mask = mtc->gfp_mask;
+	nid = mtc->nid;
+	if (nid == NUMA_NO_NODE)
+		nid = page_to_nid(page);
 
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(compound_head(page));
 
-		gfp_mask = htlb_alloc_mask(h);
-		return alloc_huge_page_nodemask(h, preferred_nid,
-						nodemask, gfp_mask, false);
+		gfp_mask |= htlb_alloc_mask(h);
+		return alloc_huge_page_nodemask(h, nid, mtc->nmask,
+						gfp_mask, false);
 	}
 
 	if (PageTransHuge(page)) {
@@ -1555,12 +1563,11 @@ struct page *new_page_nodemask(struct page *page,
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
-
-	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
+	zidx = zone_idx(page_zone(page));
+	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
-	new_page = __alloc_pages_nodemask(gfp_mask, order,
-				preferred_nid, nodemask);
+	new_page = __alloc_pages_nodemask(gfp_mask, order, nid, mtc->nmask);
 
 	if (new_page && PageTransHuge(new_page))
 		prep_transhuge_page(new_page);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index aec26d9..f25c66e 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -309,7 +309,10 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private)
 {
-	int nid = page_to_nid(page);
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(page),
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
-	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
+	return alloc_migration_target(page, (unsigned long)&mtc);
 }
-- 
2.7.4

