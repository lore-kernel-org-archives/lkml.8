Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F47BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7820857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nHhgj1KX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgCCMP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:15:29 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:15350 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgCCMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583237728; x=1614773728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XU7MCEqVBpw+dGJYEvQn0yHY813ydWFHwe8qEM26yTk=;
  b=nHhgj1KXy6hY38FPdGYqiDQrU2yR2m75oocYM7mSY1hTcH9vRRrDwJOz
   9uNkILUnwDYfWB8b6ptV2UbII5k/9xMuLS+YgmIWcUVw4iJ7G4Fz6w1/d
   /NzQNyfrq939qtH41mo15K4zu1RzDMrmiwnqsL12DmI18R2e4toM6nRfa
   I=;
IronPort-SDR: W/BJk7aspZ2vT4gMjxsOkUsnBxJMGdTygkEnCXCB0oJuN/WVZkBb014pamLvNShviJS+eYtrtU
 mFtrlFHje38w==
X-IronPort-AV: E=Sophos;i="5.70,511,1574121600"; 
   d="scan'208";a="20475725"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 03 Mar 2020 12:15:27 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 70916A2743;
        Tue,  3 Mar 2020 12:15:25 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 3 Mar 2020 12:15:25 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Mar 2020 12:15:13 +0000
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
Subject: [RFC v4 2/7] mm/damon: Account age of target regions
Date:   Tue, 3 Mar 2020 13:14:01 +0100
Message-ID: <20200303121406.20954-3-sjpark@amazon.com>
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
 include/linux/damon.h |  5 +++
 mm/damon.c            | 80 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 78785cb88d42..50fbe308590e 100644
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
index ff150ae7532a..c292ddd36c86 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -87,6 +87,10 @@ static struct damon_region *damon_new_region(struct damon_ctx *ctx,
 	ret->sampling_addr = damon_rand(ctx, vm_start, vm_end);
 	INIT_LIST_HEAD(&ret->list);
 
+	ret->age = 0;
+	ret->last_vm_start = vm_start;
+	ret->last_vm_end = vm_end;
+
 	return ret;
 }
 
@@ -600,11 +604,44 @@ static void kdamond_flush_aggregated(struct damon_ctx *c)
 			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
 			damon_write_rbuf(c, &r->nr_accesses,
 					sizeof(r->nr_accesses));
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
@@ -613,15 +650,15 @@ static void kdamond_flush_aggregated(struct damon_ctx *c)
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
-
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -631,17 +668,43 @@ static void damon_merge_two_regions(struct damon_region *l,
 static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 {
 	struct damon_region *r, *prev = NULL, *next;
+	unsigned long sz_subregion, last_last_vm = 0;
+	unsigned long sz_biggest = 0;	/* size of the biggest subregion */
+	struct region last_biggest;	/* last region of the biggest sub */
 
 	damon_for_each_region_safe(r, next, t) {
 		if (!prev || prev->vm_end != r->vm_start)
 			goto next;
 		if (diff_of(prev->nr_accesses, r->nr_accesses) > thres)
 			goto next;
+		if (!sz_biggest) {
+			sz_biggest = sz_damon_region(prev);
+			last_biggest.start = prev->last_vm_start;
+			last_biggest.end = prev->last_vm_end;
+		}
+		if (last_last_vm != r->last_vm_start)
+			sz_subregion = 0;
+		sz_subregion += sz_damon_region(r);
+		last_last_vm = r->last_vm_start;
+		if (sz_subregion > sz_biggest) {
+			sz_biggest = sz_subregion;
+			last_biggest.start = r->last_vm_start;
+			last_biggest.end = r->last_vm_end;
+		}
 		damon_merge_two_regions(prev, r);
 		continue;
 next:
+		if (sz_biggest) {
+			sz_biggest = 0;
+			prev->last_vm_start = last_biggest.start;
+			prev->last_vm_end = last_biggest.end;
+		}
 		prev = r;
 	}
+	if (sz_biggest) {
+		prev->last_vm_start = last_biggest.start;
+		prev->last_vm_end = last_biggest.end;
+	}
 }
 
 /*
@@ -674,6 +737,12 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 	struct damon_region *new;
 
 	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
+	new->age = r->age;
+	new->last_vm_start = r->vm_start;
+	new->last_nr_accesses = r->last_nr_accesses;
+
+	r->last_vm_start = r->vm_start;
+	r->last_vm_end = r->vm_end;
 	r->vm_end = new->vm_start;
 
 	damon_add_region(new, r, damon_next_region(r));
@@ -865,6 +934,7 @@ static int kdamond_fn(void *data)
 
 		if (kdamond_aggregate_interval_passed(ctx)) {
 			kdamond_merge_regions(ctx, max_nr_accesses / 10);
+			kdamond_count_age(ctx, max_nr_accesses / 10);
 			if (ctx->aggregate_cb)
 				ctx->aggregate_cb(ctx);
 			kdamond_flush_aggregated(ctx);
-- 
2.17.1

