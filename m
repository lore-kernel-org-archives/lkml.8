Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D39C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B0F20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZKJnny6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgGFLyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:54:44 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:21617 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGFLyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594036481; x=1625572481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=CWh4UZEl0XKGX2+wZ7QZ5VJNrt4mP37p5aSNnt3FJaM=;
  b=ZKJnny6f85uzslPkkXeAEDTujS+wjUAf/oJoAn0WqaGF1iOamVB5pckQ
   VmzW7W07RGM2xTZ5MN6PFBOXQZegHEwLAHj1Yus/s7pEgXoLoslfGMbED
   fnFRmvXgbJ21DTVKEY/rWviZ/FB4/KFhFpaJl+U2GvoBc8pUPcMiAuwz9
   g=;
IronPort-SDR: dbzEHlQ9ED11xCBNxcCMQv6aHZqCeJsOLocmOUbJIv/5yCloCMJQ/CZGmUFgmeueb9DUuVBwC/
 4z9bZYPOqiXg==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="40363457"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 06 Jul 2020 11:54:37 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id DF3F5A2BAF;
        Mon,  6 Jul 2020 11:54:33 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:54:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 11:54:17 +0000
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
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v17 02/15] mm: Introduce Data Access MONitor (DAMON)
Date:   Mon, 6 Jul 2020 13:53:09 +0200
Message-ID: <20200706115322.29598-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706115322.29598-1-sjpark@amazon.com>
References: <20200706115322.29598-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D21UWA003.ant.amazon.com (10.43.160.184) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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

This commit is implementing only the stub for the module load/unload,
basic data structures, and simple manipulation functions of the
structures to keep the size of commit small.  The core mechanisms of
DAMON will be implemented one by one by following commits.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Varad Gautam <vrd@amazon.de>
---
 include/linux/damon.h |  63 ++++++++++++++
 mm/Kconfig            |  12 +++
 mm/Makefile           |   1 +
 mm/damon.c            | 188 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
 create mode 100644 include/linux/damon.h
 create mode 100644 mm/damon.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
new file mode 100644
index 000000000000..c8f8c1c41a45
--- /dev/null
+++ b/include/linux/damon.h
@@ -0,0 +1,63 @@
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
+ * struct damon_task - Represents a monitoring target task.
+ * @pid:		Process id of the task.
+ * @regions_list:	Head of the monitoring target regions of this task.
+ * @list:		List head for siblings.
+ *
+ * If the monitoring target address space is task independent (e.g., physical
+ * memory address space monitoring), @pid should be '-1'.
+ */
+struct damon_task {
+	int pid;
+	struct list_head regions_list;
+	struct list_head list;
+};
+
+/**
+ * struct damon_ctx - Represents a context for each monitoring.
+ * @tasks_list:		Head of monitoring target tasks (&damon_task) list.
+ */
+struct damon_ctx {
+	struct list_head tasks_list;	/* 'damon_task' objects */
+};
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..464e9594dcec 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -867,4 +867,16 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config DAMON
+	tristate "Data Access Monitor"
+	depends on MMU
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
index fccd3756b25f..230e545b6e07 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,3 +112,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
+obj-$(CONFIG_DAMON) += damon.o
diff --git a/mm/damon.c b/mm/damon.c
new file mode 100644
index 000000000000..5ab13b1c15cf
--- /dev/null
+++ b/mm/damon.c
@@ -0,0 +1,188 @@
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
+ * - Functions for the module loading/unloading
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
+#define damon_get_task_struct(t) \
+	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
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
+#define damon_for_each_task(t, ctx) \
+	list_for_each_entry(t, &(ctx)->tasks_list, list)
+
+#define damon_for_each_task_safe(t, next, ctx) \
+	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
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
+static void damon_add_region(struct damon_region *r, struct damon_task *t)
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
+ * Construct a damon_task struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_task *damon_new_task(int pid)
+{
+	struct damon_task *t;
+
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+
+	t->pid = pid;
+	INIT_LIST_HEAD(&t->regions_list);
+
+	return t;
+}
+
+static void damon_add_task(struct damon_ctx *ctx, struct damon_task *t)
+{
+	list_add_tail(&t->list, &ctx->tasks_list);
+}
+
+static void damon_del_task(struct damon_task *t)
+{
+	list_del(&t->list);
+}
+
+static void damon_free_task(struct damon_task *t)
+{
+	struct damon_region *r, *next;
+
+	damon_for_each_region_safe(r, next, t)
+		damon_free_region(r);
+	kfree(t);
+}
+
+static void damon_destroy_task(struct damon_task *t)
+{
+	damon_del_task(t);
+	damon_free_task(t);
+}
+
+static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
+{
+	struct damon_task *t;
+	unsigned int nr_tasks = 0;
+
+	damon_for_each_task(t, ctx)
+		nr_tasks++;
+
+	return nr_tasks;
+}
+
+static unsigned int nr_damon_regions(struct damon_task *t)
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
+ * Functions for the module loading/unloading
+ */
+
+static int __init damon_init(void)
+{
+	return 0;
+}
+
+static void __exit damon_exit(void)
+{
+}
+
+module_init(damon_init);
+module_exit(damon_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("SeongJae Park <sjpark@amazon.de>");
+MODULE_DESCRIPTION("DAMON: Data Access MONitor");
-- 
2.17.1

