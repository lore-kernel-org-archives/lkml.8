Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73F720787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CYaRrEKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgEZIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:00:28 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:39751 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgEZIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590480027; x=1622016027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=UhuFz5/PVwHP7A8t6OOk+6Z1C3gPVbE/vJE89mGH7rk=;
  b=CYaRrEKkzLGGWdRqeItYHOCchymQ1d2Wej3UcscrekaVgoCMkcNut2u7
   wwSdK+WEqSQtXRSNsiySN0tgfH6bPuf8wR365r3rN/72uRJJRme02Ikto
   +8tQscwhxcneIV304WYSiPaTf8TEXj1G7f7MsVRqL7eDsBqUFC3ehtmGt
   0=;
IronPort-SDR: aqs/bkFlUMjxx+PvYffDA8AduqNToMWqfH5wwz42ycexg2UwvVc1D5oMYAYhYUsod2FE3jzyYd
 Lf+KWBCnH20g==
X-IronPort-AV: E=Sophos;i="5.73,436,1583193600"; 
   d="scan'208";a="33537801"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 26 May 2020 08:00:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 8FB05A119D;
        Tue, 26 May 2020 08:00:15 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 07:59:49 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.193) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 May 2020 07:59:31 +0000
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
Subject: [RFC v9 2/8] mm/damon: Account age of target regions
Date:   Tue, 26 May 2020 09:56:56 +0200
Message-ID: <20200526075702.27339-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526075702.27339-1-sjpark@amazon.com>
References: <20200526075702.27339-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.193]
X-ClientProxiedBy: EX13D08UWB004.ant.amazon.com (10.43.161.232) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

DAMON can be used as a primitive for data access pattern aware memory
management optimizations.  However, users who want such optimizations
should run DAMON, read the monitoring results, analyze it, plan a new
memory management scheme, and apply the new scheme by themselves.  It
would not be too hard, but still require some level of effort.  For
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
DAMON compares the access frequency with that from last aggregation and
reset the age of the region if the change is significant.  Else, the age
is incremented.  Also, in case of the merge of regions, the region
size-weighted average of the ages is set as the age of merged new
region.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 10 ++++++++++
 mm/damon.c            | 29 +++++++++++++++++++++--------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 31d436fd2843..7dafbcf86795 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -24,6 +24,13 @@
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
  * @list:		List head for siblings.
+ * @age:		Age of this region.
+ * @last_nr_accesses:	Internal value for age calculation.
+ *
+ * @age is initially zero, increased for each aggregation interval, and reset
+ * to zero again if the access frequency is significantly changed.  If two
+ * regions are merged into a new region, both @nr_accesses and @age of the new
+ * region are set as region size-weighted average of those of the two regions.
  */
 struct damon_region {
 	unsigned long vm_start;
@@ -31,6 +38,9 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	struct list_head list;
+
+	unsigned int age;
+	unsigned int last_nr_accesses;
 };
 
 /**
diff --git a/mm/damon.c b/mm/damon.c
index 76eca256a8ae..25d4ad98dc3b 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -86,6 +86,9 @@ static struct damon_region *damon_new_region(struct damon_ctx *ctx,
 	region->nr_accesses = 0;
 	INIT_LIST_HEAD(&region->list);
 
+	region->age = 0;
+	region->last_nr_accesses = 0;
+
 	return region;
 }
 
@@ -659,6 +662,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 					sizeof(r->nr_accesses));
 			trace_damon_aggregated(t->pid, nr,
 					r->vm_start, r->vm_end, r->nr_accesses);
+			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
 	}
@@ -672,9 +676,11 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
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
@@ -692,12 +698,16 @@ static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
-		if (!prev || prev->vm_end != r->vm_start ||
-		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
+		if (diff_of(r->nr_accesses, r->last_nr_accesses) > thres)
+			r->age = 0;
+		else
+			r->age++;
+
+		if (prev && prev->vm_end == r->vm_start &&
+		    diff_of(prev->nr_accesses, r->nr_accesses) <= thres)
+			damon_merge_two_regions(prev, r);
+		else
 			prev = r;
-			continue;
-		}
-		damon_merge_two_regions(prev, r);
 	}
 }
 
@@ -733,6 +743,9 @@ static void damon_split_region_at(struct damon_ctx *ctx,
 	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
 	r->vm_end = new->vm_start;
 
+	new->age = r->age;
+	new->last_nr_accesses = r->last_nr_accesses;
+
 	damon_insert_region(new, r, damon_next_region(r));
 }
 
-- 
2.17.1

