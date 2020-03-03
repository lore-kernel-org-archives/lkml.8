Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8040C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FFB20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vqsYvwB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgCCMPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:15:51 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:27988 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgCCMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583237751; x=1614773751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6tkh9u5nqtQH7epyTSmeeDD5i1ophpDMX3yMloZKKj0=;
  b=vqsYvwB9aReU9gXDHshCWVyh1a0q6eEj8zVXkSNtAEavm/KoxjuftU0I
   3TPx+XCWIw3A6LZ41jbzw8msfQSu6kGIJTHPmKYRK4TVWA4JCIsVWlSh8
   o5NOWiBnHWO3eed7kfV51jypiKHGvQA7hYqbRf3r5zsBwE/6FWESLkZR4
   Y=;
IronPort-SDR: odLd7G8yot+aqwFmODHCuKsHcJZoR7TU5mIbqXmuO9YC3HzmaxZD0Uekg8uNpXLGN1q9nvrEBC
 HPlnSUV7sTLQ==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="28845641"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 03 Mar 2020 12:15:48 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 6D510A1834;
        Tue,  3 Mar 2020 12:15:46 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 12:15:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Mar 2020 12:15:33 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v4 3/7] mm/damon: Implement data access monitoring-based operation schemes
Date:   Tue, 3 Mar 2020 13:14:02 +0100
Message-ID: <20200303121406.20954-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303121406.20954-1-sjpark@amazon.com>
References: <20200303121406.20954-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D22UWB002.ant.amazon.com (10.43.161.28) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

In many cases, users might use DAMON for simple data access awared
memory management optimizations such as applying an operation scheme to
a memory region of a specific size having a specific access frequency
for a specific time.  For example, "page out a memory region larger than
100 MiB but having a low access frequency more than 10 minutes", or "Use
THP for a memory region larger than 2 MiB having a high access frequency
for more than 2 seconds".

To minimize users from spending their time for implementation of such
simple data access monitoring-based operation schemes, this commit makes
DAMON to handle such schemes directly.  With this commit, users can
simply specify their desired schemes to DAMON.

Each of the schemes is composed with conditions for filtering of the
target memory regions and desired memory management action for the
target.  In specific, the format is::

    <min/max size> <min/max access frequency> <min/max age> <action>

The filtering conditions are size of memory region, number of accesses
to the region monitored by DAMON, and the age of the region.  The age of
region is incremented periodically but reset when its addresses or
access frequency has significanly changed or the action of a scheme has
applied.  For the action, current implementation supports only a few of
madvise() hints, ``MADV_WILLNEED``, ``MADV_COLD``, ``MADV_PAGEOUT``,
``MADV_HUGEPAGE``, and ``MADV_NOHUGEPAGE``.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  24 ++++++++
 mm/damon.c            | 140 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 50fbe308590e..8cb2452579ee 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -36,6 +36,27 @@ struct damon_task {
 	struct list_head list;
 };
 
+/* Data Access Monitoring-based Operation Scheme */
+enum damos_action {
+	DAMOS_WILLNEED,
+	DAMOS_COLD,
+	DAMOS_PAGEOUT,
+	DAMOS_HUGEPAGE,
+	DAMOS_NOHUGEPAGE,
+	DAMOS_ACTION_LEN,
+};
+
+struct damos {
+	unsigned int min_sz_region;
+	unsigned int max_sz_region;
+	unsigned int min_nr_accesses;
+	unsigned int max_nr_accesses;
+	unsigned int min_age_region;
+	unsigned int max_age_region;
+	enum damos_action action;
+	struct list_head list;
+};
+
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
@@ -58,6 +79,7 @@ struct damon_ctx {
 	struct rnd_state rndseed;
 
 	struct list_head tasks_list;	/* 'damon_task' objects */
+	struct list_head schemes_list;	/* 'damos' objects */
 
 	/* callbacks */
 	void (*sample_cb)(struct damon_ctx *context);
@@ -66,6 +88,8 @@ struct damon_ctx {
 
 int damon_set_pids(struct damon_ctx *ctx,
 			unsigned long *pids, ssize_t nr_pids);
+int damon_set_schemes(struct damon_ctx *ctx,
+			struct damos **schemes, ssize_t nr_schemes);
 int damon_set_recording(struct damon_ctx *ctx,
 			unsigned int rbuf_len, char *rfile_path);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long s, unsigned long a,
diff --git a/mm/damon.c b/mm/damon.c
index c292ddd36c86..338e7ea76c7f 100644
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
 
+#define damon_for_each_schemes(ctx, r) \
+	list_for_each_entry(r, &(ctx)->schemes_list, list)
+
+#define damon_for_each_schemes_safe(ctx, s, next) \
+	list_for_each_entry_safe(s, next, &(ctx)->schemes_list, list)
+
 #define MAX_RFILE_PATH_LEN	256
 
 /* Get a random number in [l, r) */
@@ -190,6 +199,27 @@ static void damon_destroy_task(struct damon_task *t)
 	damon_free_task(t);
 }
 
+static void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
+{
+	list_add_tail(&s->list, &ctx->schemes_list);
+}
+
+static void damon_del_scheme(struct damos *s)
+{
+	list_del(&s->list);
+}
+
+static void damon_free_scheme(struct damos *s)
+{
+	kfree(s);
+}
+
+static void damon_destroy_scheme(struct damos *s)
+{
+	damon_del_scheme(s);
+	damon_free_scheme(s);
+}
+
 /*
  * Returns number of monitoring target tasks
  */
@@ -642,6 +672,93 @@ static void kdamond_count_age(struct damon_ctx *c, unsigned int threshold)
 	}
 }
 
+static int damos_madvise(struct damon_task *task, struct damon_region *r,
+			int behavior)
+{
+	struct task_struct *t;
+	struct mm_struct *mm;
+	int ret = -ENOMEM;
+
+	t = damon_get_task_struct(task);
+	if (!t)
+		goto out;
+	mm = damon_get_mm(task);
+	if (!mm)
+		goto put_task_out;
+
+	ret = madvise_common(t, mm, PAGE_ALIGN(r->vm_start),
+			PAGE_ALIGN(r->vm_end - r->vm_start), behavior);
+	mmput(mm);
+put_task_out:
+	put_task_struct(t);
+out:
+	return ret;
+}
+
+static int damos_do_action(struct damon_task *task, struct damon_region *r,
+			enum damos_action action)
+{
+	int madv_action;
+
+	switch (action) {
+	case DAMOS_WILLNEED:
+		madv_action = MADV_WILLNEED;
+		break;
+	case DAMOS_COLD:
+		madv_action = MADV_COLD;
+		break;
+	case DAMOS_PAGEOUT:
+		madv_action = MADV_PAGEOUT;
+		break;
+	case DAMOS_HUGEPAGE:
+		madv_action = MADV_HUGEPAGE;
+		break;
+	case DAMOS_NOHUGEPAGE:
+		madv_action = MADV_NOHUGEPAGE;
+		break;
+	default:
+		pr_warn("Wrong action %d\n", action);
+		return -EINVAL;
+	}
+
+	return damos_madvise(task, r, madv_action);
+}
+
+static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
+				struct damon_region *r)
+{
+	struct damos *s;
+	unsigned long sz;
+
+	damon_for_each_schemes(c, s) {
+		sz = r->vm_end - r->vm_start;
+		if ((s->min_sz_region && sz < s->min_sz_region) ||
+				(s->max_sz_region && s->max_sz_region < sz))
+			continue;
+		if ((s->min_nr_accesses && r->nr_accesses < s->min_nr_accesses)
+				|| (s->max_nr_accesses &&
+					s->max_nr_accesses < r->nr_accesses))
+			continue;
+		if ((s->min_age_region && r->age < s->min_age_region) ||
+				(s->max_age_region &&
+				 s->max_age_region < r->age))
+			continue;
+		damos_do_action(t, r, s->action);
+		r->age = 0;
+	}
+}
+
+static void kdamond_apply_schemes(struct damon_ctx *c)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	damon_for_each_task(c, t) {
+		damon_for_each_region(r, t)
+			damon_do_apply_schemes(c, t, r);
+	}
+}
+
 #define sz_damon_region(r) (r->vm_end - r->vm_start)
 
 /*
@@ -937,6 +1054,7 @@ static int kdamond_fn(void *data)
 			kdamond_count_age(ctx, max_nr_accesses / 10);
 			if (ctx->aggregate_cb)
 				ctx->aggregate_cb(ctx);
+			kdamond_apply_schemes(ctx);
 			kdamond_flush_aggregated(ctx);
 			kdamond_split_regions(ctx);
 		}
@@ -1011,6 +1129,27 @@ int damon_stop(struct damon_ctx *ctx)
 	return damon_turn_kdamond(ctx, false);
 }
 
+/*
+ * Set the data access monitoring oriented schemes
+ *
+ * NOTE: This function should not be called while the kdamond of the context is
+ * running.
+ *
+ * Returns 0 if success, or negative error code otherwise.
+ */
+int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
+			ssize_t nr_schemes)
+{
+	struct damos *s, *next;
+	ssize_t i;
+
+	damon_for_each_schemes_safe(ctx, s, next)
+		damon_destroy_scheme(s);
+	for (i = 0; i < nr_schemes; i++)
+		damon_add_scheme(ctx, schemes[i]);
+	return 0;
+}
+
 /*
  * This function should not be called while the kdamond is running.
  */
@@ -1456,6 +1595,7 @@ static int __init damon_init_user_ctx(void)
 
 	prandom_seed_state(&ctx->rndseed, 42);
 	INIT_LIST_HEAD(&ctx->tasks_list);
+	INIT_LIST_HEAD(&ctx->schemes_list);
 
 	ctx->sample_cb = NULL;
 	ctx->aggregate_cb = NULL;
-- 
2.17.1

