Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CACBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2985320772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuEQd2jW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgFWGOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbgFWGOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFDC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so4148837pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JeJRVUHUWS+NkYIk84BTUuRS8wpVOF+4CdGFtPuQTi4=;
        b=BuEQd2jWXoEBKzZaSn/hHjBQOVNCpcUihjM+7y+30fNDJxRxKeKMDQPxV8S+xz0jMJ
         KaxBwMOrhwCNHRW0wrqzGgtoUcgfeN4w2nC+OVw6h6gF9wj8zTH9ZShRYycHGkUcOaGB
         uv7lbs23XHglLlChg4fuJ7+wbJlcu+g8TS06/d811dPgvt5iUQOoM2KTZMeWSevIHQoB
         peaoEuZJ5LVGa6x2QyITw6nw9vM45xK5xTpmzZHV2FcNrnccZB6Tkd1CqIVBf3fNbLmZ
         AW4Z6+I2q59VZJly1mM9pAaXRr9oeyvQo7anvM0z3/OQwjLRMbfWEkbsCk7x5UTJUeXu
         aNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JeJRVUHUWS+NkYIk84BTUuRS8wpVOF+4CdGFtPuQTi4=;
        b=uSrTrCuzLZv3eKY5HgEgPpLT6/dqsLmIIrPM2p6CI3kmdr/w5maig7BomYXE0x+In8
         7Q2qB8BsivTYzeYTX28Xjw46vx9T6MfFkx/GAD4IoFSQ2IDd6+m9OV86RN4VnqA5SkY5
         kt3KF6R71Pd0XqZa/hpWkJRd1ygmz/+BXxbUYXd4N1T0Il90XbwZ6cwf7Dkg1fUIZGS7
         2fOIePTlJezcCqp3y6syUvPCH6ObjrjlHOyKdsBwULJHfuZYnoBayo3yG4a7Ft+f2t/g
         TGDY0oOXV3BGqoyDwuaDeftaBoeCdpA4/bCii/PKdelq93PgzmQPDpZUalYgDWY1lbpA
         NlGA==
X-Gm-Message-State: AOAM533geV3x5CsnJ6qpOtJUs5liID6OEtfZHnMGWfCAcctUegxYS8sk
        tPsyGv6lphy2uhPew3887dw=
X-Google-Smtp-Source: ABdhPJyf29dQ7hZpX23MUTob3xHfA47w0T/RxJ1iIW4kUumzNWT2DjCDiGwi6tfbdXoUTnhm7C+isQ==
X-Received: by 2002:aa7:9497:: with SMTP id z23mr23656436pfk.222.1592892881392;
        Mon, 22 Jun 2020 23:14:41 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:40 -0700 (PDT)
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
Subject: [PATCH v3 5/8] mm/migrate: make a standard migration target allocation function
Date:   Tue, 23 Jun 2020 15:13:45 +0900
Message-Id: <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There are some similar functions for migration target allocation. Since
there is no fundamental difference, it's better to keep just one rather
than keeping all variants. This patch implements base migration target
allocation function. In the following patches, variants will be converted
to use this function.

Note that PageHighmem() call in previous function is changed to open-code
"is_highmem_idx()" since it provides more readability.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/migrate.h |  5 +++--
 mm/internal.h           |  7 +++++++
 mm/memory-failure.c     |  8 ++++++--
 mm/memory_hotplug.c     | 14 +++++++++-----
 mm/migrate.c            | 21 +++++++++++++--------
 mm/page_isolation.c     |  8 ++++++--
 6 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 1d70b4a..5e9c866 100644
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
 
diff --git a/mm/internal.h b/mm/internal.h
index 42cf0b6..f725aa8 100644
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
index 47b8ccb..820ea5e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1648,9 +1648,13 @@ EXPORT_SYMBOL(unpoison_memory);
 
 static struct page *new_page(struct page *p, unsigned long private)
 {
-	int nid = page_to_nid(p);
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(p),
+		.nmask = &node_states[N_MEMORY],
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
-	return new_page_nodemask(p, nid, &node_states[N_MEMORY]);
+	return alloc_migration_target(p, (unsigned long)&mtc);
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index be3c62e3..d2b65a5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1259,19 +1259,23 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 
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
index 634f1ea..3afff59 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1536,29 +1536,34 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
+	int zidx;
+
+	mtc = (struct migration_target_control *)private;
+	gfp_mask = mtc->gfp_mask;
 
 	if (PageHuge(page)) {
 		return alloc_huge_page_nodemask(
-				page_hstate(compound_head(page)),
-				preferred_nid, nodemask, 0, false);
+				page_hstate(compound_head(page)), mtc->nid,
+				mtc->nmask, gfp_mask, false);
 	}
 
 	if (PageTransHuge(page)) {
+		gfp_mask &= ~__GFP_RECLAIM;
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
-
-	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
+	zidx = zone_idx(page_zone(page));
+	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
 	new_page = __alloc_pages_nodemask(gfp_mask, order,
-				preferred_nid, nodemask);
+				mtc->nid, mtc->nmask);
 
 	if (new_page && PageTransHuge(new_page))
 		prep_transhuge_page(new_page);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index aec26d9..adba031 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -309,7 +309,11 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 struct page *alloc_migrate_target(struct page *page, unsigned long private)
 {
-	int nid = page_to_nid(page);
+	struct migration_target_control mtc = {
+		.nid = page_to_nid(page),
+		.nmask = &node_states[N_MEMORY],
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
-	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
+	return alloc_migration_target(page, (unsigned long)&mtc);
 }
-- 
2.7.4

