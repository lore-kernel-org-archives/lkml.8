Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7BB20757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VnR9flOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgFBNNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:13:30 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52091 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBNN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591103608; x=1622639608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8JGBy8gZAjCRLD5i3p6YmN4Jl57pC+5KaEYiBGwvMNo=;
  b=VnR9flOFu3zjishZ5hRq91O80l4qhJu+SBjN3PdUC7b3KCkdJKIbNpmj
   ChHtT3WckiprnF6aKoSIT0vZWbRsj6ZtPtdLA+nbXoC3ADbLifC5O5izX
   rB1qpsoYx1NisN3ovnTvjvWDaL1K6h9+kLKAtEVadzohBlTO8OeRMEC0Q
   k=;
IronPort-SDR: Ouvqh5524HgVpj23Vpn6Kc8yqAW9izadPSzizcDGx/+pzeLsG47GLEtR3CAT7DLTQvd77enBhw
 5/zLzrvJR/BA==
X-IronPort-AV: E=Sophos;i="5.73,464,1583193600"; 
   d="scan'208";a="33962858"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Jun 2020 13:13:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 8588FA1DAF;
        Tue,  2 Jun 2020 13:13:22 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 13:13:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.48) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Jun 2020 13:13:05 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 09/15] mm/damon: Add tracepoints
Date:   Tue, 2 Jun 2020 15:12:49 +0200
Message-ID: <20200602131249.22765-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602130125.20467-1-sjpark@amazon.com>
References: <20200602130125.20467-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D41UWB002.ant.amazon.com (10.43.161.109) To
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
Reviewed-by: Leonard Foerster <foersleo@amazon.de>
---
 include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
 mm/damon.c                   |  5 +++++
 2 files changed, 48 insertions(+)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..22236642d366
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
+	TP_PROTO(int pid, unsigned int nr_regions,
+		unsigned long vm_start, unsigned long vm_end,
+		unsigned int nr_accesses),
+
+	TP_ARGS(pid, nr_regions, vm_start, vm_end, nr_accesses),
+
+	TP_STRUCT__entry(
+		__field(int, pid)
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
+	TP_printk("pid=%d nr_regions=%u %lu-%lu: %u", __entry->pid,
+			__entry->nr_regions, __entry->vm_start,
+			__entry->vm_end, __entry->nr_accesses)
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon.c b/mm/damon.c
index 6b0b8f21a6c6..af6f395fe06c 100644
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
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define MIN_REGION PAGE_SIZE
@@ -650,6 +653,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
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

