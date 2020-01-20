Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E0C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEB8217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RmcoRByR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgATQ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:29:06 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:45832 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579537740; x=1611073740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=izvBTIQXa2EvAogeErXSklqQs4ieTuQHhNTxNOQYoGk=;
  b=RmcoRByRxHfu1q7x8aFSteXDJI/hMb239z75FCeP3vvJ1S8f8X72Pp6A
   /IyTlwoFQU6gvrMI17zsElsbswz9WiOMevBCf2gfyk9nehtjxudaaApOr
   S6mZoeH42WOWecsF44fZRup5nLeCCQ7HY7aMKUGnyE0GybdWHIFj3KyxO
   M=;
IronPort-SDR: FJdhGH/wWsoJC2iw6OFie3zwBucIuPjzdDcVFkGAx9FVa0L4e5+TYiiPKSkKj2KltK0es0lGFH
 n7meafouL+sA==
X-IronPort-AV: E=Sophos;i="5.70,342,1574121600"; 
   d="scan'208";a="12341486"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 20 Jan 2020 16:28:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id E43ACA2026;
        Mon, 20 Jan 2020 16:28:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 20 Jan 2020 16:28:57 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.253) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 Jan 2020 16:28:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <brendan.d.gregg@gmail.com>, <corbet@lwn.net>, <mgorman@suse.de>,
        <dwmw@amazon.com>, <amit@kernel.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/8] mm/damon: Apply dynamic memory mapping changes
Date:   Mon, 20 Jan 2020 17:27:53 +0100
Message-ID: <20200120162757.32375-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120162757.32375-1-sjpark@amazon.com>
References: <20200120162757.32375-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D14UWC002.ant.amazon.com (10.43.162.214) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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
 mm/damon.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 5012d8c25b8b..9252a2ba825d 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -63,14 +63,18 @@ static LIST_HEAD(damon_tasks_list);
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
 static unsigned long sample_interval = 5 * 1000;
 static unsigned long aggr_interval = 100 * 1000;
+static unsigned long regions_update_interval = 1000 * 1000;
 
 static struct timespec64 last_aggregate_time;
+static struct timespec64 last_regions_update_time;
 
 static unsigned long min_nr_regions = 10;
 static unsigned long max_nr_regions = 1000;
@@ -726,6 +730,87 @@ static void kdamond_split_regions(void)
 		damon_split_regions_of(t);
 }
 
+/*
+ * Check whether it is time to check and apply the dynamic mmap changes
+ *
+ * Returns true if it is.
+ */
+static bool kdamond_need_update_regions(void)
+{
+	return damon_check_reset_time_interval(&last_regions_update_time,
+			regions_update_interval);
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
+static void damon_apply_three_regions(struct damon_task *t,
+				struct region bregions[3])
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
+			newr = damon_new_region(br->start, br->end);
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
+static void kdamond_update_regions(void)
+{
+	struct region three_regions[3];
+	struct damon_task *t;
+
+	damon_for_each_task(t) {
+		if (damon_three_regions_of(t, three_regions))
+			continue;
+		damon_apply_three_regions(t, three_regions);
+	}
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -789,6 +874,9 @@ static int kdamond_fn(void *data)
 			kdamond_split_regions();
 		}
 
+		if (kdamond_need_update_regions())
+			kdamond_update_regions();
+
 		usleep_range(sample_interval, sample_interval + 1);
 	}
 	damon_flush_rbuffer();
@@ -895,6 +983,7 @@ static long damon_set_pids(unsigned long *pids, ssize_t nr_pids)
  *
  * sample_int		time interval between samplings
  * aggr_int		time interval between aggregations
+ * regions_update_int	time interval between vma update checks
  * min_nr_reg		minimal number of regions
  * max_nr_reg		maximum number of regions
  * path_to_rfile	path to the monitor result files
@@ -905,7 +994,7 @@ static long damon_set_pids(unsigned long *pids, ssize_t nr_pids)
  * Returns 0 on success, negative error code otherwise.
  */
 static long damon_set_attrs(unsigned long sample_int,
-		unsigned long aggr_int,
+		unsigned long aggr_int, unsigned long regions_update_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg,
 		char *path_to_rfile)
 {
@@ -927,6 +1016,7 @@ static long damon_set_attrs(unsigned long sample_int,
 
 	sample_interval = sample_int;
 	aggr_interval = aggr_int;
+	regions_update_interval = regions_update_int;
 	min_nr_regions = min_nr_reg;
 	max_nr_regions = max_nr_reg;
 	strncpy(rfile_path, path_to_rfile, LEN_RES_FILE_PATH);
@@ -939,6 +1029,7 @@ static int __init damon_init(void)
 
 	prandom_seed_state(&rndseed, 42);
 	ktime_get_coarse_ts64(&last_aggregate_time);
+	last_regions_update_time = last_aggregate_time;
 	return 0;
 }
 
-- 
2.17.1

