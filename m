Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE20C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF360206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHRSsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:48:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:14556 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgHRSsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:48:16 -0400
IronPort-SDR: 6vghEgw4G/r7Ipa5naB9p17mIEcXhIC//avFBqrugD7jLcgj1z32tO7IygyJbxkkOmsnjBYweb
 oTlVFbUE2N1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135055366"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="135055366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:48:08 -0700
IronPort-SDR: IcdJDYfAfpzi7MB/UTniu4kuQzlQhBIhkMBoXAkEZNd/IbVWkiREdqeG6qSfvCenkvAxrf991e
 jPQPG3ztMAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="310536908"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2020 11:48:08 -0700
Subject: [RFC][PATCH 4/9] mm/migrate: make migrate_pages() return nr_succeeded
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Aug 2020 11:41:29 -0700
References: <20200818184122.29C415DF@viggo.jf.intel.com>
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
Message-Id: <20200818184129.14758DAD@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yang Shi <yang.shi@linux.alibaba.com>

The migrate_pages() returns the number of pages that were not migrated,
or an error code.  When returning an error code, there is no way to know
how many pages were migrated or not migrated.

In the following patch, migrate_pages() is used to demote pages to PMEM
node, we need account how many pages are reclaimed (demoted) since page
reclaim behavior depends on this.  Add *nr_succeeded parameter to make
migrate_pages() return how many pages are demoted successfully for all
cases.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/include/linux/migrate.h |    5 +++--
 b/mm/compaction.c         |    3 ++-
 b/mm/gup.c                |    4 +++-
 b/mm/memory-failure.c     |    7 +++++--
 b/mm/memory_hotplug.c     |    4 +++-
 b/mm/mempolicy.c          |    7 +++++--
 b/mm/migrate.c            |   18 ++++++++++--------
 b/mm/page_alloc.c         |    4 +++-
 8 files changed, 34 insertions(+), 18 deletions(-)

diff -puN include/linux/migrate.h~migrate_pages-add-success-return include/linux/migrate.h
--- a/include/linux/migrate.h~migrate_pages-add-success-return	2020-08-18 11:36:51.270583183 -0700
+++ b/include/linux/migrate.h	2020-08-18 11:36:51.291583183 -0700
@@ -66,7 +66,8 @@ extern int migrate_page(struct address_s
 			struct page *newpage, struct page *page,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
-		unsigned long private, enum migrate_mode mode, int reason);
+		unsigned long private, enum migrate_mode mode, int reason,
+		unsigned int *nr_succeeded);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 extern void putback_movable_page(struct page *page);
 
@@ -83,7 +84,7 @@ extern int migrate_page_move_mapping(str
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
-		int reason)
+		int reason, unsigned int *nr_succeeded)
 	{ return -ENOSYS; }
 static inline int isolate_movable_page(struct page *page, isolate_mode_t mode)
 	{ return -EBUSY; }
diff -puN mm/compaction.c~migrate_pages-add-success-return mm/compaction.c
--- a/mm/compaction.c~migrate_pages-add-success-return	2020-08-18 11:36:51.272583183 -0700
+++ b/mm/compaction.c	2020-08-18 11:36:51.291583183 -0700
@@ -2088,6 +2088,7 @@ compact_zone(struct compact_control *cc,
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
+	unsigned int nr_succeeded = 0;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2206,7 +2207,7 @@ compact_zone(struct compact_control *cc,
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				MR_COMPACTION, &nr_succeeded);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff -puN mm/gup.c~migrate_pages-add-success-return mm/gup.c
--- a/mm/gup.c~migrate_pages-add-success-return	2020-08-18 11:36:51.275583183 -0700
+++ b/mm/gup.c	2020-08-18 11:36:51.292583183 -0700
@@ -1671,6 +1671,7 @@ static long check_and_migrate_cma_pages(
 	unsigned long step;
 	bool drain_allow = true;
 	bool migrate_allow = true;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(cma_page_list);
 	long ret = nr_pages;
 
@@ -1719,7 +1720,8 @@ check_again:
 			put_page(pages[i]);
 
 		if (migrate_pages(&cma_page_list, new_non_cma_page,
-				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
+				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE,
+				  &nr_succeeded)) {
 			/*
 			 * some of the pages failed migration. Do get_user_pages
 			 * without migration.
diff -puN mm/memory-failure.c~migrate_pages-add-success-return mm/memory-failure.c
--- a/mm/memory-failure.c~migrate_pages-add-success-return	2020-08-18 11:36:51.277583183 -0700
+++ b/mm/memory-failure.c	2020-08-18 11:36:51.293583183 -0700
@@ -1721,6 +1721,7 @@ static int soft_offline_huge_page(struct
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
 	struct page *hpage = compound_head(page);
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(pagelist);
 
 	/*
@@ -1748,7 +1749,7 @@ static int soft_offline_huge_page(struct
 	}
 
 	ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-				MIGRATE_SYNC, MR_MEMORY_FAILURE);
+				MIGRATE_SYNC, MR_MEMORY_FAILURE, &nr_succeeded);
 	if (ret) {
 		pr_info("soft offline: %#lx: hugepage migration failed %d, type %lx (%pGp)\n",
 			pfn, ret, page->flags, &page->flags);
@@ -1779,6 +1780,7 @@ static int __soft_offline_page(struct pa
 {
 	int ret;
 	unsigned long pfn = page_to_pfn(page);
+	unsigned int nr_succeeded = 0;
 
 	/*
 	 * Check PageHWPoison again inside page lock because PageHWPoison
@@ -1838,7 +1840,8 @@ static int __soft_offline_page(struct pa
 						page_is_file_lru(page));
 		list_add(&page->lru, &pagelist);
 		ret = migrate_pages(&pagelist, new_page, NULL, MPOL_MF_MOVE_ALL,
-					MIGRATE_SYNC, MR_MEMORY_FAILURE);
+					MIGRATE_SYNC, MR_MEMORY_FAILURE,
+					&nr_succeeded);
 		if (ret) {
 			if (!list_empty(&pagelist))
 				putback_movable_pages(&pagelist);
diff -puN mm/memory_hotplug.c~migrate_pages-add-success-return mm/memory_hotplug.c
--- a/mm/memory_hotplug.c~migrate_pages-add-success-return	2020-08-18 11:36:51.279583183 -0700
+++ b/mm/memory_hotplug.c	2020-08-18 11:36:51.294583183 -0700
@@ -1282,6 +1282,7 @@ do_migrate_range(unsigned long start_pfn
 	unsigned long pfn;
 	struct page *page;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(source);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -1338,7 +1339,8 @@ do_migrate_range(unsigned long start_pfn
 	if (!list_empty(&source)) {
 		/* Allocate a new page from the nearest neighbor node */
 		ret = migrate_pages(&source, new_node_page, NULL, 0,
-					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+					MIGRATE_SYNC, MR_MEMORY_HOTPLUG,
+					&nr_succeeded);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
diff -puN mm/mempolicy.c~migrate_pages-add-success-return mm/mempolicy.c
--- a/mm/mempolicy.c~migrate_pages-add-success-return	2020-08-18 11:36:51.282583183 -0700
+++ b/mm/mempolicy.c	2020-08-18 11:36:51.294583183 -0700
@@ -1096,6 +1096,7 @@ static int migrate_to_node(struct mm_str
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
+	unsigned int nr_succeeded = 0;
 
 	nodes_clear(nmask);
 	node_set(source, nmask);
@@ -1111,7 +1112,7 @@ static int migrate_to_node(struct mm_str
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
-					MIGRATE_SYNC, MR_SYSCALL);
+					MIGRATE_SYNC, MR_SYSCALL, &nr_succeeded);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
@@ -1288,6 +1289,7 @@ static long do_mbind(unsigned long start
 		     nodemask_t *nmask, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned int nr_succeeded = 0;
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
@@ -1369,7 +1371,8 @@ static long do_mbind(unsigned long start
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND,
+				&nr_succeeded);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff -puN mm/migrate.c~migrate_pages-add-success-return mm/migrate.c
--- a/mm/migrate.c~migrate_pages-add-success-return	2020-08-18 11:36:51.284583183 -0700
+++ b/mm/migrate.c	2020-08-18 11:36:51.295583183 -0700
@@ -1432,6 +1432,7 @@ out:
  * @mode:		The migration mode that specifies the constraints for
  *			page migration, if any.
  * @reason:		The reason for page migration.
+ * @nr_succeeded:	The number of pages migrated successfully.
  *
  * The function returns after 10 attempts or if no pages are movable any more
  * because the list has become empty or no retryable pages exist any more.
@@ -1442,11 +1443,10 @@ out:
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason)
+		enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
 {
 	int retry = 1;
 	int nr_failed = 0;
-	int nr_succeeded = 0;
 	int pass = 0;
 	struct page *page;
 	struct page *page2;
@@ -1500,7 +1500,7 @@ retry:
 				retry++;
 				break;
 			case MIGRATEPAGE_SUCCESS:
-				nr_succeeded++;
+				(*nr_succeeded)++;
 				break;
 			default:
 				/*
@@ -1517,11 +1517,11 @@ retry:
 	nr_failed += retry;
 	rc = nr_failed;
 out:
-	if (nr_succeeded)
-		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
+	if (*nr_succeeded)
+		count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
 	if (nr_failed)
 		count_vm_events(PGMIGRATE_FAIL, nr_failed);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
+	trace_mm_migrate_pages(*nr_succeeded, nr_failed, mode, reason);
 
 	if (!swapwrite)
 		current->flags &= ~PF_SWAPWRITE;
@@ -1546,9 +1546,10 @@ static int do_move_pages_to_node(struct
 		struct list_head *pagelist, int node)
 {
 	int err;
+	unsigned int nr_succeeded = 0;
 
 	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
-			MIGRATE_SYNC, MR_SYSCALL);
+			MIGRATE_SYNC, MR_SYSCALL, &nr_succeeded);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
@@ -2006,6 +2007,7 @@ int migrate_misplaced_page(struct page *
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(migratepages);
 
 	/*
@@ -2030,7 +2032,7 @@ int migrate_misplaced_page(struct page *
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
 				     NULL, node, MIGRATE_ASYNC,
-				     MR_NUMA_MISPLACED);
+				     MR_NUMA_MISPLACED, &nr_succeeded);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
diff -puN mm/page_alloc.c~migrate_pages-add-success-return mm/page_alloc.c
--- a/mm/page_alloc.c~migrate_pages-add-success-return	2020-08-18 11:36:51.287583183 -0700
+++ b/mm/page_alloc.c	2020-08-18 11:36:51.298583183 -0700
@@ -8341,6 +8341,7 @@ static int __alloc_contig_migrate_range(
 	unsigned long pfn = start;
 	unsigned int tries = 0;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 
 	migrate_prep();
 
@@ -8368,7 +8369,8 @@ static int __alloc_contig_migrate_range(
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
-				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
+				    NULL, 0, cc->mode, MR_CONTIG_RANGE,
+				    &nr_succeeded);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
_
