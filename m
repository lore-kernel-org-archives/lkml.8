Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7BC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A5020842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dd6IDxbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgBJOwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:52:44 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:20792 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgBJOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581346363; x=1612882363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sf7A0vfw3cQq8bhnPOhHviH9Sodji4zlA3P2YYS4bnM=;
  b=dd6IDxbiAwruWbOZWHCl/ny2JQe3JNirOnBtlh4VdU20GG8CyrvKSepw
   VzUSznk4XoeESB51iKfRcY1MsC+6Cys6+BsJWMzFaHOCgTkoDVmNi0Lvu
   YQENYX4ALPe0xl3Jut8wDfPkmMbJrwBaxKWXy4dLHoJ04BYmwYWeoRwsb
   w=;
IronPort-SDR: frgHkJRMOFB8KaAC+ydJrMzf+Jit2A8V5ZGQDdePCRlnryGiuoKZTtj/aqka6umOxzdJUrlRIx
 n6EwplQIGy6g==
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="16473270"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Feb 2020 14:52:41 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 53AF3A2331;
        Mon, 10 Feb 2020 14:52:34 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 10 Feb 2020 14:52:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.69) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 10 Feb 2020 14:52:21 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 07/11] mm/damon: Add a tracepoint for result writing
Date:   Mon, 10 Feb 2020 15:52:06 +0100
Message-ID: <20200210145206.27950-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210144812.26845-1-sjpark@amazon.com>
References: <20200210144812.26845-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.69]
X-ClientProxiedBy: EX13D27UWB004.ant.amazon.com (10.43.161.101) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a tracepoint for DAMON's result buffer writing.  It is
called for each writing of the DAMON results and print the result data.
Therefore, it would be used to easily integrated with other tracepoint
supporting tracers such as perf.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/trace/events/damon.h | 32 ++++++++++++++++++++++++++++++++
 mm/damon.c                   |  4 ++++
 2 files changed, 36 insertions(+)
 create mode 100644 include/trace/events/damon.h

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
new file mode 100644
index 000000000000..fb33993620ce
--- /dev/null
+++ b/include/trace/events/damon.h
@@ -0,0 +1,32 @@
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
+TRACE_EVENT(damon_write_rbuf,
+
+	TP_PROTO(void *buf, const ssize_t sz),
+
+	TP_ARGS(buf, sz),
+
+	TP_STRUCT__entry(
+		__dynamic_array(char, buf, sz)
+	),
+
+	TP_fast_assign(
+		memcpy(__get_dynamic_array(buf), buf, sz);
+	),
+
+	TP_printk("dat=%s", __print_hex(__get_dynamic_array(buf),
+			__get_dynamic_array_len(buf)))
+);
+
+#endif /* _TRACE_DAMON_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/damon.c b/mm/damon.c
index 748cd8537fee..02bfa12940ea 100644
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
@@ -553,6 +556,7 @@ static void damon_flush_rbuffer(struct damon_ctx *ctx)
  */
 static void damon_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
 {
+	trace_damon_write_rbuf(data, size);
 	if (!ctx->rbuf_len || !ctx->rbuf)
 		return;
 	if (ctx->rbuf_offset + size > ctx->rbuf_len)
-- 
2.17.1

