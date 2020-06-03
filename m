Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7417F2081A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SqJqL3dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgFCOP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:15:27 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:50191 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgFCOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591193724; x=1622729724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=faje2xiXtBmZmE30JnFGMsjEdqz81v/UC5sZtQepIaM=;
  b=SqJqL3dS7qZ+2FbKKBIhg9/xmo6Ior8qaStnOHAuxu5mgzv2Itus3yLX
   EiukerZMuNFU6pS/4m4Kv+zWnQDHcU7MEOGpKhAnF+flQbwDFp+x8smEx
   mEuAWAcm5VlQ8JipOjHBCRVY3aQfTl7Sz+qq+mAEjDs5F+TpjYWxPpNmy
   E=;
IronPort-SDR: 6ctg4vvr34L9vkWItNnSgSIDRGwYm4wKTCYNXC5cMzWDUXISMusWumRj3NY3IxwqNwOseav9XI
 x/T10QSfLJuA==
X-IronPort-AV: E=Sophos;i="5.73,467,1583193600"; 
   d="scan'208";a="34144210"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Jun 2020 14:15:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id A775BA2685;
        Wed,  3 Jun 2020 14:14:58 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:14:57 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 3 Jun 2020 14:14:41 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v2 7/9] mm/damon: Implement callbacks for physical memory monitoring
Date:   Wed, 3 Jun 2020 16:11:33 +0200
Message-ID: <20200603141135.10575-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603141135.10575-1-sjpark@amazon.com>
References: <20200603141135.10575-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D45UWB002.ant.amazon.com (10.43.161.78) To
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
virtual memory support.  Also, it supports only page frames that
supported by idle page tracking.  Acutally, most of the code is stollen
from idle page tracking.  Users who want to use other access check
primitives and monitor the frames that not supported with this
implementation could implement their own callbacks on their own.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |   5 ++
 mm/damon.c            | 184 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1a788bfd1b4e..f96503a532ea 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -216,6 +216,11 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx);
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
index f5cbc97a3bbc..6a5c6d540580 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -19,7 +19,9 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/page_idle.h>
+#include <linux/pagemap.h>
 #include <linux/random.h>
+#include <linux/rmap.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
@@ -480,6 +482,11 @@ void kdamond_init_vm_regions(struct damon_ctx *ctx)
 	}
 }
 
+/* Do nothing.  Users should set the initial regions by themselves */
+void kdamond_init_phys_regions(struct damon_ctx *ctx)
+{
+}
+
 static void damon_mkold(struct mm_struct *mm, unsigned long addr)
 {
 	pte_t *pte = NULL;
@@ -611,6 +618,178 @@ unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+/* access check functions for physical address based regions */
+
+/* This code is stollen from page_idle.c */
+static struct page *damon_phys_get_page(unsigned long pfn)
+{
+	struct page *page;
+	pg_data_t *pgdat;
+
+	if (!pfn_valid(pfn))
+		return NULL;
+
+	page = pfn_to_page(pfn);
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
  * damon_check_reset_time_interval() - Check if a time interval is elapsed.
  * @baseline:	the time to check whether the interval has elapsed since
@@ -1058,6 +1237,11 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx)
 	}
 }
 
+/* Do nothing.  If necessary, users should update regions in other callbacks */
+void kdamond_update_phys_regions(struct damon_ctx *ctx)
+{
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
-- 
2.17.1

