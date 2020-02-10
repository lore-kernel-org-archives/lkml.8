Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B529C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DB8206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HnB/qHq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBJOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:49:03 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:30870 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgBJOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581346140; x=1612882140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=dQabRuh4MATl+1QDbxk7M0KRq1KLdG813aWlQ3UGSeo=;
  b=HnB/qHq0PGPCu7x0/q3N3pisVxFhRYneg3wHGOgvVuCb8AhAlwjD3L5E
   dl8xqVxGwQDuvEniM2aWhyOCn7aoXn/ifb7ti7jEkjOcEAfV+i8pWWGJB
   Ii8EitLmBMQuxZ2WHLbXNHdWXkPuTG9jMDPp/qahqPQIaDZThVX4Lz7aD
   8=;
IronPort-SDR: XbMnP/lbgsnB/KKOYKXOw4hRtMQuc8gKjB+mU5IQbjMmxtLwx0TT5WT+glHM6ix6vL2jKkY0l3
 W3zo59jbgupg==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="16392265"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Feb 2020 14:48:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id EAE42A05C8;
        Mon, 10 Feb 2020 14:48:51 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 14:48:51 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 14:48:40 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 01/11] mm: Introduce Data Access MONitor (DAMON)
Date:   Mon, 10 Feb 2020 15:48:02 +0100
Message-ID: <20200210144812.26845-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210144812.26845-1-sjpark@amazon.com>
References: <20200210144812.26845-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D35UWC004.ant.amazon.com (10.43.162.180) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit introduces a kernel module named DAMON.  Note that this
commit is implementing only the stub for the module load/unload, basic
data structures, and simple manipulation functions of the structures to
keep the size of commit small.  The core mechanisms of DAMON will be
implemented one by one by following commits.

Brief Introduction
==================

Memory management decisions can normally be more efficient if finer data
access information is available.  However, because finer information
usually comes with higher overhead, most systems including Linux made a
tradeoff: Forgive some wise decisions and use coarse information and/or
light-weight heuristics.

A number of experimental data access pattern awared memory management
optimizations say the sacrifices are huge.  However, none of those has
successfully adopted to Linux kernel mainly due to the absence of a
scalable and efficient data access monitoring mechanism.

DAMON is a data access monitoring solution for the problem.  It is 1)
accurate enough for the DRAM level memory management, 2) light-weight
enough to be applied online, and 3) keeps predefined upper-bound
overhead regardless of the size of target workloads (thus scalable).

DAMON is implemented as a standalone kernel module and provides several
simple interfaces.  Owing to that, though it has mainly designed for the
kernel's memory management mechanisms, it can be also used for a wide
range of user space programs and people.

Frequently Asked Questions
==========================

Q: Why not integrated with perf?
A: From the perspective of perf like profilers, DAMON can be thought of
as a data source in kernel, like tracepoints, pressure stall information
(psi), or idle page tracking.  Thus, it can be easily integrated with
those.  However, this patchset doesn't provide a fancy perf integration
because current step of DAMON development is focused on its core logic
only.  That said, DAMON already provides two interfaces for user space
programs, which based on debugfs and tracepoint, respectively.  Using
the tracepoint interface, you can use DAMON with perf.  This patchset
also provides the debugfs interface based user space tool for DAMON.  It
can be used to record, visualize, and analyze data access pattern of
target processes in a convenient way.

Q: Why a new module, instead of extending perf or other tools?
A: First, DAMON aims to be used by other programs including the kernel.
Therefore, having dependency to specific tools like perf is not
desirable.  Second, because it need to be lightweight as much as
possible so that it can be used online, any unnecessary overhead such as
kernel - user space context switching cost should be avoided.  These are
the two most biggest reasons why DAMON is implemented in the kernel
space.  The idle page tracking subsystem would be the kernel module that
most seems similar to DAMON.  However, it's own interface is not
compatible with DAMON.  Also, the internal implementation of it has no
common part to be reused by DAMON.

Q: Can 'perf mem' provide the data required for DAMON?
A: On the systems supporting 'perf mem', yes.  DAMON is using the PTE
Accessed bits in low level.  Other H/W or S/W features that can be used
for the purpose could be used.  However, as explained with above
question, DAMON need to be implemented in the kernel space.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/Kconfig  |  12 +++
 mm/Makefile |   1 +
 mm/damon.c  | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 mm/damon.c

diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..387d469f40ec 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,4 +739,16 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config DAMON
+	tristate "Data Access Monitor"
+	depends on MMU
+	default n
+	help
+	  Provides data access monitoring.
+
+	  DAMON is a kernel module that allows users to monitor the actual
+	  memory access pattern of specific user-space processes.  It aims to
+	  be 1) accurate enough to be useful for performance-centric domains,
+	  and 2) sufficiently light-weight so that it can be applied online.
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 1937cc251883..2911b3832c90 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
+obj-$(CONFIG_DAMON) += damon.o
diff --git a/mm/damon.c b/mm/damon.c
new file mode 100644
index 000000000000..0687d2b83bb6
--- /dev/null
+++ b/mm/damon.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Access Monitor
+ *
+ * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#define pr_fmt(fmt) "damon: " fmt
+
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/random.h>
+#include <linux/slab.h>
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
+#define damon_for_each_task(ctx, t) \
+	list_for_each_entry(t, &(ctx)->tasks_list, list)
+
+#define damon_for_each_task_safe(ctx, t, next) \
+	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
+
+/* Represents a monitoring target region on the virtual address space */
+struct damon_region {
+	unsigned long vm_start;
+	unsigned long vm_end;
+	unsigned long sampling_addr;
+	unsigned int nr_accesses;
+	struct list_head list;
+};
+
+/* Represents a monitoring target task */
+struct damon_task {
+	unsigned long pid;
+	struct list_head regions_list;
+	struct list_head list;
+};
+
+struct damon_ctx {
+	struct rnd_state rndseed;
+
+	struct list_head tasks_list;	/* 'damon_task' objects */
+};
+
+#define LEN_RES_FILE_PATH	256
+
+/* Get a random number in [l, r) */
+#define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
+
+/*
+ * Construct a damon_region struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_region *damon_new_region(struct damon_ctx *ctx,
+				unsigned long vm_start, unsigned long vm_end)
+{
+	struct damon_region *ret;
+
+	ret = kmalloc(sizeof(struct damon_region), GFP_KERNEL);
+	if (!ret)
+		return NULL;
+	ret->vm_start = vm_start;
+	ret->vm_end = vm_end;
+	ret->nr_accesses = 0;
+	ret->sampling_addr = damon_rand(ctx, vm_start, vm_end);
+	INIT_LIST_HEAD(&ret->list);
+
+	return ret;
+}
+
+/*
+ * Add a region between two other regions
+ */
+static inline void damon_add_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next)
+{
+	__list_add(&r->list, &prev->list, &next->list);
+}
+
+/*
+ * Append a region to a task's list of regions
+ */
+static void damon_add_region_tail(struct damon_region *r, struct damon_task *t)
+{
+	list_add_tail(&r->list, &t->regions_list);
+}
+
+/*
+ * Delete a region from its list
+ */
+static void damon_del_region(struct damon_region *r)
+{
+	list_del(&r->list);
+}
+
+/*
+ * De-allocate a region
+ */
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
+static struct damon_task *damon_new_task(unsigned long pid)
+{
+	struct damon_task *t;
+
+	t = kmalloc(sizeof(struct damon_task), GFP_KERNEL);
+	if (!t)
+		return NULL;
+	t->pid = pid;
+	INIT_LIST_HEAD(&t->regions_list);
+
+	return t;
+}
+
+/* Returns n-th damon_region of the given task */
+struct damon_region *damon_nth_region_of(struct damon_task *t, unsigned int n)
+{
+	struct damon_region *r;
+	unsigned int i;
+
+	i = 0;
+	damon_for_each_region(r, t) {
+		if (i++ == n)
+			return r;
+	}
+	return NULL;
+}
+
+static void damon_add_task_tail(struct damon_ctx *ctx, struct damon_task *t)
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
+/*
+ * Returns number of monitoring target tasks
+ */
+static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
+{
+	struct damon_task *t;
+	unsigned int ret = 0;
+
+	damon_for_each_task(ctx, t)
+		ret++;
+	return ret;
+}
+
+/*
+ * Returns the number of target regions for a given target task
+ */
+static unsigned int nr_damon_regions(struct damon_task *t)
+{
+	struct damon_region *r;
+	unsigned int ret = 0;
+
+	damon_for_each_region(r, t)
+		ret++;
+	return ret;
+}
+
+static int __init damon_init(void)
+{
+	pr_info("init\n");
+
+	return 0;
+}
+
+static void __exit damon_exit(void)
+{
+	pr_info("exit\n");
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

