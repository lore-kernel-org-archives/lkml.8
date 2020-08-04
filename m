Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0952FC433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086AC206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BinWGlmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgHDJPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:15:20 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:57285 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHDJPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596532517; x=1628068517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9329NkJ5BUGBukxFxLfzY1st0KWTc8HMJ9MvZIrqFng=;
  b=BinWGlmRCad2/QdtPkhPvvcbtEYGwQcustqNWYLaySGCoq3EdsnW8U2d
   Q4jauD7a+Oz0KGCLkUmXNf6jO8hGWKHe2RjYMiCrAU4KJvpwEqWElgEnW
   zAhnPLbbMr0xzIp5tsdXpfICOQhJiXvmNWZMzyy3P+78P2eD6fShmVxVs
   w=;
IronPort-SDR: 9wusgSY9ngetMrAY4x/qH+9fQJNTBtk7sFPBcdZraAovr1/TcfCayuy1iazfrH/sMdNPR1mtpZ
 dSdLZKNWIn7Q==
X-IronPort-AV: E=Sophos;i="5.75,433,1589241600"; 
   d="scan'208";a="65399680"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 04 Aug 2020 09:15:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id B68C7A2A1C;
        Tue,  4 Aug 2020 09:15:11 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 4 Aug 2020 09:15:11 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.248) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 4 Aug 2020 09:14:51 +0000
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
Subject: [PATCH v19 01/15] mm: Introduce Data Access MONitor (DAMON)
Date:   Tue, 4 Aug 2020 11:14:02 +0200
Message-ID: <20200804091416.31039-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804091416.31039-1-sjpark@amazon.com>
References: <20200804091416.31039-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D36UWA004.ant.amazon.com (10.43.160.175) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON is a data access monitoring framework subsystem for the Linux
kernel.  The core mechanisms of DAMON make it

 - accurate (the monitoring output is useful enough for DRAM level
   memory management; It might not appropriate for CPU Cache levels,
   though),
 - light-weight (the monitoring overhead is low enough to be applied
   online), and
 - scalable (the upper-bound of the overhead is in constant range
   regardless of the size of target workloads).

Using this framework, therefore, the kernel's memory management
mechanisms can make advanced decisions.  Experimental memory management
optimization works that incurring high data accesses monitoring overhead
could implemented again.  In user space, meanwhile, users who have some
special workloads can write personalized applications for better
understanding and optimizations of their workloads and systems.

This commit is implementing only the stub for the initialization, basic
data structures, and simple manipulation functions of the structures.
The core mechanisms of DAMON will be implemented by following commits.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Varad Gautam <vrd@amazon.de>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  66 ++++++++++++++++
 mm/Kconfig            |  11 +++
 mm/Makefile           |   1 +
 mm/damon.c            | 176 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 include/linux/damon.h
 create mode 100644 mm/damon.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
new file mode 100644
index 000000000000..a6e839a236f4
--- /dev/null
+++ b/include/linux/damon.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON api
+ *
+ * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#ifndef _DAMON_H_
+#define _DAMON_H_
+
+#include <linux/random.h>
+#include <linux/types.h>
+
+/**
+ * struct damon_addr_range - Represents an address region of [@start, @end).
+ * @start:	Start address of the region (inclusive).
+ * @end:	End address of the region (exclusive).
+ */
+struct damon_addr_range {
+	unsigned long start;
+	unsigned long end;
+};
+
+/**
+ * struct damon_region - Represents a monitoring target region.
+ * @ar:			The address range of the region.
+ * @sampling_addr:	Address of the sample for the next access check.
+ * @nr_accesses:	Access frequency of this region.
+ * @list:		List head for siblings.
+ */
+struct damon_region {
+	struct damon_addr_range ar;
+	unsigned long sampling_addr;
+	unsigned int nr_accesses;
+	struct list_head list;
+};
+
+/**
+ * struct damon_target - Represents a monitoring target.
+ * @id:			Unique identifier for this target.
+ * @regions_list:	Head of the monitoring target regions of this target.
+ * @list:		List head for siblings.
+ *
+ * Each monitoring context could have multiple targets.  For example, a context
+ * for virtual memory address spaces could have multiple target processes.  The
+ * @id of each target should be unique among the targets of the context.  For
+ * example, in the virtual address monitoring context, it could be a pidfd or
+ * an address of an mm_struct.
+ */
+struct damon_target {
+	unsigned long id;
+	struct list_head regions_list;
+	struct list_head list;
+};
+
+/**
+ * struct damon_ctx - Represents a context for each monitoring.
+ * @targets_list:	Head of monitoring targets (&damon_target) list.
+ */
+struct damon_ctx {
+	struct list_head targets_list;	/* 'damon_target' objects */
+};
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index f2104cc0d35c..a99d755d67d3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,15 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config DAMON
+	bool "Data Access Monitor"
+	help
+	  This feature allows to monitor access frequency of each memory
+	  region. The information can be useful for performance-centric DRAM
+	  level memory management.
+
+	  See https://damonitor.github.io/doc/html/latest-damon/index.html for
+	  more information.
+	  If unsure, say N.
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 6e9d46b2efc9..30c5dba52fb2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -121,3 +121,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_DAMON) += damon.o
diff --git a/mm/damon.c b/mm/damon.c
new file mode 100644
index 000000000000..d446ba4bfb0a
--- /dev/null
+++ b/mm/damon.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Access Monitor
+ *
+ * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ *
+ * This file is constructed in below parts.
+ *
+ * - Functions and macros for DAMON data structures
+ * - Functions for the initialization
+ *
+ * The core parts are not implemented yet.
+ */
+
+#define pr_fmt(fmt) "damon: " fmt
+
+#include <linux/damon.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+/*
+ * Functions and macros for DAMON data structures
+ */
+
+#define damon_next_region(r) \
+	(container_of(r->list.next, struct damon_region, list))
+
+#define damon_prev_region(r) \
+	(container_of(r->list.prev, struct damon_region, list))
+
+#define damon_for_each_region(r, t) \
+	list_for_each_entry(r, &t->regions_list, list)
+
+#define damon_for_each_region_safe(r, next, t) \
+	list_for_each_entry_safe(r, next, &t->regions_list, list)
+
+#define damon_for_each_target(t, ctx) \
+	list_for_each_entry(t, &(ctx)->targets_list, list)
+
+#define damon_for_each_target_safe(t, next, ctx) \
+	list_for_each_entry_safe(t, next, &(ctx)->targets_list, list)
+
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32() % (r - l))
+
+/*
+ * Construct a damon_region struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_region *damon_new_region(unsigned long start,
+					     unsigned long end)
+{
+	struct damon_region *region;
+
+	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	region->ar.start = start;
+	region->ar.end = end;
+	region->nr_accesses = 0;
+	INIT_LIST_HEAD(&region->list);
+
+	return region;
+}
+
+/*
+ * Add a region between two other regions
+ */
+static inline void damon_insert_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next)
+{
+	__list_add(&r->list, &prev->list, &next->list);
+}
+
+static void damon_add_region(struct damon_region *r, struct damon_target *t)
+{
+	list_add_tail(&r->list, &t->regions_list);
+}
+
+static void damon_del_region(struct damon_region *r)
+{
+	list_del(&r->list);
+}
+
+static void damon_free_region(struct damon_region *r)
+{
+	kfree(r);
+}
+
+static void damon_destroy_region(struct damon_region *r)
+{
+	damon_del_region(r);
+	damon_free_region(r);
+}
+
+/*
+ * Construct a damon_target struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_target *damon_new_target(unsigned long id)
+{
+	struct damon_target *t;
+
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+
+	t->id = id;
+	INIT_LIST_HEAD(&t->regions_list);
+
+	return t;
+}
+
+static void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
+{
+	list_add_tail(&t->list, &ctx->targets_list);
+}
+
+static void damon_del_target(struct damon_target *t)
+{
+	list_del(&t->list);
+}
+
+static void damon_free_target(struct damon_target *t)
+{
+	struct damon_region *r, *next;
+
+	damon_for_each_region_safe(r, next, t)
+		damon_free_region(r);
+	kfree(t);
+}
+
+static void damon_destroy_target(struct damon_target *t)
+{
+	damon_del_target(t);
+	damon_free_target(t);
+}
+
+static unsigned int nr_damon_targets(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	unsigned int nr_targets = 0;
+
+	damon_for_each_target(t, ctx)
+		nr_targets++;
+
+	return nr_targets;
+}
+
+static unsigned int nr_damon_regions(struct damon_target *t)
+{
+	struct damon_region *r;
+	unsigned int nr_regions = 0;
+
+	damon_for_each_region(r, t)
+		nr_regions++;
+
+	return nr_regions;
+}
+
+/*
+ * Functions for the initialization
+ */
+
+static int __init damon_init(void)
+{
+	return 0;
+}
+
+module_init(damon_init);
-- 
2.17.1

