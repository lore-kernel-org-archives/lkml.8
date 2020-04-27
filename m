Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4FC5519C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA9520656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k2E/T2OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgD0MGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:06:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62866 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0MGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587989195; x=1619525195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GfwmAepOlGw0jc65vePXQyjyaX4cDEsLZQAUUm5+13E=;
  b=k2E/T2OFecuUWFIpBBE0igggGE5+y6yakO5/3BbUEBRn7otWnBXuZcbt
   E5etAMOCSopFuoPRg6HhuAgYuQib9rvExwYcBivWzb3CUBcz6peBKlRE9
   /eo3ANMtp9x654Rp2IYCQ0MOVVwwoF1l7vS7StZCNKDOze9NNyV2iGiDS
   E=;
IronPort-SDR: lPqTvtBgm7EP8DgohvwD3dabbwh7TOx3hrgc/Ue/vZc3+LL+x98bMgI1app1L65IDxYnoVQlZK
 Jnw13vCq2cKA==
X-IronPort-AV: E=Sophos;i="5.73,324,1583193600"; 
   d="scan'208";a="39683728"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Apr 2020 12:06:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 7327CA1BF4;
        Mon, 27 Apr 2020 12:06:31 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Apr 2020 12:06:30 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 27 Apr 2020 12:06:15 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 03/15] mm: Introduce Data Access MONitor (DAMON)
Date:   Mon, 27 Apr 2020 14:04:30 +0200
Message-ID: <20200427120442.24179-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427120442.24179-1-sjpark@amazon.com>
References: <20200427120442.24179-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D34UWC004.ant.amazon.com (10.43.162.155) To
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

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  36 +++++++++
 mm/Kconfig            |  12 +++
 mm/Makefile           |   1 +
 mm/damon.c            | 173 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 include/linux/damon.h
 create mode 100644 mm/damon.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
new file mode 100644
index 000000000000..19f411d36c0d
--- /dev/null
+++ b/include/linux/damon.h
@@ -0,0 +1,36 @@
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
+/* Represents a monitoring target region of [vm_start, vm_end) */
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
+	int pid;
+	struct list_head regions_list;
+	struct list_head list;
+};
+
+struct damon_ctx {
+	struct list_head tasks_list;	/* 'damon_task' objects */
+};
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..9ea49633a6df 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,4 +739,16 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config DAMON
+	tristate "Data Access Monitor"
+	depends on MMU
+	help
+	  Provides data access monitoring.
+
+	  DAMON is a kernel module that allows users to monitor the actual
+	  memory access pattern of specific user-space processes.  It aims to
+	  be 1) accurate enough to be useful for performance-centric domains,
+	  and 2) sufficiently light-weight so that it can be applied online.
+	  If unsure, say N.
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 272e66039e70..5346314edee6 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -110,3 +110,4 @@ obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
+obj-$(CONFIG_DAMON) += damon.o
diff --git a/mm/damon.c b/mm/damon.c
new file mode 100644
index 000000000000..e319c1e19f3d
--- /dev/null
+++ b/mm/damon.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Access Monitor
+ *
+ * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#define pr_fmt(fmt) "damon: " fmt
+
+#include <linux/damon.h>
+#include <linux/mm.h>
+#include <linux/module.h>
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
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32() % (r - l))
+
+/*
+ * Construct a damon_region struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_region *damon_new_region(struct damon_ctx *ctx,
+				unsigned long vm_start, unsigned long vm_end)
+{
+	struct damon_region *region;
+
+	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	region->vm_start = vm_start;
+	region->vm_end = vm_end;
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
+	damon_for_each_task(ctx, t)
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

