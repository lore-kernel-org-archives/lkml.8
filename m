Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4739C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D40120842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hp/WkrNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBJOvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:51:21 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:31343 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgBJOvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581346278; x=1612882278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Qf18yyUu15Ezep9+zNF2pIxCs2ZvcIywhT+/UMPFaVI=;
  b=hp/WkrNvBSFGB+FXA9JXFHbDa9tGWRlq8tdRKAv5+7uq0q+dRRH4Ym4z
   reED4/TbGF+1BB3GF9M78WXbqHZ8T8f7MLi/ysA3/ISi7JDplip3Z7QrD
   sW22UIkKkDIKTdcKM2bUpQlGFboEm5qH58/Xkv9l1OwI46sc2+XmzMKq3
   0=;
IronPort-SDR: Jka6INEuflKey14LZatQ1z0Up7Is62fN6zmUd9eSPjtuGQp6epHzC19Hw/alDZwwe4K5zDOywR
 gPHnAWtE12Uw==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="16392631"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Feb 2020 14:51:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 0CE6BA0566;
        Mon, 10 Feb 2020 14:51:10 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 14:51:10 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 14:50:58 +0000
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
Subject: [PATCH v4 05/11] mm/damon: Implement kernel space API
Date:   Mon, 10 Feb 2020 15:50:43 +0100
Message-ID: <20200210145043.27684-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210144812.26845-1-sjpark@amazon.com>
References: <20200210144812.26845-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.109]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements the DAMON api for the kernel.  Other kernel code
can use DAMON by calling damon_start() and damon_stop() with their own
'struct damon_ctx'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 71 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon.c            | 70 +++++++++++-------------------------------
 2 files changed, 89 insertions(+), 52 deletions(-)
 create mode 100644 include/linux/damon.h

diff --git a/include/linux/damon.h b/include/linux/damon.h
new file mode 100644
index 000000000000..78785cb88d42
--- /dev/null
+++ b/include/linux/damon.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON api
+ *
+ * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#ifndef _DAMON_H_
+#define _DAMON_H_
+
+#include <linux/random.h>
+#include <linux/spinlock_types.h>
+#include <linux/time64.h>
+#include <linux/types.h>
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
+	unsigned long sample_interval;
+	unsigned long aggr_interval;
+	unsigned long regions_update_interval;
+	unsigned long min_nr_regions;
+	unsigned long max_nr_regions;
+
+	struct timespec64 last_aggregation;
+	struct timespec64 last_regions_update;
+
+	unsigned char *rbuf;
+	unsigned int rbuf_len;
+	unsigned int rbuf_offset;
+	char *rfile_path;
+
+	struct task_struct *kdamond;
+	bool kdamond_stop;
+	spinlock_t kdamond_lock;
+
+	struct rnd_state rndseed;
+
+	struct list_head tasks_list;	/* 'damon_task' objects */
+
+	/* callbacks */
+	void (*sample_cb)(struct damon_ctx *context);
+	void (*aggregate_cb)(struct damon_ctx *context);
+};
+
+int damon_set_pids(struct damon_ctx *ctx,
+			unsigned long *pids, ssize_t nr_pids);
+int damon_set_recording(struct damon_ctx *ctx,
+			unsigned int rbuf_len, char *rfile_path);
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long s, unsigned long a,
+			unsigned long r, unsigned long min, unsigned long max);
+int damon_start(struct damon_ctx *ctx);
+int damon_stop(struct damon_ctx *ctx);
+
+#endif
diff --git a/mm/damon.c b/mm/damon.c
index c2c40e003580..450b85bef120 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#include <linux/damon.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
@@ -40,55 +41,6 @@
 #define damon_for_each_task_safe(ctx, t, next) \
 	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
 
-/* Represents a monitoring target region on the virtual address space */
-struct damon_region {
-	unsigned long vm_start;
-	unsigned long vm_end;
-	unsigned long sampling_addr;
-	unsigned int nr_accesses;
-	struct list_head list;
-};
-
-/* Represents a monitoring target task */
-struct damon_task {
-	unsigned long pid;
-	struct list_head regions_list;
-	struct list_head list;
-};
-
-/*
- * For each 'sample_interval', DAMON checks whether each region is accessed or
- * not.  It aggregates and keeps the access information (number of accesses to
- * each region) for 'aggr_interval' and then flushes it to the result buffer if
- * an 'aggr_interval' surpassed.  And for each 'regions_update_interval', damon
- * checks whether the memory mapping of the target tasks has changed (e.g., by
- * mmap() calls from the applications) and applies the changes.
- *
- * All time intervals are in micro-seconds.
- */
-struct damon_ctx {
-	unsigned long sample_interval;
-	unsigned long aggr_interval;
-	unsigned long regions_update_interval;
-	unsigned long min_nr_regions;
-	unsigned long max_nr_regions;
-
-	struct timespec64 last_aggregation;
-
-	unsigned char *rbuf;
-	unsigned int rbuf_len;
-	unsigned int rbuf_offset;
-	char *rfile_path;
-
-	struct task_struct *kdamond;
-	bool kdamond_stop;
-	spinlock_t kdamond_lock;
-
-	struct rnd_state rndseed;
-
-	struct list_head tasks_list;	/* 'damon_task' objects */
-};
-
 #define LEN_RES_FILE_PATH	256
 
 /* Get a random number in [l, r) */
@@ -885,11 +837,15 @@ static int kdamond_fn(void *data)
 			}
 			mmput(mm);
 		}
+		if (ctx->sample_cb)
+			ctx->sample_cb(ctx);
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
 			kdamond_flush_aggregated(ctx);
 			kdamond_split_regions(ctx);
+			if (ctx->aggregate_cb)
+				ctx->aggregate_cb(ctx);
 		}
 
 		if (kdamond_need_update_regions(ctx))
@@ -952,6 +908,16 @@ static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
 	return 0;
 }
 
+int damon_start(struct damon_ctx *ctx)
+{
+	return damon_turn_kdamond(ctx, true);
+}
+
+int damon_stop(struct damon_ctx *ctx)
+{
+	return damon_turn_kdamond(ctx, false);
+}
+
 static inline bool damon_is_target_pid(struct damon_ctx *c, unsigned long pid)
 {
 	struct damon_task *t;
@@ -966,7 +932,7 @@ static inline bool damon_is_target_pid(struct damon_ctx *c, unsigned long pid)
 /*
  * This function should not be called while the kdamond is running.
  */
-static int damon_set_pids(struct damon_ctx *ctx,
+int damon_set_pids(struct damon_ctx *ctx,
 			unsigned long *pids, ssize_t nr_pids)
 {
 	ssize_t i;
@@ -1007,7 +973,7 @@ static int damon_set_pids(struct damon_ctx *ctx,
  *
  * Returns 0 on success, negative error code otherwise.
  */
-static int damon_set_recording(struct damon_ctx *ctx,
+int damon_set_recording(struct damon_ctx *ctx,
 				unsigned int rbuf_len, char *path_to_rfile)
 {
 	size_t rfile_path_len;
@@ -1051,7 +1017,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
  *
  * Returns 0 on success, negative error code otherwise.
  */
-static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
-- 
2.17.1

