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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C5DC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6246321741
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEUYAryv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBDGYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:24:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36295 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgBDGYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:24:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id 185so8918469pfv.3;
        Mon, 03 Feb 2020 22:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9XwPpcnrzgrrw2vWDfOiJeo4D6MamUNM5l6+xL07jw=;
        b=uEUYAryv7P2zxdgxNMrVTxeekTfgrccxN/u4AEhYDIvEzXkHCPZHyM0cOVtf5sGTl5
         OM+wkzoea2bsplWFr0OqoTURmZwuM+TYK/WcMNkVSz/raAH6cz0UHo8c+HcLfZyzIcsc
         OORPROX3zrNRI72fhfhUsECFLpCccHQkRA6rIJAiw+epndmwN/d7fKG4Ifb79LCL6zse
         Sai2963aHUj6Alx4ci4rAWhXMB6rD+i3EXsYZkLhIZFXaraM+Eccd2eMn9Xn9NCsmXQ0
         ZjDmCB/cJqD380DVoJgG2cLvwQY/tlp7ZIWZc7dGpArkRBvlcS61Ns1Pa5+Jr1Ja7HYW
         QWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x9XwPpcnrzgrrw2vWDfOiJeo4D6MamUNM5l6+xL07jw=;
        b=J3BpJ754FZfCUCyxRpKIx98ISQM7pi4q6my0IsHuRtS3D/1sI+Aj/pUwdfUizcC5YH
         tjnEM0BLbjAulFNcwJz1lNtHb8liQtOhJe/7hkbm/m2ybUXHAi1kvOa0YnKOq2sV4mKf
         jZXwMaOCPVZM3xXtybYaRYRsaSac/ivF4Ld+iHJmhZ5J4GVx3PTmGfQCgXAc6T72gVY0
         yHtv2C+7JGTsiur0z4o1J1QH4xc+h0czP1pK2JOGan+z2lZiyDHZNHFQoCiBKwR1IWwx
         TNvYoisTU4Q3q+nmmAJLvCMMzsGbVDngzu7lEkr0OAIp9SyMu/fRBVqrXtgBIdY6YI2t
         y9vg==
X-Gm-Message-State: APjAAAW85sAZcB7xlLcOmsbRUQt/B5KplXx/gwS1wNO4JY2PbEs/NdM7
        veHyqyuVph7lug/fPUphwD8=
X-Google-Smtp-Source: APXvYqwzpUW++1KXmfW0MFnVqd4owKGJSsz+q5qQT4TEZZDhWoZ8Ew6f2A8xW5Z9llKdZ2DOkG8YMQ==
X-Received: by 2002:a63:1f5b:: with SMTP id q27mr15753698pgm.434.1580797441323;
        Mon, 03 Feb 2020 22:24:01 -0800 (PST)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id u26sm21880240pfn.46.2020.02.03.22.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:24:00 -0800 (PST)
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
Subject: [PATCH v3 04/11] mm/damon: Apply dynamic memory mapping changes
Date:   Tue,  4 Feb 2020 06:23:05 +0000
Message-Id: <20200204062312.19913-5-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200204062312.19913-1-sj38.park@gmail.com>
References: <20200204062312.19913-1-sj38.park@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Only a number of parts in the virtual address space of the processes is
mapped to physical memory and accessed.  Thus, tracking the unmapped
address regions is just wasteful.  However, tracking every memory
mapping change might incur an overhead.  For the reason, DAMON applies
the dynamic memory mapping changes to the tracking regions only for each
of a user-specified time interval (``regions update interval``).

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 13af2de8e45e..8fb1e090733c 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -60,13 +60,16 @@ struct damon_task {
  * For each 'sample_interval', DAMON checks whether each region is accessed or
  * not.  It aggregates and keeps the access information (number of accesses to
  * each region) for 'aggr_interval' and then flushes it to the result buffer if
- * an 'aggr_interval' surpassed.
+ * an 'aggr_interval' surpassed.  And for each 'regions_update_interval', damon
+ * checks whether the memory mapping of the target tasks has changed (e.g., by
+ * mmap() calls from the applications) and applies the changes.
  *
  * All time intervals are in micro-seconds.
  */
 struct damon_ctx {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
+	unsigned long regions_update_interval;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 
@@ -744,6 +747,87 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		damon_split_regions_of(ctx, t);
 }
 
+/*
+ * Check whether it is time to check and apply the dynamic mmap changes
+ *
+ * Returns true if it is.
+ */
+static bool kdamond_need_update_regions(struct damon_ctx *ctx)
+{
+	return damon_check_reset_time_interval(&ctx->last_regions_update,
+			ctx->regions_update_interval);
+}
+
+static bool damon_intersect(struct damon_region *r, struct region *re)
+{
+	return !(r->vm_end <= re->start || re->end <= r->vm_start);
+}
+
+/*
+ * Update damon regions for the three big regions of the given task
+ *
+ * t		the given task
+ * bregions	the three big regions of the task
+ */
+static void damon_apply_three_regions(struct damon_ctx *ctx,
+		struct damon_task *t, struct region bregions[3])
+{
+	struct damon_region *r, *next;
+	unsigned int i = 0;
+
+	/* Remove regions which isn't in the three big regions now */
+	damon_for_each_region_safe(r, next, t) {
+		for (i = 0; i < 3; i++) {
+			if (damon_intersect(r, &bregions[i]))
+				break;
+		}
+		if (i == 3)
+			damon_destroy_region(r);
+	}
+
+	/* Adjust intersecting regions to fit with the threee big regions */
+	for (i = 0; i < 3; i++) {
+		struct damon_region *first = NULL, *last;
+		struct damon_region *newr;
+		struct region *br;
+
+		br = &bregions[i];
+		/* Get the first and last regions which intersects with br */
+		damon_for_each_region(r, t) {
+			if (damon_intersect(r, br)) {
+				if (!first)
+					first = r;
+				last = r;
+			}
+			if (r->vm_start >= br->end)
+				break;
+		}
+		if (!first) {
+			/* no damon_region intersects with this big region */
+			newr = damon_new_region(ctx, br->start, br->end);
+			damon_add_region(newr, damon_prev_region(r), r);
+		} else {
+			first->vm_start = br->start;
+			last->vm_end = br->end;
+		}
+	}
+}
+
+/*
+ * Update regions for current memory mappings
+ */
+static void kdamond_update_regions(struct damon_ctx *ctx)
+{
+	struct region three_regions[3];
+	struct damon_task *t;
+
+	damon_for_each_task(ctx, t) {
+		if (damon_three_regions_of(t, three_regions))
+			continue;
+		damon_apply_three_regions(ctx, t, three_regions);
+	}
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -808,6 +892,9 @@ static int kdamond_fn(void *data)
 			kdamond_split_regions(ctx);
 		}
 
+		if (kdamond_need_update_regions(ctx))
+			kdamond_update_regions(ctx);
+
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 	}
 	damon_flush_rbuffer(ctx);
@@ -955,6 +1042,7 @@ static int damon_set_recording(struct damon_ctx *ctx,
  *
  * sample_int		time interval between samplings
  * aggr_int		time interval between aggregations
+ * regions_update_int	time interval between vma update checks
  * min_nr_reg		minimal number of regions
  * max_nr_reg		maximum number of regions
  *
@@ -964,7 +1052,8 @@ static int damon_set_recording(struct damon_ctx *ctx,
  * Returns 0 on success, negative error code otherwise.
  */
 static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
-		unsigned long aggr_int, unsigned long min_nr_reg)
+		unsigned long aggr_int, unsigned long regions_update_int,
+		unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
 	if (min_nr_reg < 3) {
 		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
@@ -979,6 +1068,7 @@ static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
+	ctx->regions_update_interval = regions_update_int;
 	ctx->min_nr_regions = min_nr_reg;
 	ctx->max_nr_regions = max_nr_reg;
 	return 0;
-- 
2.17.1

