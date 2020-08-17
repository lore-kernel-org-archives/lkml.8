Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF22C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD6D2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="laNY22kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHQK4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:56:31 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:24588 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgHQKzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597661724; x=1629197724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6NvUzrujb89qsZsHyhVnjbsbayGnmDOoQYD6DeYjvPw=;
  b=laNY22kGvW4MS++B9GdMIu5tnnBDUepMBgGKyRosrinKx9FcExIbjnlm
   D5T8a0dzkdD1NEmTQo3w0MMau3uDGqcGiHbh+ALueXEueqZDe4Xhah29g
   RLC0Z7DrYshl7w8qtQ4sekIMOs3NnA89U9Idl8kAvoHnXfR2wWetRJA7K
   Q=;
X-IronPort-AV: E=Sophos;i="5.76,322,1592870400"; 
   d="scan'208";a="48182204"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 17 Aug 2020 10:55:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 72382C06EF;
        Mon, 17 Aug 2020 10:55:12 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:55:11 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.192) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 10:54:54 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 08/15] mm/damon: Add a tracepoint
Date:   Mon, 17 Aug 2020 12:51:30 +0200
Message-ID: <20200817105137.19296-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817105137.19296-1-sjpark@amazon.com>
References: <20200817105137.19296-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.192]
X-ClientProxiedBy: EX13D02UWC004.ant.amazon.com (10.43.162.236) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a tracepoint for DAMON.  It traces the monitoring
results of each region for each aggregation interval.  Using this, DAMON
can easily integrated with tracepoints supporting tools such as perf.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
 mm/damon.c                   |  4 ++++
 2 files changed, 47 insertions(+)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..2f422f4f1fb9
--- /dev/null
+++ b/include/trace/events/damon.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM damon
+
+#if !defined(_TRACE_DAMON_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DAMON_H
+
+#include <linux/damon.h>
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(damon_aggregated,
+
+	TP_PROTO(struct damon_target *t, struct damon_region *r,
+		unsigned int nr_regions),
+
+	TP_ARGS(t, r, nr_regions),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, target_id)
+		__field(unsigned int, nr_regions)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_accesses)
+	),
+
+	TP_fast_assign(
+		__entry->target_id = t->id;
+		__entry->nr_regions = nr_regions;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_accesses = r->nr_accesses;
+	),
+
+	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
+			__entry->target_id, __entry->nr_regions,
+			__entry->start, __entry->end, __entry->nr_accesses)
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon.c b/mm/damon.c
index fed35f7b3879..e52e107c90fd 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -32,6 +32,9 @@
 #include <linux/sched/task.h>
 #include <linux/slab.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/damon.h>
+
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define MIN_REGION PAGE_SIZE
 
@@ -870,6 +873,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			damon_write_rbuf(c, &r->ar.end, sizeof(r->ar.end));
 			damon_write_rbuf(c, &r->nr_accesses,
 					sizeof(r->nr_accesses));
+			trace_damon_aggregated(t, r, nr);
 			r->nr_accesses = 0;
 		}
 	}
-- 
2.17.1

