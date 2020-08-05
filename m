Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78870C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D8922CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DDrann3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgHEHDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:03:07 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2318 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEHDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596610986; x=1628146986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZJzC/L2VnfMh57V0C7rE8mhD7WN1ch3kpwhH4SUAFiA=;
  b=DDrann3aOa0N1QtGqXikeX3PoLYb20gflfW8GrnkFQB9IMyrbNRuznXn
   9Py9E/mLuH9l/ivJ9zAVhjmjPK5t5GyjP8IYiEGb67YYxf1w5g1nUGoYc
   1QS0CgG8SpNojZtGfeGjA9anS4M1rrNFy/oM2uRtgJCQIXALkm+wEV35j
   o=;
IronPort-SDR: qTmov228WIaLRlE89yaRfXi+Mba3d1M9Npmsm/y1z5SzUw5nVo0YQ6kgmhVEsxiaqGJ1M3X6Xf
 W4iqCAWqdEBA==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="65698359"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Aug 2020 07:02:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 9FE73A2411;
        Wed,  5 Aug 2020 07:02:47 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:02:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:02:29 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v6 06/10] mm/damon: Implement callbacks for physical memory monitoring
Date:   Wed, 5 Aug 2020 08:59:47 +0200
Message-ID: <20200805065951.18221-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805065951.18221-1-sjpark@amazon.com>
References: <20200805065951.18221-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements the four callbacks (->init_target_regions,
->update_target_regions, ->prepare_access_check, and ->check_accesses)
for the basic access monitoring of the physical memory address space.
By setting the callback pointers to point those, users can easily
monitor the accesses to the physical memory.

Internally, it uses the PTE Accessed bit, as similar to that of the
virtual memory support.  Also, it supports only user memory pages, as
idle page tracking also does, for the same reason.  If the monitoring
target physical memory address range contains non-user memory pages,
access check of the pages will do nothing but simply treat the pages as
not accessed.

Users who want to use other access check primitives and/or monitor the
non-user memory regions could implement and use their own callbacks.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |   6 ++
 mm/damon.c            | 200 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f02798ac9ec5..bbd748514677 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -237,6 +237,12 @@ void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
 unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
 bool kdamond_vm_target_valid(struct damon_target *t);
 
+/* Reference callback implementations for physical memory */
+void kdamond_init_phys_regions(struct damon_ctx *ctx);
+void kdamond_update_phys_regions(struct damon_ctx *ctx);
+void kdamond_prepare_phys_access_checks(struct damon_ctx *ctx);
+unsigned int kdamond_check_phys_accesses(struct damon_ctx *ctx);
+
 int damon_set_targets(struct damon_ctx *ctx,
 		unsigned long *ids, ssize_t nr_ids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
diff --git a/mm/damon.c b/mm/damon.c
index b2507bae6c57..c8d834ce188d 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -28,11 +28,14 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/memory_hotplug.h>
 #include <linux/mm.h>
 #include <linux/mmu_notifier.h>
 #include <linux/module.h>
 #include <linux/page_idle.h>
+#include <linux/pagemap.h>
 #include <linux/random.h>
+#include <linux/rmap.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
@@ -543,6 +546,18 @@ void kdamond_init_vm_regions(struct damon_ctx *ctx)
 	}
 }
 
+/*
+ * The initial regions construction function for the physical address space.
+ *
+ * This default version does nothing in actual.  Users should set the initial
+ * regions by themselves before passing their damon_ctx to 'start_damon()', or
+ * implement their version of this and set '->init_target_regions' of their
+ * damon_ctx to point it.
+ */
+void kdamond_init_phys_regions(struct damon_ctx *ctx)
+{
+}
+
 /*
  * Functions for the dynamic monitoring target regions update
  */
@@ -626,6 +641,19 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx)
 	}
 }
 
+/*
+ * The dynamic monitoring target regions update function for the physical
+ * address space.
+ *
+ * This default version does nothing in actual.  Users should update the
+ * regions in other callbacks such as '->aggregate_cb', or implement their
+ * version of this and set the '->init_target_regions' of their damon_ctx to
+ * point it.
+ */
+void kdamond_update_phys_regions(struct damon_ctx *ctx)
+{
+}
+
 /*
  * Functions for the access checking of the regions
  */
@@ -801,6 +829,178 @@ unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+/* access check functions for physical address based regions */
+
+/*
+ * Get a page by pfn if it is in the LRU list.  Otherwise, returns NULL.
+ *
+ * The body of this function is stollen from the 'page_idle_get_page()'.  We
+ * steal rather than reuse it because the code is quite simple .
+ */
+static struct page *damon_phys_get_page(unsigned long pfn)
+{
+	struct page *page = pfn_to_online_page(pfn);
+	pg_data_t *pgdat;
+
+	if (!page || !PageLRU(page) ||
+	    !get_page_unless_zero(page))
+		return NULL;
+
+	pgdat = page_pgdat(page);
+	spin_lock_irq(&pgdat->lru_lock);
+	if (unlikely(!PageLRU(page))) {
+		put_page(page);
+		page = NULL;
+	}
+	spin_unlock_irq(&pgdat->lru_lock);
+	return page;
+}
+
+static bool damon_page_mkold(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	damon_mkold(vma->vm_mm, addr);
+	return true;
+}
+
+static void damon_phys_mkold(unsigned long paddr)
+{
+	struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
+	struct rmap_walk_control rwc = {
+		.rmap_one = damon_page_mkold,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return;
+
+	if (!page_mapped(page) || !page_rmapping(page))
+		return;
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page))
+		return;
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+	put_page(page);
+}
+
+static void damon_prepare_phys_access_check(struct damon_ctx *ctx,
+					    struct damon_region *r)
+{
+	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+
+	damon_phys_mkold(r->sampling_addr);
+}
+
+void kdamond_prepare_phys_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t)
+			damon_prepare_phys_access_check(ctx, r);
+	}
+}
+
+struct damon_phys_access_chk_result {
+	unsigned long page_sz;
+	bool accessed;
+};
+
+static bool damon_page_accessed(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	struct damon_phys_access_chk_result *result = arg;
+
+	result->accessed = damon_young(vma->vm_mm, addr, &result->page_sz);
+
+	/* If accessed, stop walking */
+	return !result->accessed;
+}
+
+static bool damon_phys_young(unsigned long paddr, unsigned long *page_sz)
+{
+	struct page *page = damon_phys_get_page(PHYS_PFN(paddr));
+	struct damon_phys_access_chk_result result = {
+		.page_sz = PAGE_SIZE,
+		.accessed = false,
+	};
+	struct rmap_walk_control rwc = {
+		.arg = &result,
+		.rmap_one = damon_page_accessed,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return false;
+
+	if (!page_mapped(page) || !page_rmapping(page))
+		return false;
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page))
+		return false;
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+	put_page(page);
+
+	*page_sz = result.page_sz;
+	return result.accessed;
+}
+
+/*
+ * Check whether the region was accessed after the last preparation
+ *
+ * mm	'mm_struct' for the given virtual address space
+ * r	the region of physical address space that needs to be checked
+ */
+static void damon_check_phys_access(struct damon_ctx *ctx,
+				    struct damon_region *r)
+{
+	static unsigned long last_addr;
+	static unsigned long last_page_sz = PAGE_SIZE;
+	static bool last_accessed;
+
+	/* If the region is in the last checked page, reuse the result */
+	if (ALIGN_DOWN(last_addr, last_page_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
+		if (last_accessed)
+			r->nr_accesses++;
+		return;
+	}
+
+	last_accessed = damon_phys_young(r->sampling_addr, &last_page_sz);
+	if (last_accessed)
+		r->nr_accesses++;
+
+	last_addr = r->sampling_addr;
+}
+
+unsigned int kdamond_check_phys_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned int max_nr_accesses = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			damon_check_phys_access(ctx, r);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
 
 /*
  * Functions for the target validity check
-- 
2.17.1

