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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6C4C3524F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFBB21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkByRFCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgBDGXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:23:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41789 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:23:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id l3so5030384pgi.8;
        Mon, 03 Feb 2020 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=270R3ryK5W9GekVj2R4hKSZV/e4Iq5XlkTBUaed57HQ=;
        b=EkByRFCalMY0KBIC+DbgPwRHfOtKF7L8UyEmhNU5ZZ2UU5hMYo6b500BK0v9dzzSNp
         ra0NR4wr7IjyhA7/8FgoUQT7TVzkU43X1ZKsUrqsXwCPMKzmKBsDCyhZJ+5Ccj84plHW
         /eo9g1AYQZdN1BCfVPhQujx413iGlXhp+sBVgm/iRV8yxSvIM+zAZb8QAGCeIQTrJ4Gl
         uaDFkptO1DsK72GVgi8DvSF+GHBMU+ZVQIl6kaVfUFAKhskiFdAdswu5Vr9EILQcdPiq
         xUys6gvpt5AyfxuOMV8g/HHexGS8DIHpjMUd25mUlBjSzjc5T0t9t+twtEH6d+EpF+L4
         rKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=270R3ryK5W9GekVj2R4hKSZV/e4Iq5XlkTBUaed57HQ=;
        b=VsMRj7+6Yw2niy89C6/6rw1RfDfY2jIyp1yHxX2+7ZJfeWawdomevJYobkM1hUvMbP
         jGVxaNS/zdE5pAyU9+65qhmladATy7G3eWiPz/U9znYtxAofhHHz0r/RslCJcReM5ryK
         vD+4hdk4rn+tzovQuqIt0TNQZohOiIzDljrIgJueB27sROuuzhL/evHzWhYCm18fFju+
         BuWIS0JfrIE5f7IQCXYfUISNY3W+K5bSMoAZ+1qGBwmbcucJ6QiyXmNSZ5UOPBrZ2fv/
         LNztSXR9koRKZLzffj5ZOeZgNAPokPqRWVbkayFbp2IX5Mibcu8DuBy86yQiD1fGpkF+
         US9A==
X-Gm-Message-State: APjAAAXJpAL2Bx+aRadztej/BbzwWhhv4vH0yEKBarEJJhEitnlh6m9J
        BIXzL9G8sCPklpieAkBfB8M=
X-Google-Smtp-Source: APXvYqxdhRiGQ9JPl762FvxCepcr/57D4GZw7W1OxFQUJKDqod9ruwN45nTrme2Vkiy0GAiSis4Jkw==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr4708683pfh.189.1580797433766;
        Mon, 03 Feb 2020 22:23:53 -0800 (PST)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id u26sm21880240pfn.46.2020.02.03.22.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:23:53 -0800 (PST)
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
Subject: [PATCH v3 03/11] mm/damon: Adaptively adjust regions
Date:   Tue,  4 Feb 2020 06:23:04 +0000
Message-Id: <20200204062312.19913-4-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204062312.19913-1-sj38.park@gmail.com>
References: <20200204062312.19913-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

At the beginning of the monitoring, DAMON constructs the initial regions
by evenly splitting the memory mapped address space of the process into
the user-specified minimal number of regions.  In this initial state,
the assumption of the regions (pages in same region have similar access
frequencies) is normally not kept and thus the monitoring quality could
be low.  To keep the assumption as much as possible, DAMON adaptively
merges and splits each region.

For each ``aggregation interval``, it compares the access frequencies of
adjacent regions and merges those if the frequency difference is small.
Then, after it reports and clears the aggregated access frequency of
each region, it splits each region into two regions if the total number
of regions is smaller than the half of the user-specified maximum number
of regions.

In this way, DAMON provides its best-effort quality and minimal overhead
while keeping the bounds users set for their trade-off.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 5 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 5a98c1365ee9..13af2de8e45e 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -68,6 +68,7 @@ struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
 	unsigned long min_nr_regions;
+	unsigned long max_nr_regions;
 
 	struct timespec64 last_aggregation;
 
@@ -397,9 +398,12 @@ static int damon_three_regions_of(struct damon_task *t,
  * regions is wasteful.  That said, because we can deal with small noises,
  * tracking every mapping is not strictly required but could even incur a high
  * overhead if the mapping frequently changes or the number of mappings is
- * high.  Nonetheless, this may seems very weird.  DAMON's dynamic regions
- * adjustment mechanism, which will be implemented with following commit will
- * make this more sense.
+ * high.  The adaptive regions adjustment mechanism will further help to deal
+ * with the noises by simply identifying the unmapped areas as a region that
+ * has no access.  Moreover, applying the real mappings that would have many
+ * unmapped areas inside will make the adaptive mechanism quite complex.  That
+ * said, too huge unmapped areas inside the monitoring target should be removed
+ * to not take the time for the adaptive mechanism.
  *
  * For the reason, we convert the complex mappings to three distinct regions
  * that cover every mapped areas of the address space.  Also the two gaps
@@ -623,6 +627,123 @@ static void kdamond_flush_aggregated(struct damon_ctx *c)
 	}
 }
 
+#define sz_damon_region(r) (r->vm_end - r->vm_start)
+
+/*
+ * Merge two adjacent regions into one region
+ */
+static void damon_merge_two_regions(struct damon_region *l,
+				struct damon_region *r)
+{
+	l->nr_accesses = (l->nr_accesses * sz_damon_region(l) +
+			r->nr_accesses * sz_damon_region(r)) /
+			(sz_damon_region(l) + sz_damon_region(r));
+	l->vm_end = r->vm_end;
+	damon_destroy_region(r);
+}
+
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * t		task that merge operation will make change
+ * thres	merge regions having '->nr_accesses' diff smaller than this
+ */
+static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
+{
+	struct damon_region *r, *prev = NULL, *next;
+
+	damon_for_each_region_safe(r, next, t) {
+		if (!prev || prev->vm_end != r->vm_start)
+			goto next;
+		if (diff_of(prev->nr_accesses, r->nr_accesses) > thres)
+			goto next;
+		damon_merge_two_regions(prev, r);
+		continue;
+next:
+		prev = r;
+	}
+}
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * threshold	merge regions havind nr_accesses diff larger than this
+ *
+ * This function merges monitoring target regions which are adjacent and their
+ * access frequencies are similar.  This is for minimizing the monitoring
+ * overhead under the dynamically changeable access pattern.  If a merge was
+ * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ */
+static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold)
+{
+	struct damon_task *t;
+
+	damon_for_each_task(c, t)
+		damon_merge_regions_of(t, threshold);
+}
+
+/*
+ * Split a region into two small regions
+ *
+ * r		the region to be split
+ * sz_r		size of the first sub-region that will be made
+ */
+static void damon_split_region_at(struct damon_ctx *ctx,
+		struct damon_region *r, unsigned long sz_r)
+{
+	struct damon_region *new;
+
+	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
+	r->vm_end = new->vm_start;
+
+	damon_add_region(new, r, damon_next_region(r));
+}
+
+static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
+{
+	struct damon_region *r, *next;
+	unsigned long sz_left_region;
+
+	damon_for_each_region_safe(r, next, t) {
+		/*
+		 * Randomly select size of left sub-region to be at least
+		 * 10 percent and at most 90% of original region
+		 */
+		sz_left_region = (prandom_u32_state(&ctx->rndseed) % 9 + 1) *
+			(r->vm_end - r->vm_start) / 10;
+		/* Do not allow blank region */
+		if (sz_left_region == 0)
+			continue;
+		damon_split_region_at(ctx, r, sz_left_region);
+	}
+}
+
+/*
+ * splits every target regions into two randomly-sized regions
+ *
+ * This function splits every target regions into two random-sized regions if
+ * current total number of the regions is smaller than the half of the
+ * user-specified maximum number of regions.  This is for maximizing the
+ * monitoring accuracy under the dynamically changeable access patterns.  If a
+ * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
+ * it.
+ */
+static void kdamond_split_regions(struct damon_ctx *ctx)
+{
+	struct damon_task *t;
+	unsigned int nr_regions = 0;
+
+	damon_for_each_task(ctx, t)
+		nr_regions += nr_damon_regions(t);
+	if (nr_regions > ctx->max_nr_regions / 2)
+		return;
+
+	damon_for_each_task(ctx, t)
+		damon_split_regions_of(ctx, t);
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -663,21 +784,29 @@ static int kdamond_fn(void *data)
 	struct damon_task *t;
 	struct damon_region *r, *next;
 	struct mm_struct *mm;
+	unsigned long max_nr_accesses;
 
 	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
 	kdamond_init_regions(ctx);
 	while (!kdamond_need_stop(ctx)) {
+		max_nr_accesses = 0;
 		damon_for_each_task(ctx, t) {
 			mm = damon_get_mm(t);
 			if (!mm)
 				continue;
-			damon_for_each_region(r, t)
+			damon_for_each_region(r, t) {
 				kdamond_check_access(ctx, mm, r);
+				if (r->nr_accesses > max_nr_accesses)
+					max_nr_accesses = r->nr_accesses;
+			}
 			mmput(mm);
 		}
 
-		if (kdamond_aggregate_interval_passed(ctx))
+		if (kdamond_aggregate_interval_passed(ctx)) {
+			kdamond_merge_regions(ctx, max_nr_accesses / 10);
 			kdamond_flush_aggregated(ctx);
+			kdamond_split_regions(ctx);
+		}
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 	}
@@ -827,6 +956,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
  * sample_int		time interval between samplings
  * aggr_int		time interval between aggregations
  * min_nr_reg		minimal number of regions
+ * max_nr_reg		maximum number of regions
  *
  * This function should not be called while the kdamond is running.
  * Every time interval is in micro-seconds.
@@ -841,10 +971,16 @@ static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 				min_nr_reg);
 		return -EINVAL;
 	}
+	if (min_nr_reg >= ctx->max_nr_regions) {
+		pr_err("invalid nr_regions.  min (%lu) >= max (%lu)\n",
+				min_nr_reg, max_nr_reg);
+		return -EINVAL;
+	}
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
 	ctx->min_nr_regions = min_nr_reg;
+	ctx->max_nr_regions = max_nr_reg;
 	return 0;
 }
 
-- 
2.17.1

