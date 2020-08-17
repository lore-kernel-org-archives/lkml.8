Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9982C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAB22078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vfLaOcuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHQKxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:53:53 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24176 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHQKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597661591; x=1629197591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TNF6XKUrmUMCS4tn1gAUd0+yYzG+eTDASEOR2XFrOvI=;
  b=vfLaOcuVBdqM7/pVQ9JWZg0QB0Aw+0I3RUSL8Sw/5Zl0yJSfvAhBVS77
   eyOX7XWj/c6NoegbX2GeEkAsJWn+u9+TfwG4x5r9ZFYx+5GtPKLbQh9jI
   oa2OlfFnNGwgfDzRWt7kZQwfiNMtAu3pYO7fy5PQAVEMldKLEwadeLg6Z
   A=;
X-IronPort-AV: E=Sophos;i="5.76,322,1592870400"; 
   d="scan'208";a="48181911"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 17 Aug 2020 10:53:10 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id CDCA8A213C;
        Mon, 17 Aug 2020 10:52:58 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:52:57 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.192) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:52:40 +0000
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
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 02/15] mm/damon: Implement region based sampling
Date:   Mon, 17 Aug 2020 12:51:24 +0200
Message-ID: <20200817105137.19296-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817105137.19296-1-sjpark@amazon.com>
References: <20200817105137.19296-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D02UWC004.ant.amazon.com (10.43.162.236) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON separates its monitoring target address space independent high
level logics from the target space dependent low level primitives for
flexible support of various address spaces.

This commit implements DAMON's target address space independent high
level logics for basic access check and region based sampling.  Hence,
without the target address space specific parts implementations, this
doesn't work alone.  A reference implementation of those will be
provided by a later commit.

Basic Access Check
==================

The output of DAMON says what pages are how frequently accessed for a
given duration.  The resolution of the access frequency is controlled by
setting ``sampling interval`` and ``aggregation interval``.  In detail,
DAMON checks access to each page per ``sampling interval`` and
aggregates the results.  In other words, counts the number of the
accesses to each page.  After each ``aggregation interval`` passes,
DAMON calls callback functions that previously registered by users so
that users can read the aggregated results and then clears the results.
This can be described in below simple pseudo-code::

    while monitoring_on:
        for page in monitoring_target:
            if accessed(page):
                nr_accesses[page] += 1
        if time() % aggregation_interval == 0:
            for callback in user_registered_callbacks:
                callback(monitoring_target, nr_accesses)
            for page in monitoring_target:
                nr_accesses[page] = 0
        sleep(sampling interval)

The monitoring overhead of this mechanism will arbitrarily increase as
the size of the target workload grows.

Region Based Sampling
=====================

To avoid the unbounded increase of the overhead, DAMON groups adjacent
pages that assumed to have the same access frequencies into a region.
As long as the assumption (pages in a region have the same access
frequencies) is kept, only one page in the region is required to be
checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
page in each region, waits for one ``sampling interval``, checks whether
the page is accessed meanwhile, and increases the access frequency of
the region if so.  Therefore, the monitoring overhead is controllable by
setting the number of regions.  DAMON allows users to set the minimum
and the maximum number of regions for the trade-off.

This scheme, however, cannot preserve the quality of the output if the
assumption is not guaranteed.  Next commit will address this problem.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/linux/damon.h |  93 +++++++++++-
 mm/damon.c            | 323 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 413 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a6e839a236f4..e0c8ea8f4091 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -11,6 +11,8 @@
 #define _DAMON_H_
 
 #include <linux/random.h>
+#include <linux/mutex.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 /**
@@ -56,11 +58,100 @@ struct damon_target {
 };
 
 /**
- * struct damon_ctx - Represents a context for each monitoring.
+ * struct damon_ctx - Represents a context for each monitoring.  This is the
+ * main interface that allows users to set the attributes and get the results
+ * of the monitoring.
+ *
+ * @sample_interval:		The time between access samplings.
+ * @aggr_interval:		The time between monitor results aggregations.
+ * @nr_regions:			The number of monitoring regions.
+ *
+ * For each @sample_interval, DAMON checks whether each region is accessed or
+ * not.  It aggregates and keeps the access information (number of accesses to
+ * each region) for @aggr_interval time.  All time intervals are in
+ * micro-seconds.
+ *
+ * @kdamond:		Kernel thread who does the monitoring.
+ * @kdamond_stop:	Notifies whether kdamond should stop.
+ * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
+ *
+ * For each monitoring context, one kernel thread for the monitoring is
+ * created.  The pointer to the thread is stored in @kdamond.
+ *
+ * Once started, the monitoring thread runs until explicitly required to be
+ * terminated or every monitoring target is invalid.  The validity of the
+ * targets is checked via the @target_valid callback.  The termination can also
+ * be explicitly requested by writing non-zero to @kdamond_stop.  The thread
+ * sets @kdamond to NULL when it terminates.  Therefore, users can know whether
+ * the monitoring is ongoing or terminated by reading @kdamond.  Reads and
+ * writes to @kdamond and @kdamond_stop from outside of the monitoring thread
+ * must be protected by @kdamond_lock.
+ *
+ * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
+ * @kdamond_lock.  Accesses to other fields must be protected by themselves.
+ *
  * @targets_list:	Head of monitoring targets (&damon_target) list.
+ *
+ * @init_target_regions:	Constructs initial monitoring target regions.
+ * @prepare_access_checks:	Prepares next access check of target regions.
+ * @check_accesses:		Checks the access of target regions.
+ * @target_valid:		Determine if the target is valid.
+ * @cleanup:			Cleans up the context.
+ * @sample_cb:			Called for each sampling interval.
+ * @aggregate_cb:		Called for each aggregation interval.
+ *
+ * DAMON can be extended for various address spaces by users.  For this, users
+ * can register the target address space dependent low level functions for
+ * their usecases via the callback pointers of the context.  The monitoring
+ * thread calls @init_target_regions before starting the monitoring, and
+ * @prepare_access_checks, @check_accesses, and @target_valid for each
+ * @sample_interval.
+ *
+ * @init_target_regions should construct proper monitoring target regions and
+ * link those to the DAMON context struct.
+ * @prepare_access_checks should manipulate the monitoring regions to be
+ * prepare for the next access check.
+ * @check_accesses should check the accesses to each region that made after the
+ * last preparation and update the `->nr_accesses` of each region.
+ * @target_valid should check whether the target is still valid for the
+ * monitoring.
+ * @cleanup is called from @kdamond just before its termination.  After this
+ * call, only @kdamond_lock and @kdamond will be touched.
+ *
+ * @sample_cb and @aggregate_cb are called from @kdamond for each of the
+ * sampling intervals and aggregation intervals, respectively.  Therefore,
+ * users can safely access to the monitoring results via @targets_list without
+ * additional protection of @kdamond_lock.  For the reason, users are
+ * recommended to use these callback for the accesses to the results.
  */
 struct damon_ctx {
+	unsigned long sample_interval;
+	unsigned long aggr_interval;
+	unsigned long nr_regions;
+
+	struct timespec64 last_aggregation;
+
+	struct task_struct *kdamond;
+	bool kdamond_stop;
+	struct mutex kdamond_lock;
+
 	struct list_head targets_list;	/* 'damon_target' objects */
+
+	/* callbacks */
+	void (*init_target_regions)(struct damon_ctx *context);
+	void (*prepare_access_checks)(struct damon_ctx *context);
+	unsigned int (*check_accesses)(struct damon_ctx *context);
+	bool (*target_valid)(struct damon_target *target);
+	void (*cleanup)(struct damon_ctx *context);
+	void (*sample_cb)(struct damon_ctx *context);
+	void (*aggregate_cb)(struct damon_ctx *context);
 };
 
+int damon_set_targets(struct damon_ctx *ctx,
+		unsigned long *ids, ssize_t nr_ids);
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long min_nr_reg);
+int damon_start(struct damon_ctx *ctxs, int nr_ctxs);
+int damon_stop(struct damon_ctx *ctxs, int nr_ctxs);
+
 #endif
diff --git a/mm/damon.c b/mm/damon.c
index d446ba4bfb0a..408f3a66a8d9 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,18 +9,27 @@
  * This file is constructed in below parts.
  *
  * - Functions and macros for DAMON data structures
+ * - Functions for DAMON core logics and features
+ * - Functions for the DAMON programming interface
  * - Functions for the initialization
- *
- * The core parts are not implemented yet.
  */
 
 #define pr_fmt(fmt) "damon: " fmt
 
 #include <linux/damon.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/page_idle.h>
+#include <linux/random.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 
+/* Minimal region size.  Every damon_region is aligned by this. */
+#define MIN_REGION PAGE_SIZE
+
 /*
  * Functions and macros for DAMON data structures
  */
@@ -46,6 +55,9 @@
 /* Get a random number in [l, r) */
 #define damon_rand(l, r) (l + prandom_u32() % (r - l))
 
+static DEFINE_MUTEX(damon_lock);
+static int nr_running_ctxs;
+
 /*
  * Construct a damon_region struct
  *
@@ -164,6 +176,313 @@ static unsigned int nr_damon_regions(struct damon_target *t)
 	return nr_regions;
 }
 
+/*
+ * Functions for DAMON core logics and features
+ */
+
+/*
+ * damon_check_reset_time_interval() - Check if a time interval is elapsed.
+ * @baseline:	the time to check whether the interval has elapsed since
+ * @interval:	the time interval (microseconds)
+ *
+ * See whether the given time interval has passed since the given baseline
+ * time.  If so, it also updates the baseline to current time for next check.
+ *
+ * Return:	true if the time interval has passed, or false otherwise.
+ */
+static bool damon_check_reset_time_interval(struct timespec64 *baseline,
+		unsigned long interval)
+{
+	struct timespec64 now;
+
+	ktime_get_coarse_ts64(&now);
+	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
+			interval * 1000)
+		return false;
+	*baseline = now;
+	return true;
+}
+
+/*
+ * Check whether it is time to flush the aggregated information
+ */
+static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_aggregation,
+			ctx->aggr_interval);
+}
+
+/*
+ * Reset the aggregated monitoring results
+ */
+static void kdamond_reset_aggregated(struct damon_ctx *c)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, c) {
+		damon_for_each_region(r, t)
+			r->nr_accesses = 0;
+	}
+}
+
+/*
+ * Check whether current monitoring should be stopped
+ *
+ * The monitoring is stopped when either the user requested to stop, or all
+ * monitoring targets are invalid.
+ *
+ * Returns true if need to stop current monitoring.
+ */
+static bool kdamond_need_stop(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	bool stop;
+
+	mutex_lock(&ctx->kdamond_lock);
+	stop = ctx->kdamond_stop;
+	mutex_unlock(&ctx->kdamond_lock);
+	if (stop)
+		return true;
+
+	if (!ctx->target_valid)
+		return false;
+
+	damon_for_each_target(t, ctx) {
+		if (ctx->target_valid(t))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * The monitoring daemon that runs as a kernel thread
+ */
+static int kdamond_fn(void *data)
+{
+	struct damon_ctx *ctx = (struct damon_ctx *)data;
+	struct damon_target *t;
+	struct damon_region *r, *next;
+
+	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
+	if (ctx->init_target_regions)
+		ctx->init_target_regions(ctx);
+	while (!kdamond_need_stop(ctx)) {
+		if (ctx->prepare_access_checks)
+			ctx->prepare_access_checks(ctx);
+		if (ctx->sample_cb)
+			ctx->sample_cb(ctx);
+
+		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
+
+		if (ctx->check_accesses)
+			ctx->check_accesses(ctx);
+
+		if (kdamond_aggregate_interval_passed(ctx)) {
+			if (ctx->aggregate_cb)
+				ctx->aggregate_cb(ctx);
+			kdamond_reset_aggregated(ctx);
+		}
+
+	}
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region_safe(r, next, t)
+			damon_destroy_region(r);
+	}
+
+	if (ctx->cleanup)
+		ctx->cleanup(ctx);
+
+	pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
+	mutex_lock(&ctx->kdamond_lock);
+	ctx->kdamond = NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+
+	mutex_lock(&damon_lock);
+	nr_running_ctxs--;
+	mutex_unlock(&damon_lock);
+
+	do_exit(0);
+}
+
+/*
+ * Functions for the DAMON programming interface
+ */
+
+static bool damon_kdamond_running(struct damon_ctx *ctx)
+{
+	bool running;
+
+	mutex_lock(&ctx->kdamond_lock);
+	running = ctx->kdamond != NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return running;
+}
+
+/*
+ * __damon_start() - Starts monitoring with given context.
+ * @ctx:	monitoring context
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int __damon_start(struct damon_ctx *ctx)
+{
+	int err = -EBUSY;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (!ctx->kdamond) {
+		err = 0;
+		ctx->kdamond_stop = false;
+		ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond");
+		if (IS_ERR(ctx->kdamond))
+			err = PTR_ERR(ctx->kdamond);
+		else
+			wake_up_process(ctx->kdamond);
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return err;
+}
+
+/**
+ * damon_start() - Starts the monitorings for a given group of contexts.
+ * @ctxs:	an array of the contexts to start monitoring
+ * @nr_ctxs:	size of @ctxs
+ *
+ * This function starts a group of monitoring threads for a group of monitoring
+ * contexts.  One thread per each context is created and run concurrently.  The
+ * caller should handle synchronization between the threads by itself.  If a
+ * group of threads that created by other 'damon_start()' call is currently
+ * running, this function does nothing but returns -EBUSY.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_start(struct damon_ctx *ctxs, int nr_ctxs)
+{
+	int i;
+	int err = 0;
+
+	mutex_lock(&damon_lock);
+	if (nr_running_ctxs) {
+		mutex_unlock(&damon_lock);
+		return -EBUSY;
+	}
+
+	for (i = 0; i < nr_ctxs; i++) {
+		err = __damon_start(&ctxs[i]);
+		if (err)
+			break;
+		nr_running_ctxs++;
+	}
+	mutex_unlock(&damon_lock);
+
+	return err;
+}
+
+/*
+ * __damon_stop() - Stops monitoring of given context.
+ * @ctx:	monitoring context
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int __damon_stop(struct damon_ctx *ctx)
+{
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond) {
+		ctx->kdamond_stop = true;
+		mutex_unlock(&ctx->kdamond_lock);
+		while (damon_kdamond_running(ctx))
+			usleep_range(ctx->sample_interval,
+					ctx->sample_interval * 2);
+		return 0;
+	}
+	mutex_unlock(&ctx->kdamond_lock);
+
+	return -EPERM;
+}
+
+/**
+ * damon_stop() - Stops the monitorings for a given group of contexts.
+ * @ctxs:	an array of the contexts to stop monitoring
+ * @nr_ctxs:	size of @ctxs
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_stop(struct damon_ctx *ctxs, int nr_ctxs)
+{
+	int i, err = 0;
+
+	for (i = 0; i < nr_ctxs; i++) {
+		/* nr_running_ctxs is decremented in kdamond_fn */
+		err = __damon_stop(&ctxs[i]);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+/**
+ * damon_set_targets() - Set monitoring targets.
+ * @ctx:	monitoring context
+ * @ids:	array of target ids
+ * @nr_ids:	number of entries in @ids
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_targets(struct damon_ctx *ctx,
+		      unsigned long *ids, ssize_t nr_ids)
+{
+	ssize_t i;
+	struct damon_target *t, *next;
+
+	damon_for_each_target_safe(t, next, ctx)
+		damon_destroy_target(t);
+
+	for (i = 0; i < nr_ids; i++) {
+		t = damon_new_target(ids[i]);
+		if (!t) {
+			pr_err("Failed to alloc damon_target\n");
+			return -ENOMEM;
+		}
+		damon_add_target(ctx, t);
+	}
+
+	return 0;
+}
+
+/**
+ * damon_set_attrs() - Set attributes for the monitoring.
+ * @ctx:		monitoring context
+ * @sample_int:		time interval between samplings
+ * @aggr_int:		time interval between aggregations
+ * @nr_reg:		number of regions
+ *
+ * This function should not be called while the kdamond is running.
+ * Every time interval is in micro-seconds.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
+		unsigned long aggr_int, unsigned long nr_reg)
+{
+	if (nr_reg < 3) {
+		pr_err("nr_regions (%lu) must be at least 3\n",
+				nr_reg);
+		return -EINVAL;
+	}
+
+	ctx->sample_interval = sample_int;
+	ctx->aggr_interval = aggr_int;
+	ctx->nr_regions = nr_reg;
+
+	return 0;
+}
+
 /*
  * Functions for the initialization
  */
-- 
2.17.1

