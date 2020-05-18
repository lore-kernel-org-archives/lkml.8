Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B649F20801
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 10:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QHkYza8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgERKFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 06:05:21 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:49652 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgERKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589796320; x=1621332320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fovQ16L+stcdrxZLgubG+D9JSvkNCqpwdVSTbsWqGSk=;
  b=QHkYza8IY5WYYXJDNDB8/L6PyG4bK6CM1+DlfvY73ZaJXj2Be9TWsz9/
   ADpbaU+y06sXcnRro5NhsJxaJkXQCh0XjYQp6GGSj1obGFuEZVV5RutOo
   Yu0h77JxA9Dyga8tRKMFI5rDn5Yj8cHRXv/eRs1c3wp1W86ZTlV57qOAq
   w=;
IronPort-SDR: 3lposJMuKVyCpsEMqUrjgdlwAlAVRHMJKcJp84bC+EwnzqvOmPc8k5/eixyb14KMVKVdswhMHl
 IQvKAmHLs2jQ==
X-IronPort-AV: E=Sophos;i="5.73,406,1583193600"; 
   d="scan'208";a="44034842"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 May 2020 10:05:16 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id F3738A24A3;
        Mon, 18 May 2020 10:05:04 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:05:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.90) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 18 May 2020 10:04:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 06/16] mm/damon: Split regions into 3 subregions if necessary
Date:   Mon, 18 May 2020 12:00:08 +0200
Message-ID: <20200518100018.2293-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518100018.2293-1-sjpark@amazon.com>
References: <20200518100018.2293-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.90]
X-ClientProxiedBy: EX13D04UWA003.ant.amazon.com (10.43.160.212) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Suppose that there are a very wide and cold region and a hot region, and
both regions are identified by DAMON.  And then, the middle small region
inside the very wide and cold region becomes hot.  DAMON will not be
able to identify this new region because the adaptive regions adjustment
mechanism splits each region to only two subregions.

This commit modifies the logic to split each region to 3 subregions if
such corner case is detected.

Suggested-by: James Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 6c9581104caf..bbd5b1d921da 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -650,26 +650,32 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 	damon_insert_region(new, r, damon_next_region(r));
 }
 
-/* Split every region in the given task into two randomly-sized regions */
-static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
+/* Split every region in the given task into 'nr_subs' regions */
+static void damon_split_regions_of(struct damon_ctx *ctx,
+				     struct damon_task *t, int nr_subs)
 {
 	struct damon_region *r, *next;
-	unsigned long sz_orig_region, sz_left_region;
+	unsigned long sz_region, sz_sub = 0;
+	int i;
 
 	damon_for_each_region_safe(r, next, t) {
-		sz_orig_region = r->vm_end - r->vm_start;
-
-		/*
-		 * Randomly select size of left sub-region to be at least
-		 * 10 percent and at most 90% of original region
-		 */
-		sz_left_region = ALIGN_DOWN(damon_rand(1, 10) * sz_orig_region
-					    / 10, MIN_REGION);
-		/* Do not allow blank region */
-		if (sz_left_region == 0 || sz_left_region >= sz_orig_region)
-			continue;
-
-		damon_split_region_at(ctx, r, sz_left_region);
+		sz_region = r->vm_end - r->vm_start;
+
+		for (i = 0; i < nr_subs - 1 &&
+				sz_region > 2 * MIN_REGION; i++) {
+			/*
+			 * Randomly select size of left sub-region to be at
+			 * least 10 percent and at most 90% of original region
+			 */
+			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
+					sz_region / 10, MIN_REGION);
+			/* Do not allow blank region */
+			if (sz_sub == 0 || sz_sub >= sz_region)
+				continue;
+
+			damon_split_region_at(ctx, r, sz_sub);
+			sz_region = sz_sub;
+		}
 	}
 }
 
@@ -687,14 +693,25 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	unsigned int nr_regions = 0;
+	static unsigned int last_nr_regions;
+	int nr_subregions = 2;
 
 	damon_for_each_task(t, ctx)
 		nr_regions += nr_damon_regions(t);
+
 	if (nr_regions > ctx->max_nr_regions / 2)
 		return;
 
+	/* If number of regions is not changed, we are maybe in corner case */
+	if (last_nr_regions == nr_regions &&
+			nr_regions < ctx->max_nr_regions / 3)
+		nr_subregions = 3;
+
 	damon_for_each_task(t, ctx)
-		damon_split_regions_of(ctx, t);
+		damon_split_regions_of(ctx, t, nr_subregions);
+
+	if (!last_nr_regions)
+		last_nr_regions = nr_regions;
 }
 
 /*
-- 
2.17.1

