Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7AEC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AE620863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YOljKdI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgBJPKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:10:19 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4451 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBJPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581347418; x=1612883418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kh0znGwFT7WxtGIxYu2YQb4TJEKoBkHgx1UTUCLlwC0=;
  b=YOljKdI69Uwt2ObJ4Za3bxJxg0CLb39rmnmHhcxiJ6m9pm2yTDQI1cQt
   AaLNfEzyiY4a1pec6s51tD9ExwTe/klNFGFp6j7zi3+xPWb0/osHM12px
   7oQHTAgOLLfE8BOsCcuQtjhB3B/mBYIEpQ7wofX33qkgxP4Tt0aF33sk0
   A=;
IronPort-SDR: dIh8lWPXAkGX4OjaX40TbxveiloI+1bkmQK2w25AlmQsQAiA7hXfTznjHGlQe7vcMJ8AKZs53G
 qNpvodOqxp5A==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="17017442"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Feb 2020 15:10:15 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 1544BA1F9D;
        Mon, 10 Feb 2020 15:10:13 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 15:10:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.69) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 15:10:01 +0000
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
Subject: [RFC PATCH 2/3] mm/damon/rules: Implement access pattern based management rules
Date:   Mon, 10 Feb 2020 16:09:20 +0100
Message-ID: <20200210150921.32482-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210150921.32482-1-sjpark@amazon.com>
References: <20200210150921.32482-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.69]
X-ClientProxiedBy: EX13D17UWB002.ant.amazon.com (10.43.161.141) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON can make data access pattern awared memory management
optimizations much easier.  That said, users who want such optimizations
should run DAMON, read the monitoring results, analyze it, plan a new
memory management scheme, and apply the new scheme by themselves.  It
would not be too hard, but still require some level of efforts.  Such
efforts will be really necessary in some complicated cases.

However, in many other cases, the optimizations would have a simple and
common pattern.  For example, the users would just want the system to
apply an actions to a memory region of a specific size having a specific
access frequency for a specific time.  For example, "page out a memory
region larger than 100 MiB but having a low access frequency more than
10 minutes", or "Use THP for a memory region larger than 2 MiB having a
high access frequency for more than 2 seconds".

This commit makes DAMON to receive and handle such simple optimizations
requests.  All the things users need to do for such simple cases is only
to specify their requests to DAMON in a form of rules.

Each of the rules is composed with conditions for filtering of the
target memory regions and desired memory management action for the
target.  In specific, the format is::

    <min/max size> <min/max access frequency> <min/max age> <action>

The filtering conditions are size of memory region, number of accesses
to the region monitored by DAMON, and the age of the region.  The age of
region is incremented periodically but reset when its addresses or
access frequency has significanly changed.  The specifiable memory
management schemes are simple for now.  Current implementation supports
only a few of madvise() hints, ``MADV_WILLNEED``, ``MADV_COLD``,
``MADV_PAGEOUT``, ``MADV_HUGEPAGE``, and ``MADV_NOHUGEPAGE``.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  28 ++++++++
 mm/damon.c            | 160 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 78785cb88d42..bc91e945f646 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -22,6 +22,11 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
+
+	unsigned int age;
+	unsigned long last_vm_start;
+	unsigned long last_vm_end;
+	unsigned int last_nr_accesses;
 };
 
 /* Represents a monitoring target task */
@@ -31,6 +36,26 @@ struct damon_task {
 	struct list_head list;
 };
 
+enum damon_action {
+	DAMON_MADV_WILLNEED,
+	DAMON_MADV_COLD,
+	DAMON_MADV_PAGEOUT,
+	DAMON_MADV_HUGEPAGE,
+	DAMON_MADV_NOHUGEPAGE,
+	DAMON_ACTION_LEN,
+};
+
+struct damon_rule {
+	unsigned int min_sz_region;
+	unsigned int max_sz_region;
+	unsigned int min_nr_accesses;
+	unsigned int max_nr_accesses;
+	unsigned int min_age_region;
+	unsigned int max_age_region;
+	enum damon_action action;
+	struct list_head list;
+};
+
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
@@ -53,6 +78,7 @@ struct damon_ctx {
 	struct rnd_state rndseed;
 
 	struct list_head tasks_list;	/* 'damon_task' objects */
+	struct list_head rules_list;	/* 'damon_rule' objects */
 
 	/* callbacks */
 	void (*sample_cb)(struct damon_ctx *context);
@@ -61,6 +87,8 @@ struct damon_ctx {
 
 int damon_set_pids(struct damon_ctx *ctx,
 			unsigned long *pids, ssize_t nr_pids);
+int damon_set_rules(struct damon_ctx *ctx,
+			struct damon_rule **rules, ssize_t nr_rules);
 int damon_set_recording(struct damon_ctx *ctx,
 			unsigned int rbuf_len, char *rfile_path);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long s, unsigned long a,
diff --git a/mm/damon.c b/mm/damon.c
index bb8eb88edaf3..5d33b5d6504b 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -11,6 +11,7 @@
 
 #define CREATE_TRACE_POINTS
 
+#include <asm-generic/mman-common.h>
 #include <linux/damon.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -24,6 +25,8 @@
 #include <linux/slab.h>
 #include <trace/events/damon.h>
 
+#include "internal.h"
+
 #define damon_get_task_struct(t) \
 	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
 
@@ -45,6 +48,12 @@
 #define damon_for_each_task_safe(ctx, t, next) \
 	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
 
+#define damon_for_each_rule(ctx, r) \
+	list_for_each_entry(r, &(ctx)->rules_list, list)
+
+#define damon_for_each_rule_safe(ctx, r, next) \
+	list_for_each_entry_safe(r, next, &(ctx)->rules_list, list)
+
 /*
  * For each 'sample_interval', DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
@@ -186,6 +195,27 @@ static void damon_destroy_task(struct damon_task *t)
 	damon_free_task(t);
 }
 
+static void damon_add_rule(struct damon_ctx *ctx, struct damon_rule *r)
+{
+	list_add_tail(&r->list, &ctx->rules_list);
+}
+
+static void damon_del_rule(struct damon_rule *r)
+{
+	list_del(&r->list);
+}
+
+static void damon_free_rule(struct damon_rule *r)
+{
+	kfree(r);
+}
+
+static void damon_destroy_rule(struct damon_rule *r)
+{
+	damon_del_rule(r);
+	damon_free_rule(r);
+}
+
 /*
  * Returns number of monitoring target tasks
  */
@@ -600,11 +630,120 @@ static void kdamond_flush_aggregated(struct damon_ctx *c)
 			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
 			damon_write_rbuf(c, &r->nr_accesses,
 					sizeof(r->nr_accesses));
+			r->last_vm_start = r->vm_start;
+			r->last_vm_end = r->vm_end;
+			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
 	}
 }
 
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Adjust the age of the given region
+ *
+ * Increase '->age' if '->vm_start' and '->vm_end' has not changed and
+ * '->nr_accesses' has not changed more than the merge threshold.  Else, reset
+ * it.
+ */
+static void damon_do_count_age(struct damon_region *r, unsigned int threshold)
+{
+	if (r->vm_start != r->last_vm_start || r->vm_end != r->last_vm_end)
+		r->age = 0;
+	else if (diff_of(r->nr_accesses, r->last_nr_accesses) > threshold)
+		r->age = 0;
+	else
+		r->age++;
+}
+
+static void kdamond_count_age(struct damon_ctx *c, unsigned int threshold)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	damon_for_each_task(c, t) {
+		damon_for_each_region(r, t)
+			damon_do_count_age(r, threshold);
+	}
+}
+
+static int damon_do_action(struct damon_task *task, struct damon_region *r,
+			enum damon_action action)
+{
+	struct task_struct *t;
+	struct mm_struct *mm;
+	int madv_action;
+	int ret;
+
+	switch (action) {
+	case DAMON_MADV_WILLNEED:
+		madv_action = MADV_WILLNEED;
+		break;
+	case DAMON_MADV_COLD:
+		madv_action = MADV_COLD;
+		break;
+	case DAMON_MADV_PAGEOUT:
+		madv_action = MADV_PAGEOUT;
+		break;
+	case DAMON_MADV_HUGEPAGE:
+		madv_action = MADV_HUGEPAGE;
+		break;
+	case DAMON_MADV_NOHUGEPAGE:
+		madv_action = MADV_NOHUGEPAGE;
+		break;
+	default:
+		pr_warn("Wrong action %d\n", action);
+		return -EINVAL;
+	}
+
+	t = damon_get_task_struct(task);
+	if (!t)
+		return -EINVAL;
+	mm = damon_get_mm(task);
+	if (!mm) {
+		put_task_struct(t);
+		return -EINVAL;
+	}
+
+	ret = madvise_common(t, mm, PAGE_ALIGN(r->vm_start),
+			PAGE_ALIGN(r->vm_end - r->vm_start), madv_action);
+	put_task_struct(t);
+	mmput(mm);
+	return ret;
+}
+
+static void damon_do_apply_rules(struct damon_ctx *c, struct damon_task *t,
+				struct damon_region *r)
+{
+	struct damon_rule *rule;
+	unsigned long sz;
+
+	damon_for_each_rule(c, rule) {
+		sz = r->vm_end - r->vm_start;
+		if (sz < rule->min_sz_region ||  rule->max_sz_region < sz)
+			continue;
+		if (r->nr_accesses < rule->min_nr_accesses ||
+				rule->max_nr_accesses < r->nr_accesses)
+			continue;
+		if (r->age < rule->min_age_region ||
+				rule->max_age_region < r->age)
+			continue;
+		damon_do_action(t, r, rule->action);
+	}
+}
+
+static void kdamond_apply_rules(struct damon_ctx *c)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	damon_for_each_task(c, t) {
+		damon_for_each_region(r, t)
+			damon_do_apply_rules(c, t, r);
+	}
+}
+
 #define sz_damon_region(r) (r->vm_end - r->vm_start)
 
 /*
@@ -620,8 +759,6 @@ static void damon_merge_two_regions(struct damon_region *l,
 	damon_destroy_region(r);
 }
 
-#define diff_of(a, b) (a > b ? a - b : b - a)
-
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -865,6 +1002,8 @@ static int kdamond_fn(void *data)
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			kdamond_count_age(ctx, max_nr_accesses / 10);
+			kdamond_apply_rules(ctx);
 			kdamond_flush_aggregated(ctx);
 			kdamond_split_regions(ctx);
 			if (ctx->aggregate_cb)
@@ -952,6 +1091,22 @@ static inline bool damon_is_target_pid(struct damon_ctx *c, unsigned long pid)
 	return false;
 }
 
+/*
+ * This function should not be called while the kdamond is running.
+ */
+int damon_set_rules(struct damon_ctx *ctx, struct damon_rule **rules,
+			ssize_t nr_rules)
+{
+	struct damon_rule *r, *next;
+	ssize_t i;
+
+	damon_for_each_rule_safe(ctx, r, next)
+		damon_destroy_rule(r);
+	for (i = 0; i < nr_rules; i++)
+		damon_add_rule(ctx, rules[i]);
+	return 0;
+}
+
 /*
  * This function should not be called while the kdamond is running.
  */
@@ -1372,6 +1527,7 @@ static int __init damon_init_user_ctx(void)
 
 	prandom_seed_state(&ctx->rndseed, 42);
 	INIT_LIST_HEAD(&ctx->tasks_list);
+	INIT_LIST_HEAD(&ctx->rules_list);
 
 	ctx->sample_cb = NULL;
 	ctx->aggregate_cb = NULL;
-- 
2.17.1

