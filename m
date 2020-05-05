Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA548C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965D9206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s/xuDIcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgEELLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:11:11 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14616 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgEELLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588677071; x=1620213071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TKgQmoq0qPNsadPuOq3WWml7xxrCQ3BmjP+Fo2xEHow=;
  b=s/xuDIcEzV882r+ySNBk8XRr/WdTbHmMX8gqkbIMN2IEqa+yXYAxDAe6
   C5k5/KKxU0L4hvangbahHGNvEv8WKvMQD5ONDKCQl9nDk0jJcWE2s175Y
   5EXTX9At64bfxWLFCkxR1eWFpevXQvTNYizuvbaEAy9vbDB0p3zNOTpEW
   I=;
IronPort-SDR: sI+Jet086vj+evGLez67MFVCcTXZIdRMxpHDo/o8B1c2Sc/+ApqRXx4p+daesEXDSehJx8GVqc
 jqMYCny2pSoQ==
X-IronPort-AV: E=Sophos;i="5.73,354,1583193600"; 
   d="scan'208";a="42752730"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 May 2020 11:11:10 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 53BFE1A0A61;
        Tue,  5 May 2020 11:11:07 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 11:11:06 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.92) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 11:10:51 +0000
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
Subject: [PATCH v10 06/16] mm/damon: Split regions into 4 subregions if possible
Date:   Tue, 5 May 2020 13:08:05 +0200
Message-ID: <20200505110815.10532-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505110815.10532-1-sjpark@amazon.com>
References: <20200505110815.10532-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.92]
X-ClientProxiedBy: EX13D35UWB004.ant.amazon.com (10.43.161.230) To
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

This commit modifies the logic to split each region to 4 subregions if
possible so that such problematic region can eventually identified.

Suggested-by: James Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index cec946197e13..342f905927a0 100644
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
 
@@ -687,14 +693,18 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 {
 	struct damon_task *t;
 	unsigned int nr_regions = 0;
+	int nr_subregions = 2;
 
 	damon_for_each_task(ctx, t)
 		nr_regions += nr_damon_regions(t);
 	if (nr_regions > ctx->max_nr_regions / 2)
 		return;
 
+	if (nr_regions < ctx->max_nr_regions / 4)
+		nr_subregions = 4;
+
 	damon_for_each_task(ctx, t)
-		damon_split_regions_of(ctx, t);
+		damon_split_regions_of(ctx, t, nr_subregions);
 }
 
 /*
-- 
2.17.1

