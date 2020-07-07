Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3102C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9245520738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WnNhOzbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGGOtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:49:08 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28715 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgGGOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594133347; x=1625669347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JMiTVaNmXteBdU6SL2NEwB/jHbdNhndD2eIK8V9xoHc=;
  b=WnNhOzbPheaKNukmo35bkBQ0KpuNMOQ3s67d43p2rqxiNCCmU/RAoOq9
   LX9F91SuimDBnsdRt+LprVDDg53DIzuLT6JAcg2rlomY1Lm6kJ7G0CdWh
   NQveLyRC47y+i5r/dtXkhWXJp6DD6QCkf8WHlkFVp971RV5ZXs20ymd9l
   E=;
IronPort-SDR: YnsAk6oLKYVkvlo5at8w/+zkNfHz1QnuReubTNG+IwSpEQAlwIp66HmBVT/RhWKumI2xQ9smVp
 YEkg4RfypduQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589241600"; 
   d="scan'208";a="49756632"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jul 2020 14:49:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 3C81FA2128;
        Tue,  7 Jul 2020 14:49:04 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:49:03 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:48:42 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v5 07/11] mm/damon: Implement callbacks for physical memory monitoring
Date:   Tue, 7 Jul 2020 16:45:36 +0200
Message-ID: <20200707144540.21216-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707144540.21216-1-sjpark@amazon.com>
References: <20200707144540.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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
 include/linux/damon.h |   5 ++
 mm/damon.c            | 201 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f176a2b6e67c..eb7a5595b616 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -227,6 +227,11 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx);
 void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
 unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
 
+void kdamond_init_phys_regions(struct damon_ctx *ctx);
+void kdamond_update_phys_regions(struct damon_ctx *ctx);
+void kdamond_prepare_phys_access_checks(struct damon_ctx *ctx);
+unsigned int kdamond_check_phys_accesses(struct damon_ctx *ctx);
+
 int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long regions_update_int,
diff --git a/mm/damon.c b/mm/damon.c
index 3aecdef4c841..fb533b2ee4bf 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -27,10 +27,13 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/memory_hotplug.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/page_idle.h>
+#include <linux/pagemap.h>
 #include <linux/random.h>
+#include <linux/rmap.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
@@ -535,6 +538,18 @@ void kdamond_init_vm_regions(struct damon_ctx *ctx)
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
@@ -618,6 +633,19 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx)
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
@@ -753,6 +781,179 @@ unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
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
+	struct damon_task *t;
+	struct damon_region *r;
+
+	damon_for_each_task(t, ctx) {
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
+	struct damon_task *t;
+	struct damon_region *r;
+	unsigned int max_nr_accesses = 0;
+
+	damon_for_each_task(t, ctx) {
+		damon_for_each_region(r, t) {
+			damon_check_phys_access(ctx, r);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
 /*
  * Functions for DAMON core logics and features
  */
-- 
2.17.1

