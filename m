Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B976BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE0A22B47
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uIwQUetn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgDFNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:16:31 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:4761 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgDFNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586178990; x=1617714990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Bqx9bwtW2DodnT7nZ6v8smsi9CDUXdUuFOlLvH4J/6Y=;
  b=uIwQUetnjOR7OW6gtpSvNRBqYqLOx4xWLeYsxDI57hO2iqpcI3FnfLwD
   JttawdwBxJ5sdBtCoXaJ4QrlD20Dn8G+1hjD27mRfxMU/+1lEEdWNY1v3
   CNoGMh6FPARgzEPWFnJ1mbO+KZd8SItmbxkZFKvSXdJralD4lT2o6FI+f
   s=;
IronPort-SDR: SbuLSVIKH+9gdrgTLK8jxyTWOlc9rxLLbmpT3pADPIk0ipcA1nCt0RAGYEbvbpu99GkcRHtVFY
 yN6R3XQV53PA==
X-IronPort-AV: E=Sophos;i="5.72,351,1580774400"; 
   d="scan'208";a="24415376"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 06 Apr 2020 13:16:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id F1D4BA2616;
        Mon,  6 Apr 2020 13:16:18 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:16:18 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:16:04 +0000
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
Subject: [PATCH v8 10/15] mm/damon: Add tracepoints
Date:   Mon, 6 Apr 2020 15:09:33 +0200
Message-ID: <20200406130938.14066-11-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406130938.14066-1-sjpark@amazon.com>
References: <20200406130938.14066-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D11UWB003.ant.amazon.com (10.43.161.206) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a tracepoint for DAMON.  It traces the monitoring
results of each region for each aggregation interval.  Using this, DAMON
will be easily integrated with any tracepoints supporting tools such as
perf.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
 mm/damon.c                   |  5 +++++
 2 files changed, 48 insertions(+)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..bec3501f2b05
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
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(damon_aggregated,
+
+	TP_PROTO(unsigned long pid, unsigned int nr_regions,
+		unsigned long vm_start, unsigned long vm_end,
+		unsigned int nr_accesses),
+
+	TP_ARGS(pid, nr_regions, vm_start, vm_end, nr_accesses),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pid)
+		__field(unsigned int, nr_regions)
+		__field(unsigned long, vm_start)
+		__field(unsigned long, vm_end)
+		__field(unsigned int, nr_accesses)
+	),
+
+	TP_fast_assign(
+		__entry->pid = pid;
+		__entry->nr_regions = nr_regions;
+		__entry->vm_start = vm_start;
+		__entry->vm_end = vm_end;
+		__entry->nr_accesses = nr_accesses;
+	),
+
+	TP_printk("pid=%lu nr_regions=%u %lu-%lu: %u", __entry->pid,
+			__entry->nr_regions, __entry->vm_start,
+			__entry->vm_end, __entry->nr_accesses)
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon.c b/mm/damon.c
index 1712ce8a88a5..eb0dca2c899c 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,6 +9,8 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#define CREATE_TRACE_POINTS
+
 #include <linux/damon.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -20,6 +22,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <trace/events/damon.h>
 
 #define damon_get_task_struct(t) \
 	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
@@ -654,6 +657,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
 			damon_write_rbuf(c, &r->nr_accesses,
 					sizeof(r->nr_accesses));
+			trace_damon_aggregated(t->pid, nr,
+					r->vm_start, r->vm_end, r->nr_accesses);
 			r->nr_accesses = 0;
 		}
 	}
-- 
2.17.1

