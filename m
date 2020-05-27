Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8ABA2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKLsqTad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgE0GqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgE0GqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:46:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3425C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q8so11421595pfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WTIBHbG9ywf+5bOFjsTMrV3RtCBfMOdph+RJwfjq5iY=;
        b=qKLsqTad+sCT8l+wzP93vhaKrewOQjXCeqcmgop0NoIo0233Mg2nFOPf4VSll/fk2c
         8tE00RHNScg6J+y70z6VbJ+J0dz/c+jNqFDzfpm6yIaUZrWrFSX+SswvEmwq93FbmgyG
         +teg31e+TOEBEG0lhj5bjzQndK4rWBfknmb9SKxuhVb9yywiag9fF+g26eLjG2yGz6oo
         320qJyFIKd3y3Mp1UQo4Oo6/C655Hnwbtx40mGZTwWPaTDnRO6TROCiFLklw6Je5HK38
         h6TJmpb1gGolMM18DWiWAYp9p4YvOWcls4CGk3w2wlpotU4RxPOtXCgVOr3HViNKYWyR
         6Uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WTIBHbG9ywf+5bOFjsTMrV3RtCBfMOdph+RJwfjq5iY=;
        b=CXhSZ54NqokoRJdeWFhrdeNgRxQbKm/SRJxjSd4gx7+soBgNvd81zy3iT66d0SsMsk
         HAIKQvncjYL4TVoZBfoUPA6vDbfoIiUg53P6rGlSeWhdStqpmcBmfvi7tUFvrtplBdb2
         4sf5q+oGRJe+tLa5hLLCV+aqnl75sON6ztPLnzgRANoNoHoGBYOF+AA488g/UjNoFs9o
         HyCMaz004QaSL6JiIyARbuyU66ha68455FJNq7kPeJj3paDRjuaUzagWe3nztk7CWtvF
         2+PJGFeoWjIEv7xFQrSDMQT+gYpkas0rlbEc7m4DtgBEdxKAszzCDnvP3nQG9qtbURwt
         IWMA==
X-Gm-Message-State: AOAM530q9ThKyBUfhbKe8uBMFzSYfTHzS9eh8kevFCOIMr8xkg+Ev5z2
        jfQpI9vGr4GJm1TzRXipJIY=
X-Google-Smtp-Source: ABdhPJxCRfhVOLnntWyjrbSBHnYHEXVCEtDltkLS0BGxz3FcolmIoUioyr/fKK5O/sjS1BZOkkmUqg==
X-Received: by 2002:a63:724a:: with SMTP id c10mr1035093pgn.130.1590561969115;
        Tue, 26 May 2020 23:46:09 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r13sm443883pgv.50.2020.05.26.23.46.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:46:08 -0700 (PDT)
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
Subject: [PATCH v2 08/12] mm/migrate: change the interface of the migration target alloc/free functions
Date:   Wed, 27 May 2020 15:44:59 +0900
Message-Id: <1590561903-13186-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index 9ce4cff..538ed7b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1563,9 +1563,9 @@ static void isolate_freepages(struct compact_control *cc)
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
@@ -1587,9 +1587,9 @@ static struct page *compaction_alloc(struct page *migratepage,
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
@@ -2097,6 +2097,9 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
+	struct alloc_control alloc_control = {
+		.private = (unsigned long)cc,
+	};
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2214,8 +2217,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 		}
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
-				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				compaction_free, &alloc_control,
+				cc->mode, MR_COMPACTION);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index 87eca79..a49d7ea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1593,7 +1593,8 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 }
 
 #ifdef CONFIG_CMA
-static struct page *new_non_cma_page(struct page *page, unsigned long private)
+static struct page *new_non_cma_page(struct page *page,
+				struct alloc_control *ac)
 {
 	/*
 	 * We want to make sure we allocate the new page from the same node
@@ -1706,7 +1707,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 			put_page(pages[i]);
 
 		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+				  NULL, NULL, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
diff --git a/mm/internal.h b/mm/internal.h
index 2dc0268..6f5d810 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -612,13 +612,16 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 }
 
 void setup_zone_pageset(struct zone *zone);
-extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+struct alloc_control;
+extern struct page *alloc_new_node_page(struct page *page,
+				struct alloc_control *ac);
 
 struct alloc_control {
 	int nid;		/* preferred node id */
 	nodemask_t *nmask;
 	gfp_t gfp_mask;
 	bool skip_cma;
+	unsigned long private;
 
 	gfp_t __gfp_mask;	/* Used internally in API implementation */
 };
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c4afb40..0d5d59b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1634,11 +1634,14 @@ int unpoison_memory(unsigned long pfn)
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
@@ -1735,7 +1738,7 @@ static int soft_offline_huge_page(struct page *page, int flags)
 		return -EBUSY;
 	}
 
-	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
+	ret = migrate_pages(&pagelist, new_page, NULL, NULL,
 				MIGRATE_SYNC, MR_MEMORY_FAILURE);
 	if (ret) {
 		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
@@ -1825,7 +1828,7 @@ static int __soft_offline_page(struct page *page, int flags)
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
index e705efd..e50c3eb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1066,12 +1066,12 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 }
 
 /* page allocation callback for NUMA node migration */
-struct page *alloc_new_node_page(struct page *page, unsigned long node)
+struct page *alloc_new_node_page(struct page *page, struct alloc_control *__ac)
 {
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(compound_head(page));
 		struct alloc_control ac = {
-			.nid = node,
+			.nid = __ac->nid,
 			.nmask = NULL,
 			.gfp_mask = __GFP_THISNODE,
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
index 30217537..9d6ed94 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1192,7 +1192,7 @@ static inline void thp_pmd_migration_success(bool success)
  */
 static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 				   free_page_t put_new_page,
-				   unsigned long private, struct page *page,
+				   struct alloc_control *ac, struct page *page,
 				   int force, enum migrate_mode mode,
 				   enum migrate_reason reason)
 {
@@ -1215,7 +1215,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		goto out;
 	}
 
-	newpage = get_new_page(page, private);
+	newpage = get_new_page(page, ac);
 	if (!newpage)
 		return -ENOMEM;
 
@@ -1283,7 +1283,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		}
 put_new:
 		if (put_new_page)
-			put_new_page(newpage, private);
+			put_new_page(newpage, ac);
 		else
 			put_page(newpage);
 	}
@@ -1310,9 +1310,9 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
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
@@ -1332,7 +1332,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		return -ENOSYS;
 	}
 
-	new_hpage = get_new_page(hpage, private);
+	new_hpage = get_new_page(hpage, ac);
 	if (!new_hpage)
 		return -ENOMEM;
 
@@ -1419,7 +1419,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	 * isolation.
 	 */
 	if (put_new_page)
-		put_new_page(new_hpage, private);
+		put_new_page(new_hpage, ac);
 	else
 		putback_active_hugepage(new_hpage);
 
@@ -1448,7 +1448,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
  * Returns the number of pages that were not migrated, or an error code.
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
-		free_page_t put_new_page, unsigned long private,
+		free_page_t put_new_page, struct alloc_control *ac,
 		enum migrate_mode mode, int reason)
 {
 	int retry = 1;
@@ -1472,11 +1472,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 
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
@@ -1537,8 +1537,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	return rc;
 }
 
-struct page *new_page_nodemask(struct page *page,
-				int preferred_nid, nodemask_t *nodemask)
+struct page *new_page_nodemask(struct page *page, struct alloc_control *ac)
 {
 	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
 	unsigned int order = 0;
@@ -1546,12 +1545,12 @@ struct page *new_page_nodemask(struct page *page,
 
 	if (PageHuge(page)) {
 		struct hstate *h = page_hstate(compound_head(page));
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
@@ -1562,8 +1561,7 @@ struct page *new_page_nodemask(struct page *page,
 	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
 		gfp_mask |= __GFP_HIGHMEM;
 
-	new_page = __alloc_pages_nodemask(gfp_mask, order,
-				preferred_nid, nodemask);
+	new_page = __alloc_pages_nodemask(gfp_mask, order, ac->nid, ac->nmask);
 
 	if (new_page && PageTransHuge(new_page))
 		prep_transhuge_page(new_page);
@@ -1588,8 +1586,11 @@ static int do_move_pages_to_node(struct mm_struct *mm,
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
@@ -1979,12 +1980,11 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
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
@@ -2049,6 +2049,9 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	int isolated;
 	int nr_remaining;
 	LIST_HEAD(migratepages);
+	struct alloc_control ac = {
+		.nid = node,
+	};
 
 	/*
 	 * Don't migrate file pages that are mapped in multiple processes
@@ -2071,7 +2074,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
-				     NULL, node, MIGRATE_ASYNC,
+				     NULL, &ac, MIGRATE_ASYNC,
 				     MR_NUMA_MISPLACED);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 940cdce..9803158 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8386,7 +8386,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
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

