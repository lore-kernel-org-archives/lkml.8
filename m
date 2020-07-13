Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7DC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0692065D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P+YFz5ZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgGMIpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:45:08 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:38084 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGMIpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594629908; x=1626165908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iorj5Y8DmflMMpGT/XFAXIVJdzZx6l8ogkdpERlrhpw=;
  b=P+YFz5ZJVgDN1irNh3QWNXFaIBEvtgLmjakvdAV8cmS1btcnOg09oZGM
   br0Ei9ST+Cm3yBUHQf90o4JCUQ6KIaSIcU58pS7T9BqE0XoNtpCRj6WSF
   JAdaZjIxo7hYkx8Ssnf5x+mVctfYi/c2CpxkM+tfbeHVWZJa9tAqqflz/
   k=;
IronPort-SDR: eHJAkfLsjVuuQpEvJ2u4OVaqKmLfMCHLMvwicBE0gPMJsP+IO8gc38w+zTBNHiOCk3y4B9R7sS
 PKzyLd4YScGA==
X-IronPort-AV: E=Sophos;i="5.75,346,1589241600"; 
   d="scan'208";a="59283459"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 13 Jul 2020 08:45:07 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 8830AA23CF;
        Mon, 13 Jul 2020 08:45:04 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 08:45:03 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.146) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Jul 2020 08:44:47 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v18 08/14] mm/damon: Add a tracepoint
Date:   Mon, 13 Jul 2020 10:41:38 +0200
Message-ID: <20200713084144.4430-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713084144.4430-1-sjpark@amazon.com>
References: <20200713084144.4430-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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
---
 include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
 mm/damon.c                   |  4 ++++
 2 files changed, 47 insertions(+)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..40b249a28b30
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
+	TP_PROTO(struct damon_task *t, struct damon_region *r,
+		unsigned int nr_regions),
+
+	TP_ARGS(t, r, nr_regions),
+
+	TP_STRUCT__entry(
+		__field(int, pid)
+		__field(unsigned int, nr_regions)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_accesses)
+	),
+
+	TP_fast_assign(
+		__entry->pid = t->pid;
+		__entry->nr_regions = nr_regions;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_accesses = r->nr_accesses;
+	),
+
+	TP_printk("pid=%d nr_regions=%u %lu-%lu: %u", __entry->pid,
+			__entry->nr_regions, __entry->start,
+			__entry->end, __entry->nr_accesses)
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon.c b/mm/damon.c
index 55ecfab64220..00df1a4c3d5c 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -19,6 +19,8 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#define CREATE_TRACE_POINTS
+
 #include <linux/damon.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
@@ -29,6 +31,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <trace/events/damon.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define MIN_REGION PAGE_SIZE
@@ -791,6 +794,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			damon_write_rbuf(c, &r->ar.end, sizeof(r->ar.end));
 			damon_write_rbuf(c, &r->nr_accesses,
 					sizeof(r->nr_accesses));
+			trace_damon_aggregated(t, r, nr);
 			r->nr_accesses = 0;
 		}
 	}
-- 
2.17.1

