Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA575C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD86420772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHRSsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:48:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:36197 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHRSsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:48:11 -0400
IronPort-SDR: 0TO4+8OwnQQwVFTpdb26Fh7NSQOlDOWl73utp92ZQgr2Fa/e6M4vP3UgzbZLggPPEiMHU/aTmp
 2IaG4j++cE8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142809598"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="142809598"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:48:10 -0700
IronPort-SDR: gqj8GtKH/0yWT/6NQ5AEtu8NmGb/hp6XGEkasdkPP8wX4SARFM4z0kI+BjYYor7j750rmB+pDB
 Ne4OV2HDMpHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="278118943"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2020 11:48:10 -0700
Subject: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Aug 2020 11:41:31 -0700
References: <20200818184122.29C415DF@viggo.jf.intel.com>
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
Message-Id: <20200818184131.C972AFCC@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

This is mostly derived from a patch from Yang Shi:

	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/

Add code to the reclaim path (shrink_page_list()) to "demote" data
to another NUMA node instead of discarding the data.  This always
avoids the cost of I/O needed to read the page back in and sometimes
avoids the writeout cost when the pagee is dirty.

Note: This just adds the start of infratructure for migration. It is
actually disabled next to the FIXME in migrate_demote_page_ok().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/include/linux/migrate.h |    2 
 b/mm/vmscan.c             |   93 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff -puN include/linux/migrate.h~demote-with-migrate_pages include/linux/migrate.h
--- a/include/linux/migrate.h~demote-with-migrate_pages	2020-08-18 11:36:52.916583179 -0700
+++ b/include/linux/migrate.h	2020-08-18 11:36:52.923583179 -0700
@@ -25,6 +25,7 @@ enum migrate_reason {
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
+	MR_DEMOTION,
 	MR_TYPES
 };
 
@@ -210,6 +211,7 @@ struct migrate_vma {
 int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
+int next_demotion_node(int node);
 
 #endif /* CONFIG_MIGRATION */
 
diff -puN mm/vmscan.c~demote-with-migrate_pages mm/vmscan.c
--- a/mm/vmscan.c~demote-with-migrate_pages	2020-08-18 11:36:52.919583179 -0700
+++ b/mm/vmscan.c	2020-08-18 11:36:52.924583179 -0700
@@ -43,6 +43,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/memcontrol.h>
+#include <linux/migrate.h>
 #include <linux/delayacct.h>
 #include <linux/sysctl.h>
 #include <linux/oom.h>
@@ -1040,6 +1041,24 @@ static enum page_references page_check_r
 	return PAGEREF_RECLAIM;
 }
 
+bool migrate_demote_page_ok(struct page *page, struct scan_control *sc)
+{
+	int next_nid = next_demotion_node(page_to_nid(page));
+
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(PageHuge(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	if (next_nid == NUMA_NO_NODE)
+		return false;
+	if (PageTransHuge(page) && !thp_migration_supported())
+		return false;
+
+	// FIXME: actually enable this later in the series
+	return false;
+}
+
+
 /* Check if a page is dirty or under writeback */
 static void page_check_dirty_writeback(struct page *page,
 				       bool *dirty, bool *writeback)
@@ -1070,6 +1089,66 @@ static void page_check_dirty_writeback(s
 		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
 }
 
+static struct page *alloc_demote_page(struct page *page, unsigned long node)
+{
+	/*
+	 * Try to fail quickly if memory on the target node is not
+	 * available.  Leaving out __GFP_IO and __GFP_FS helps with
+	 * this.  If the desintation node is full, we want kswapd to
+	 * run there so that its pages will get reclaimed and future
+	 * migration attempts may succeed.
+	 */
+	gfp_t flags = (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_NORETRY |
+		       __GFP_NOMEMALLOC | __GFP_NOWARN | __GFP_THISNODE |
+		       __GFP_KSWAPD_RECLAIM);
+	/* HugeTLB pages should not be on the LRU */
+	WARN_ON_ONCE(PageHuge(page));
+
+	if (PageTransHuge(page)) {
+		struct page *thp;
+
+		flags |= __GFP_COMP;
+
+		thp = alloc_pages_node(node, flags, HPAGE_PMD_ORDER);
+		if (!thp)
+			return NULL;
+		prep_transhuge_page(thp);
+		return thp;
+	}
+
+	return __alloc_pages_node(node, flags, 0);
+}
+
+/*
+ * Take pages on @demote_list and attempt to demote them to
+ * another node.  Pages which are not demoted are added to
+ * @ret_pages.
+ */
+static unsigned int demote_page_list(struct list_head *ret_list,
+				     struct list_head *demote_pages,
+				     struct pglist_data *pgdat,
+				     struct scan_control *sc)
+{
+	int target_nid = next_demotion_node(pgdat->node_id);
+	unsigned int nr_succeeded = 0;
+	int err;
+
+	if (list_empty(demote_pages))
+		return 0;
+
+	/* Demotion ignores all cpuset and mempolicy settings */
+	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
+			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
+			    &nr_succeeded);
+
+	if (err) {
+		putback_movable_pages(demote_pages);
+		list_splice(ret_list, demote_pages);
+	}
+
+	return nr_succeeded;
+}
+
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
@@ -1082,6 +1161,7 @@ static unsigned int shrink_page_list(str
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
+	LIST_HEAD(demote_pages);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
 
@@ -1237,6 +1317,16 @@ static unsigned int shrink_page_list(str
 		}
 
 		/*
+		 * Before reclaiming the page, try to relocate
+		 * its contents to another node.
+		 */
+		if (migrate_demote_page_ok(page, sc)) {
+			list_add(&page->lru, &demote_pages);
+			unlock_page(page);
+			continue;
+		}
+
+		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
 		 * Lazyfree page could be freed directly
@@ -1484,6 +1574,9 @@ keep:
 		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
 	}
 
+	/* Migrate pages selected for demotion */
+	nr_reclaimed += demote_page_list(&ret_pages, &demote_pages, pgdat, sc);
+
 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
 
 	mem_cgroup_uncharge_list(&free_pages);
_
