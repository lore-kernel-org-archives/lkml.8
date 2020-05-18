Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD696C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADB420835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siXBVrpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgERBWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgERBWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:22:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC01C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k19so3541510pll.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ax7HelbESmDJU+3iItiFOyErZms85pUVAuGI5qs+cvo=;
        b=siXBVrpqVixbL1tBXFaK1EBLOonvpDc+xE+hX7puIX48kO4ooRtTDJFEGP2hUGHTp0
         CXmD5l/hg4QuQMd1TfjBLy7+iIIQ1sTRGl3voRbWrZ97UHSNXLLJAo5zLfssaw8GVxXi
         AmThj8zAXQNkDZLInXcD/hxMZ/jmGmW5rIrlsFM1vVKEueDH9ar4h23+PRgcmLK6aWsY
         BQnyWqaGB5h7FN+ojfr7pAtzGdf1Z8NPKuutfx4xhB0/hTVn8tNQ3xw/HehDrqCi0wZx
         CgO3rY8/vWnIwOoLSALx/XYqirkgcbCKKXkheNtvsppAMZeI7MmZRUgQbH3s5Mcm7THF
         K2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ax7HelbESmDJU+3iItiFOyErZms85pUVAuGI5qs+cvo=;
        b=FkKSmpECyO0CeDHxK51wUpbw9rjV2Qlo/+XPHKOsOuLpuk7GT4Ia/pHzQD8/Y+NWau
         8fJrBlv9EW7gfjNmiD/BTQ6yQeeqXoKKRewuHEUokgXKRkpG4H6v5uicuzEqPz/aY/o2
         AldvTZcbIqiwox6H8JJzI6MCo2ltCGVpp4ryc0WvOrG3nKuO9xtLXZNQcj0Fu3NBNDij
         FlgRGeB6TTzTrhRf/Tv/tD17Xi8Efp7o1yLsFCmlvbKSsQBwKnk/px74tmLNWozVey/2
         8C4JGRHHS13MfV3zLsbdDOYlQjbwHqsUCVw85w97UyESihe4A/8DkN99ASF5KKdyLyn4
         SzPQ==
X-Gm-Message-State: AOAM532IcceRlFK4oUb3foFC2YtnC1U4Hnx8/fSxoHT9qdWwa5/IrL0S
        6B4xnpfmdFf3OVaTdZ4Bu0M=
X-Google-Smtp-Source: ABdhPJyS6Ber8qYEnLylA6TQqvJI2A/o3x+dzlz9FkIetkf72QcBtyCGYyB7Mt00WlY24xiQhw0kpw==
X-Received: by 2002:a17:90b:10f:: with SMTP id p15mr4104221pjz.99.1589764922459;
        Sun, 17 May 2020 18:22:02 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id fw4sm1544376pjb.31.2020.05.17.18.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 18:22:02 -0700 (PDT)
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
Subject: [PATCH 07/11] mm/migrate: change the interface of the migration target alloc/free functions
Date:   Mon, 18 May 2020 10:20:53 +0900
Message-Id: <1589764857-6800-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

To prepare unifying duplicated functions in following patches, this patch
changes the interface of the migration target alloc/free functions.
Functions now use struct alloc_control as an argument.

There is no functional change.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/migrate.h        | 15 +++++++------
 include/linux/page-isolation.h |  4 +++-
 mm/compaction.c                | 15 ++++++++-----
 mm/gup.c                       |  5 +++--
 mm/internal.h                  |  5 ++++-
 mm/memory-failure.c            | 13 ++++++-----
 mm/memory_hotplug.c            |  9 +++++---
 mm/mempolicy.c                 | 22 +++++++++++-------
 mm/migrate.c                   | 51 ++++++++++++++++++++++--------------------
 mm/page_alloc.c                |  2 +-
 mm/page_isolation.c            |  9 +++++---
 11 files changed, 89 insertions(+), 61 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 1d70b4a..923c4f3 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -7,8 +7,9 @@
 #include <linux/migrate_mode.h>
 #include <linux/hugetlb.h>
 
-typedef struct page *new_page_t(struct page *page, unsigned long private);
-typedef void free_page_t(struct page *page, unsigned long private);
+struct alloc_control;
+typedef struct page *new_page_t(struct page *page, struct alloc_control *ac);
+typedef void free_page_t(struct page *page, struct alloc_control *ac);
 
 /*
  * Return values from addresss_space_operations.migratepage():
@@ -38,9 +39,9 @@ extern int migrate_page(struct address_space *mapping,
 			struct page *newpage, struct page *page,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
-		unsigned long private, enum migrate_mode mode, int reason);
+		struct alloc_control *ac, enum migrate_mode mode, int reason);
 extern struct page *new_page_nodemask(struct page *page,
-		int preferred_nid, nodemask_t *nodemask);
+		struct alloc_control *ac);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
@@ -56,11 +57,11 @@ extern int migrate_page_move_mapping(struct address_space *mapping,
 
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
-		free_page_t free, unsigned long private, enum migrate_mode mode,
-		int reason)
+			free_page_t free, struct alloc_control *ac,
+			enum migrate_mode mode, int reason)
 	{ return -ENOSYS; }
 static inline struct page *new_page_nodemask(struct page *page,
-		int preferred_nid, nodemask_t *nodemask)
+		struct alloc_control *ac)
 	{ return NULL; }
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 5724580..35e3bdb 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_PAGEISOLATION_H
 #define __LINUX_PAGEISOLATION_H
 
+struct alloc_control;
+
 #ifdef CONFIG_MEMORY_ISOLATION
 static inline bool has_isolate_pageblock(struct zone *zone)
 {
@@ -60,6 +62,6 @@ undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 			int isol_flags);
 
-struct page *alloc_migrate_target(struct page *page, unsigned long private);
+struct page *alloc_migrate_target(struct page *page, struct alloc_control *ac);
 
 #endif
diff --git a/mm/compaction.c b/mm/compaction.c
index 67fd317..aec1c1f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1561,9 +1561,9 @@ static void isolate_freepages(struct compact_control *cc)
  * from the isolated freelists in the block we are migrating to.
  */
 static struct page *compaction_alloc(struct page *migratepage,
-					unsigned long data)
+					struct alloc_control *ac)
 {
-	struct compact_control *cc = (struct compact_control *)data;
+	struct compact_control *cc = (struct compact_control *)ac->private;
 	struct page *freepage;
 
 	if (list_empty(&cc->freepages)) {
@@ -1585,9 +1585,9 @@ static struct page *compaction_alloc(struct page *migratepage,
  * freelist.  All pages on the freelist are from the same zone, so there is no
  * special handling needed for NUMA.
  */
-static void compaction_free(struct page *page, unsigned long data)
+static void compaction_free(struct page *page, struct alloc_control *ac)
 {
-	struct compact_control *cc = (struct compact_control *)data;
+	struct compact_control *cc = (struct compact_control *)ac->private;
 
 	list_add(&page->lru, &cc->freepages);
 	cc->nr_freepages++;
@@ -2095,6 +2095,9 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
+	struct alloc_control alloc_control = {
+		.private = (unsigned long)cc,
+	};
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2212,8 +2215,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		}
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
-				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				compaction_free, &alloc_control,
+				cc->mode, MR_COMPACTION);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index 1c86db5..be9cb79 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1594,7 +1594,8 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 }
 
 #ifdef CONFIG_CMA
-static struct page *new_non_cma_page(struct page *page, unsigned long private)
+static struct page *new_non_cma_page(struct page *page,
+				struct alloc_control *ac)
 {
 	/*
 	 * We want to make sure we allocate the new page from the same node
@@ -1707,7 +1708,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 			put_page(pages[i]);
 
 		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+				  NULL, NULL, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
diff --git a/mm/internal.h b/mm/internal.h
index 3239d71..abe94a7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -612,7 +612,9 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+struct alloc_control;
+extern struct page *alloc_new_node_page(struct page *page,
+				struct alloc_control *ac);
 
 struct alloc_control {
 	int nid;
@@ -620,6 +622,7 @@ struct alloc_control {
 	gfp_t gfp_mask;
 	bool thisnode;
 	bool skip_cma;
+	unsigned long private;
 
 	gfp_t __gfp_mask;	/* Used internally in API implementation */
 };
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a96364b..3f92e70 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1621,11 +1621,14 @@ int unpoison_memory(unsigned long pfn)
 }
 EXPORT_SYMBOL(unpoison_memory);
 
-static struct page *new_page(struct page *p, unsigned long private)
+static struct page *new_page(struct page *p, struct alloc_control *__ac)
 {
-	int nid = page_to_nid(p);
+	struct alloc_control ac = {
+		.nid = page_to_nid(p),
+		.nmask = &node_states[N_MEMORY],
+	};
 
-	return new_page_nodemask(p, nid, &node_states[N_MEMORY]);
+	return new_page_nodemask(p, &ac);
 }
 
 /*
@@ -1722,7 +1725,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		return -EBUSY;
 	}
 
-	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
+	ret = migrate_pages(&pagelist, new_page, NULL, NULL,
 				MIGRATE_SYNC, MR_MEMORY_FAILURE);
 	if (ret) {
 		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
@@ -1812,7 +1815,7 @@ static int __soft_offline_page(struct page *page, int flags)
 			inc_node_page_state(page, NR_ISOLATED_ANON +
 						page_is_file_lru(page));
 		list_add(&page->lru, &pagelist);
-		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
+		ret = migrate_pages(&pagelist, new_page, NULL, NULL,
 					MIGRATE_SYNC, MR_MEMORY_FAILURE);
 		if (ret) {
 			if (!list_empty(&pagelist))
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c4d5c45..89642f9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1232,10 +1232,11 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 	return 0;
 }
 
-static struct page *new_node_page(struct page *page, unsigned long private)
+static struct page *new_node_page(struct page *page, struct alloc_control *__ac)
 {
 	int nid = page_to_nid(page);
 	nodemask_t nmask = node_states[N_MEMORY];
+	struct alloc_control ac = {0};
 
 	/*
 	 * try to allocate from a different node but reuse this node if there
@@ -1246,7 +1247,9 @@ static struct page *new_node_page(struct page *page, unsigned long private)
 	if (nodes_empty(nmask))
 		node_set(nid, nmask);
 
-	return new_page_nodemask(page, nid, &nmask);
+	ac.nid = nid;
+	ac.nmask = &nmask;
+	return new_page_nodemask(page, &ac);
 }
 
 static int
@@ -1310,7 +1313,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	}
 	if (!list_empty(&source)) {
 		/* Allocate a new page from the nearest neighbor node */
-		ret = migrate_pages(&source, new_node_page, NULL, 0,
+		ret = migrate_pages(&source, new_node_page, NULL, NULL,
 					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 629feaa..7241621 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1066,12 +1066,12 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 }
 
 /* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, unsigned long node)
+struct page *alloc_new_node_page(struct page *page, struct alloc_control *__ac)
 {
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
 		struct alloc_control ac = {
-			.nid = node,
+			.nid = __ac->nid,
 			.nmask = NULL,
 			.thisnode = true,
 		};
@@ -1080,7 +1080,7 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
 	} else if (PageTransHuge(page)) {
 		struct page *thp;
 
-		thp = alloc_pages_node(node,
+		thp = alloc_pages_node(__ac->nid,
 			(GFP_TRANSHUGE | __GFP_THISNODE),
 			HPAGE_PMD_ORDER);
 		if (!thp)
@@ -1088,7 +1088,7 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
 		prep_transhuge_page(thp);
 		return thp;
 	} else
-		return __alloc_pages_node(node, GFP_HIGHUSER_MOVABLE |
+		return __alloc_pages_node(__ac->nid, GFP_HIGHUSER_MOVABLE |
 						    __GFP_THISNODE, 0);
 }
 
@@ -1102,6 +1102,9 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
+	struct alloc_control ac = {
+		.nid = dest,
+	};
 
 	nodes_clear(nmask);
 	node_set(source, nmask);
@@ -1116,7 +1119,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
-		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
+		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, &ac,
 					MIGRATE_SYNC, MR_SYSCALL);
 		if (err)
 			putback_movable_pages(&pagelist);
@@ -1237,10 +1240,11 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
  * list of pages handed to migrate_pages()--which is how we get here--
  * is in virtual address order.
  */
-static struct page *new_page(struct page *page, unsigned long start)
+static struct page *new_page(struct page *page, struct alloc_control *ac)
 {
 	struct vm_area_struct *vma;
 	unsigned long uninitialized_var(address);
+	unsigned long start = ac->private;
 
 	vma = find_vma(current->mm, start);
 	while (vma) {
@@ -1283,7 +1287,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	return -ENOSYS;
 }
 
-static struct page *new_page(struct page *page, unsigned long start)
+static struct page *new_page(struct page *page, struct alloc_control *ac)
 {
 	return NULL;
 }
@@ -1299,6 +1303,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	int err;
 	int ret;
 	LIST_HEAD(pagelist);
+	struct alloc_control ac = {0};
 
 	if (flags & ~(unsigned long)MPOL_MF_VALID)
 		return -EINVAL;
@@ -1374,8 +1379,9 @@ static long do_mbind(unsigned long start, unsigned long len,
 
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
+			ac.private = start;
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+				&ac, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index 94d2386..ba31153 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1183,7 +1183,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
  */
 static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 				   free_page_t put_new_page,
-				   unsigned long private, struct page *page,
+				   struct alloc_control *ac, struct page *page,
 				   int force, enum migrate_mode mode,
 				   enum migrate_reason reason)
 {
@@ -1206,7 +1206,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		goto out;
 	}
 
-	newpage = get_new_page(page, private);
+	newpage = get_new_page(page, ac);
 	if (!newpage)
 		return -ENOMEM;
 
@@ -1266,7 +1266,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		}
 put_new:
 		if (put_new_page)
-			put_new_page(newpage, private);
+			put_new_page(newpage, ac);
 		else
 			put_page(newpage);
 	}
@@ -1293,9 +1293,9 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
  * will wait in the page fault for migration to complete.
  */
 static int unmap_and_move_huge_page(new_page_t get_new_page,
-				free_page_t put_new_page, unsigned long private,
-				struct page *hpage, int force,
-				enum migrate_mode mode, int reason)
+			free_page_t put_new_page, struct alloc_control *ac,
+			struct page *hpage, int force,
+			enum migrate_mode mode, int reason)
 {
 	int rc = -EAGAIN;
 	int page_was_mapped = 0;
@@ -1315,7 +1315,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		return -ENOSYS;
 	}
 
-	new_hpage = get_new_page(hpage, private);
+	new_hpage = get_new_page(hpage, ac);
 	if (!new_hpage)
 		return -ENOMEM;
 
@@ -1402,7 +1402,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	 * isolation.
 	 */
 	if (put_new_page)
-		put_new_page(new_hpage, private);
+		put_new_page(new_hpage, ac);
 	else
 		putback_active_hugepage(new_hpage);
 
@@ -1431,7 +1431,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
  * Returns the number of pages that were not migrated, or an error code.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
-		free_page_t put_new_page, unsigned long private,
+		free_page_t put_new_page, struct alloc_control *ac,
 		enum migrate_mode mode, int reason)
 {
 	int retry = 1;
@@ -1455,11 +1455,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
 			if (PageHuge(page))
 				rc = unmap_and_move_huge_page(get_new_page,
-						put_new_page, private, page,
+						put_new_page, ac, page,
 						pass > 2, mode, reason);
 			else
 				rc = unmap_and_move(get_new_page, put_new_page,
-						private, page, pass > 2, mode,
+						ac, page, pass > 2, mode,
 						reason);
 
 			switch(rc) {
@@ -1519,8 +1519,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
-struct page *new_page_nodemask(struct page *page,
-				int preferred_nid, nodemask_t *nodemask)
+struct page *new_page_nodemask(struct page *page, struct alloc_control *ac)
 {
 	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
 	unsigned int order = 0;
@@ -1528,12 +1527,12 @@ struct page *new_page_nodemask(struct page *page,
 
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(page);
-		struct alloc_control ac = {
-			.nid = preferred_nid,
-			.nmask = nodemask,
+		struct alloc_control __ac = {
+			.nid = ac->nid,
+			.nmask = ac->nmask,
 		};
 
-		return alloc_huge_page_nodemask(h, &ac);
+		return alloc_huge_page_nodemask(h, &__ac);
 	}
 
 	if (PageTransHuge(page)) {
@@ -1544,8 +1543,7 @@ struct page *new_page_nodemask(struct page *page,
 	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
 		gfp_mask |= __GFP_HIGHMEM;
 
-	new_page = __alloc_pages_nodemask(gfp_mask, order,
-				preferred_nid, nodemask);
+	new_page = __alloc_pages_nodemask(gfp_mask, order, ac->nid, ac->nmask);
 
 	if (new_page && PageTransHuge(new_page))
 		prep_transhuge_page(new_page);
@@ -1570,8 +1568,11 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 		struct list_head *pagelist, int node)
 {
 	int err;
+	struct alloc_control ac = {
+		.nid = node,
+	};
 
-	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
+	err = migrate_pages(pagelist, alloc_new_node_page, NULL, &ac,
 			MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
 		putback_movable_pages(pagelist);
@@ -1961,12 +1962,11 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
 }
 
 static struct page *alloc_misplaced_dst_page(struct page *page,
-					   unsigned long data)
+					struct alloc_control *ac)
 {
-	int nid = (int) data;
 	struct page *newpage;
 
-	newpage = __alloc_pages_node(nid,
+	newpage = __alloc_pages_node(ac->nid,
 					 (GFP_HIGHUSER_MOVABLE |
 					  __GFP_THISNODE | __GFP_NOMEMALLOC |
 					  __GFP_NORETRY | __GFP_NOWARN) &
@@ -2031,6 +2031,9 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	int isolated;
 	int nr_remaining;
 	LIST_HEAD(migratepages);
+	struct alloc_control ac = {
+		.nid = node,
+	};
 
 	/*
 	 * Don't migrate file pages that are mapped in multiple processes
@@ -2053,7 +2056,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
-				     NULL, node, MIGRATE_ASYNC,
+				     NULL, &ac, MIGRATE_ASYNC,
 				     MR_NUMA_MISPLACED);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cef05d3..afdd0fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8315,7 +8315,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
-				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
+				    NULL, NULL, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7df89bd..1e1828b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -298,9 +298,12 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	return pfn < end_pfn ? -EBUSY : 0;
 }
 
-struct page *alloc_migrate_target(struct page *page, unsigned long private)
+struct page *alloc_migrate_target(struct page *page, struct alloc_control *__ac)
 {
-	int nid = page_to_nid(page);
+	struct alloc_control ac = {
+		.nid = page_to_nid(page),
+		.nmask = &node_states[N_MEMORY],
+	};
 
-	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
+	return new_page_nodemask(page, &ac);
 }
-- 
2.7.4

