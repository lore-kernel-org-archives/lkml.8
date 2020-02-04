Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9517C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749EA217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOJIgNYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgBDGYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:24:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37069 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDGYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:24:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so2175750pgl.4;
        Mon, 03 Feb 2020 22:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uB5N8nsdXa4Tox3HRli2GCAfUyeh9I2+HCg10c/J3JA=;
        b=aOJIgNYggdsKSZuQU9G9X9TeOhKU8wMCbQyWz1UB+x8DHf3peD1LNNUufzQVbCPEpW
         kMfzPVLitJeamohr+WoA6+BaFpkgSGeYg40m/i7tIJYTMzXWglLQr4Uv8x2+goTUAb4e
         RoqLz98FZ3XB2Uj2O+JMCotBJy2DOAO4nuO42ZwQO3k3HnaL8JUEtNmAI2DBVpQcBRvO
         kE8+Gjo+Q7X3sdDgg1BHDrZwnVkJjFHRqmApoFrHynUFkdN4qvDbVPal7eCFPwqRzrHA
         5oULhUJ+gm1zyqA8gqWvEJVegs4XwJlgPvu6IVz8x0HT2Lz/z81Ce6+/nIns9g7Ge0PO
         yWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uB5N8nsdXa4Tox3HRli2GCAfUyeh9I2+HCg10c/J3JA=;
        b=FtHyQ3KK3xR9qJkCaIgRh6nY0WS+pEIc4uDuu4jHgCO1MKp6qv8qe8KmgHVK7Bjg+J
         f8Go2z2hAiqxDPmuujrv8dD14HAAPFbDaF/uuISu5pW0pyg8WSRd2HZN633Ac36AL/4X
         turJDPG4AnxbgSOAtd64IUxfPwpyUDfay+KRnCmMi3BnjGMJRYXUmYxNOOyAdL8BuAW9
         l5kPpiQTMqbnmsFono4cPjdumOIY3Qy76b7ip1o/K2DopFwuA/XO2+hiLq1IjqHuV/fw
         6GiEaVh1U/5dQZE2aZPiMIEQOJ1DlCdK3cZXD+dD4XdQNdVC/Z74YANBIWdrYG7Dqh3Y
         s8Yw==
X-Gm-Message-State: APjAAAX7x52Yfym2ZxjCwSjJScVENeaysIsbVOH3b2ttO9/5rOMm2jZb
        jaVMlEu9rb4JcaUQ/zkXp6Q=
X-Google-Smtp-Source: APXvYqx/SA77ULLZG9rifyIWDqwfwy028u9c//x36gft3rIFpfHq5YC4nwXX+JkQMp6tftg3phhFIg==
X-Received: by 2002:a63:f142:: with SMTP id o2mr28892039pgk.181.1580797448722;
        Mon, 03 Feb 2020 22:24:08 -0800 (PST)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id u26sm21880240pfn.46.2020.02.03.22.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:24:08 -0800 (PST)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        brendan.d.gregg@gmail.com, brendanhiggins@google.com, cai@lca.pw,
        colin.king@canonical.com, corbet@lwn.net, dwmw@amazon.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        rostedt@goodmis.org, sj38.park@gmail.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/11] mm/damon: Implement kernel space API
Date:   Tue,  4 Feb 2020 06:23:06 +0000
Message-Id: <20200204062312.19913-6-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204062312.19913-1-sj38.park@gmail.com>
References: <20200204062312.19913-1-sj38.park@gmail.com>
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
index 8fb1e090733c..1c9299543678 100644
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

