Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AACC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2080320836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SaMgWskE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgBXMeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:34:15 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:59021 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXMeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582547654; x=1614083654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1Ha8ON0h4SjWTd4XBuay1zXzKA+SvZ2mNjaTZnYuBUM=;
  b=SaMgWskEdNoIUGZbCFhRSUG5f/rZPxYVbtfBkXr2z57Sie1hjWgZndKq
   LXjQIqE3HFg5EuXJSUjvsR9QRDYxEvIVHGX3cjchmjEETk7ij8mK0dRsz
   a2bTfOJ2JFYeUtiMBkiJWkKkIISiDFHB/dxu8m2n1QyaCxAXQh3vDu/YC
   E=;
IronPort-SDR: nrOAWOManoQ8jOznJmPzpRuBR9uNqkfoXZLrxSYxFglxxBgskGzedTW679+aBTyix76cV7G6wA
 nijnuWeq7mQg==
X-IronPort-AV: E=Sophos;i="5.70,480,1574121600"; 
   d="scan'208";a="28454528"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Feb 2020 12:34:12 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 2BB26A1FE6;
        Mon, 24 Feb 2020 12:34:02 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 24 Feb 2020 12:34:02 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 24 Feb 2020 12:33:50 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 07/14] mm/damon: Implement kernel space API
Date:   Mon, 24 Feb 2020 13:30:40 +0100
Message-ID: <20200224123047.32506-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224123047.32506-1-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D19UWC003.ant.amazon.com (10.43.162.184) To
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
index a7edb2dfa700..b3e9b9da5720 100644
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
@@ -1046,7 +1003,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
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

