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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F5BC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C0D20720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4eDalfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgGMGmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgGMGmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601CC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so5073894pld.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GObApkfHEsPhLdQKUnzBpTACGgx9w+bZB8XLLvNmjJA=;
        b=l4eDalfJUj0pllGV80lDRU9AC0Jd9nzXPlKUt4SD0cI7JCpw7bySj/g6l6YwHjfp50
         PSjBJsTIeu0xWym2YNMFetiQiFe3BQzSfqM0o+ekQdZQpl6UbepefyKfU/yUpq39rTMI
         vR1C39xzRImRgilD8LWvoEULWFMMFP2dl48HW83cvOLdGbx2ZxPuF9U7c3LsP8QOWNF8
         2iFPxZT3muYf7lfnRjaomP8G3TPaU7p9nlLgejIfaHpbXUT/CVtyeZixrR4CN/7u4rBi
         /URW0rcjsNH4wVDjW6ApB/yIbme21KQqERJ7wY3fAfNYekdSqwpzriI4jbiqe/eiyQqv
         h/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GObApkfHEsPhLdQKUnzBpTACGgx9w+bZB8XLLvNmjJA=;
        b=L9w0rWbL/QOCkOry53+fQXX246XvtyVeyhI2x4TPIT2QMtYCwCASpaEx+S+u/3ky+U
         RBxcPxt1rhphiGrqkMVNNKv9Jp2w91j9QoMZ/XnFqwg2IFc/DQjEGXzbnAwqUCHT4XO1
         L7MKWJ+5l86K53vIoJVnQFSQz+PMEZ3QzEKxOGZMb2xFfC4kNyW3wNVAbEnMdgxqVrS3
         reB5/h33sGsyFCjicoVEdv1XyEQesm64Cf6yVtqV4ig9gcsaSJm+9PrIL0TDc766g5qx
         WULDN+Bu2mhtTD8vZpI8YdYmcm1n7mrI1ez1HyqlL12RWdTR81fUQm+lTLaRJ2xQlxgb
         y4pg==
X-Gm-Message-State: AOAM533iiAYjOjPdx9Bmf7pS9+z07Oyx9MmSit/NnhANhszwfWq3wwZ+
        sd4pmfBjg02YLylrESCMyaI=
X-Google-Smtp-Source: ABdhPJxeuyOUkseS2VfZrAReKh+dvlWO5mIalOv1VpiMegCsiIyQFWZOXM4Q1B9fhYxcM+nXAANkZA==
X-Received: by 2002:a17:90a:a50d:: with SMTP id a13mr17692395pjq.95.1594622551376;
        Sun, 12 Jul 2020 23:42:31 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:31 -0700 (PDT)
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
Subject: [PATCH v5 5/9] mm/migrate: make a standard migration target allocation function
Date:   Mon, 13 Jul 2020 15:41:53 +0900
Message-Id: <1594622517-20681-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Changes should be mechanical, but, unfortunately, there are some
differences. First, some callers' nodemask is assgined to NULL since NULL
nodemask will be considered as all available nodes, that is,
&node_states[N_MEMORY]. Second, for hugetlb page allocation, gfp_mask is
redefined as regular hugetlb allocation gfp_mask plus __GFP_THISNODE if
user provided gfp_mask has it. This is because future caller of this
function requires to set this node constaint. Lastly, if provided nodeid
is NUMA_NO_NODE, nodeid is set up to the node where migration source
lives. It helps to remove simple wrappers for setting up the nodeid.

Note that PageHighmem() call in previous function is changed to open-code
"is_highmem_idx()" since it provides more readability.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/hugetlb.h | 15 +++++++++++++++
 include/linux/migrate.h |  9 +++++----
 mm/internal.h           |  7 +++++++
 mm/memory-failure.c     |  7 +++++--
 mm/memory_hotplug.c     | 12 ++++++++----
 mm/migrate.c            | 26 ++++++++++++++++----------
 mm/page_isolation.c     |  7 +++++--
 7 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bb93e95..6b9508d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -701,6 +701,16 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
 		return GFP_HIGHUSER;
 }
 
+static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
+{
+	gfp_t modified_mask = htlb_alloc_mask(h);
+
+	/* Some callers might want to enfoce node */
+	modified_mask |= (gfp_mask & __GFP_THISNODE);
+
+	return modified_mask;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
@@ -888,6 +898,11 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
 	return 0;
 }
 
+static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
+{
+	return 0;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
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
index cafe65eb..431b470f 100644
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
+	node_clear(mtc.nid, nmask);
 	if (nodes_empty(nmask))
-		node_set(nid, nmask);
+		node_set(mtc.nid, nmask);
 
-	return new_page_nodemask(page, nid, &nmask);
+	return alloc_migration_target(page, (unsigned long)&mtc);
 }
 
 static int
diff --git a/mm/migrate.c b/mm/migrate.c
index 1cfc965..c35ba2a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1531,19 +1531,26 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
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
-						nodemask, gfp_mask);
+		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
+		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
 	}
 
 	if (PageTransHuge(page)) {
@@ -1555,12 +1562,11 @@ struct page *new_page_nodemask(struct page *page,
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

