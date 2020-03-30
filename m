Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A5C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9004F206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K+RJs7Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgC3Lwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:52:38 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:62459 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgC3Lwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585569158; x=1617105158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SWBqH7Gy0/2imeh783ZOBxxaw5cChVsnKQHmp0qQ7SQ=;
  b=K+RJs7VfQG0KT5mwq2CNx6jP2N5PzkarLdUdSVf8TJo0+3b8bnnMDmFR
   g5UaPLJePk9lst35d3HZ23gPAYcQMoTwxcUXYmmkA6Lm1fKWWEJC7qww2
   SN4QtHfZ1Pms6jk7tz5WkR4B/QPy5OpI5NeN7NQQopzu7R9qYOQjHuGDr
   E=;
IronPort-SDR: 92jddMkFB8/ASpFe2cmkSoGFEiJqoTv6dmPsSdzIKcuTNnFkvK7t2ihTtFHAxfh464iIVW/TwN
 Rjaf9yzh4SAA==
X-IronPort-AV: E=Sophos;i="5.72,324,1580774400"; 
   d="scan'208";a="23460857"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 Mar 2020 11:52:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 4E2C0A2919;
        Mon, 30 Mar 2020 11:52:14 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 30 Mar 2020 11:52:14 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.134) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 30 Mar 2020 11:52:00 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v5 2/7] mm/damon: Account age of target regions
Date:   Mon, 30 Mar 2020 13:50:37 +0200
Message-ID: <20200330115042.17431-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330115042.17431-1-sjpark@amazon.com>
References: <20200330115042.17431-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D37UWC003.ant.amazon.com (10.43.162.183) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON can be used as a primitive for data access pattern awared memory
maangement optimizations.  However, users who want such optimizations
should run DAMON, read the monitoring results, analyze it, plan a new
memory management scheme, and apply the new scheme by themselves.  It
would not be too hard, but still require some level of efforts.  For
complicated optimizations, this effort is inevitable.

That said, in many cases, users would simply want to apply an actions to
a memory region of a specific size having a specific access frequency
for a specific time.  For example, "page out a memory region larger than
100 MiB but having a low access frequency more than 10 minutes", or "Use
THP for a memory region larger than 2 MiB having a high access frequency
for more than 2 seconds".

For such optimizations, users will need to first account the age of each
region themselves.  To reduce such efforts, this commit implements a
simple age account of each region in DAMON.  For each aggregation step,
DAMON compares the access frequency and start/end address of each region
with those from last aggregation and reset the age of the region if the
change is significant.  Else, the age is incremented.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |   5 ++
 mm/damon.c            | 105 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 47fb0ec03030..49205c71c63d 100644
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
diff --git a/mm/damon.c b/mm/damon.c
index 4ca8a822c30c..3eeb729f3947 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -79,6 +79,10 @@ static struct damon_region *damon_new_region(struct damon_ctx *ctx,
 	region->sampling_addr = damon_rand(ctx, vm_start, vm_end);
 	INIT_LIST_HEAD(&region->list);
 
+	region->age = 0;
+	region->last_vm_start = vm_start;
+	region->last_vm_end = vm_end;
+
 	return region;
 }
 
@@ -613,11 +617,44 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 					sizeof(r->nr_accesses));
 			trace_damon_aggregated(t->pid, nr,
 					r->vm_start, r->vm_end, r->nr_accesses);
+			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
 	}
 }
 
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Increase or reset the age of the given monitoring target region
+ *
+ * If the area or '->nr_accesses' has changed significantly, reset the '->age'.
+ * Else, increase the age.
+ */
+static void damon_do_count_age(struct damon_region *r, unsigned int threshold)
+{
+	unsigned long sz_threshold = (r->vm_end - r->vm_start) / 5;
+
+	if (diff_of(r->vm_start, r->last_vm_start) +
+			diff_of(r->vm_end, r->last_vm_end) > sz_threshold)
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
 #define sz_damon_region(r) (r->vm_end - r->vm_start)
 
 /*
@@ -626,33 +663,86 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 static void damon_merge_two_regions(struct damon_region *l,
 				struct damon_region *r)
 {
-	l->nr_accesses = (l->nr_accesses * sz_damon_region(l) +
-			r->nr_accesses * sz_damon_region(r)) /
-			(sz_damon_region(l) + sz_damon_region(r));
+	unsigned long sz_l = sz_damon_region(l), sz_r = sz_damon_region(r);
+
+	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
+			(sz_l + sz_r);
+	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->vm_end = r->vm_end;
 	damon_destroy_region(r);
 }
 
-#define diff_of(a, b) (a > b ? a - b : b - a)
+static inline void set_last_area(struct damon_region *r, struct region *last)
+{
+	r->last_vm_start = last->start;
+	r->last_vm_end = last->end;
+}
+
+static inline void get_last_area(struct damon_region *r, struct region *last)
+{
+	last->start = r->last_vm_start;
+	last->end = r->last_vm_end;
+}
 
 /*
  * Merge adjacent regions having similar access frequencies
  *
  * t		task that merge operation will make change
  * thres	merge regions having '->nr_accesses' diff smaller than this
+ *
+ * After each merge, the biggest mergee region becomes the last shape of the
+ * new region.  If two regions splitted from one region at the end of previous
+ * aggregation interval are merged into one region, we handle the two regions
+ * as one big mergee, because it can lead to unproper last shape record if we
+ * don't do so.
+ *
+ * To understand why we take special care for regions splitted from one region,
+ * suppose that a region of size 10 has splitted into two regions of size 4 and
+ * 6.  Two regions show similar access frequency for next aggregation interval
+ * and thus now be merged into one region again.  Because the split is made
+ * regardless of the access pattern, DAMON should say the region of size 10 had
+ * no area change for last aggregation interval.  However, if the two mergees
+ * are handled seperatively, DAMON will say the merged region has changed its
+ * size from 6 to 10.
  */
 static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 {
 	struct damon_region *r, *prev = NULL, *next;
+	struct region biggest_mergee;	/* the biggest region being merged */
+	unsigned long sz_biggest = 0;	/* size of the biggest_mergee */
+	unsigned long sz_mergee = 0;	/* size of current mergee */
 
 	damon_for_each_region_safe(r, next, t) {
 		if (!prev || prev->vm_end != r->vm_start ||
 		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
+			if (sz_biggest)
+				set_last_area(prev, &biggest_mergee);
+
 			prev = r;
+			sz_biggest = sz_damon_region(prev);
+			get_last_area(prev, &biggest_mergee);
 			continue;
 		}
+
+
+		/* Set size of current mergee and biggest mergee */
+		sz_mergee += sz_damon_region(r);
+		if (sz_mergee > sz_biggest) {
+			sz_biggest = sz_mergee;
+			get_last_area(r, &biggest_mergee);
+		}
+
+		/*
+		 * If next region and current region is not originated from
+		 * same region, initialize the size of mergee.
+		 */
+		if (r->last_vm_start != next->last_vm_start)
+			sz_mergee = 0;
+
 		damon_merge_two_regions(prev, r);
 	}
+	if (sz_biggest)
+		set_last_area(prev, &biggest_mergee);
 }
 
 /*
@@ -685,6 +775,12 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 	struct damon_region *new;
 
 	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
+	new->age = r->age;
+	new->last_vm_start = r->vm_start;
+	new->last_nr_accesses = r->last_nr_accesses;
+
+	r->last_vm_start = r->vm_start;
+	r->last_vm_end = r->vm_end;
 	r->vm_end = new->vm_start;
 
 	damon_insert_region(new, r, damon_next_region(r));
@@ -874,6 +970,7 @@ static int kdamond_fn(void *data)
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			kdamond_count_age(ctx, max_nr_accesses / 10);
 			if (ctx->aggregate_cb)
 				ctx->aggregate_cb(ctx);
 			kdamond_reset_aggregated(ctx);
-- 
2.17.1

