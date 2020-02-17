Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5724AC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B6720836
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k8JYurr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgBQK1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:27:47 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:42701 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgBQK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581935261; x=1613471261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aSiGqXkjiJX0FAW62gVOONeBZYwodZ9r71hBLfy8kJg=;
  b=k8JYurr9T9AxMRXah96Bd0S0Ui2erbALqFygFI/eWgFjclRvVHtG+m5J
   rsG96OgucovDf20JA2q+e85UMEKO5koITsryYSApQm0MFgz8hWQQdWfk6
   XSjYWihlh6ve9tDwVyqQtqoAKfAUlBDatHFqzhUQQKjMNji24q9ZfOffX
   0=;
IronPort-SDR: UxgBqSWBu2EY49dqpopLIMnvH8QZ1RZ9RSJe6kkVGD8X6VewHDODRiFhwUzwcdOaUEhVl6l8YV
 /2Clj8TdsDrQ==
X-IronPort-AV: E=Sophos;i="5.70,452,1574121600"; 
   d="scan'208";a="16610883"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 17 Feb 2020 10:27:38 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id B5908A22A9;
        Mon, 17 Feb 2020 10:27:36 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 17 Feb 2020 10:27:36 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Feb 2020 10:27:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 07/14] mm/damon: Implement kernel space API
Date:   Mon, 17 Feb 2020 11:25:37 +0100
Message-ID: <20200217102544.29012-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217102544.29012-1-sjpark@amazon.com>
References: <20200217102544.29012-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D30UWB004.ant.amazon.com (10.43.161.51) To
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
 mm/damon.c            | 71 +++++++++----------------------------------
 2 files changed, 85 insertions(+), 57 deletions(-)
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
index 3d46bf5e353a..45d82128e3ac 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#include <linux/damon.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/mm.h>
@@ -40,60 +41,6 @@
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
- * each region) for each 'aggr_interval' time.  And for each
- * 'regions_update_interval', damon checks whether the memory mapping of the
- * target tasks has changed (e.g., by mmap() calls from the applications) and
- * applies the changes.
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
-	struct timespec64 last_regions_update;
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
-
-	/* callbacks */
-	void (*sample_cb)(struct damon_ctx *context);
-	void (*aggregate_cb)(struct damon_ctx *context);
-};
-
 #define MAX_RFILE_PATH_LEN	256
 
 /* Get a random number in [l, r) */
@@ -961,10 +908,20 @@ static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
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
 /*
  * This function should not be called while the kdamond is running.
  */
-static int damon_set_pids(struct damon_ctx *ctx,
+int damon_set_pids(struct damon_ctx *ctx,
 			unsigned long *pids, ssize_t nr_pids)
 {
 	ssize_t i;
@@ -998,7 +955,7 @@ static int damon_set_pids(struct damon_ctx *ctx,
  *
  * Returns 0 on success, negative error code otherwise.
  */
-static int damon_set_recording(struct damon_ctx *ctx,
+int damon_set_recording(struct damon_ctx *ctx,
 				unsigned int rbuf_len, char *rfile_path)
 {
 	size_t rfile_path_len;
@@ -1044,7 +1001,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
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

