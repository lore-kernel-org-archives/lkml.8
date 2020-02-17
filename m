Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A696C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F7820801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PrFstMcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgBQK2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:28:08 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4893 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbgBQK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581935288; x=1613471288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2A0fIhiQIF8O2W3n0VajhwOLYj4CtmccUcjYQ7yAt60=;
  b=PrFstMcEoXHoRNSG8RfJ2KH0aVUQh7LkHENBz/y2DbiYpw7BPrXORJ1A
   NYj8dU8KJAaepedcMkDGzyEz/yqXNT3gQUjV2SwLsgKtmfLfC17p4UXWW
   WxmEVeUnnUHMMG71vFI2y3yA15ypILzFK4hLhjbX67NIsfbaX4K9VX1QL
   A=;
IronPort-SDR: 0NKCf/iw94o7H5I8sETq4kAJX8V32mxW8+1nen47Oe5t/5fXgu23ijb/NOj6g1MkqBI/1K7NlH
 WSUWxDY3tr/Q==
X-IronPort-AV: E=Sophos;i="5.70,452,1574121600"; 
   d="scan'208";a="18057977"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 17 Feb 2020 10:28:04 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 5EE2E222874;
        Mon, 17 Feb 2020 10:28:01 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 17 Feb 2020 10:28:00 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Feb 2020 10:27:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 09/14] mm/damon: Add a tracepoint for result writing
Date:   Mon, 17 Feb 2020 11:25:39 +0100
Message-ID: <20200217102544.29012-10-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217102544.29012-1-sjpark@amazon.com>
References: <20200217102544.29012-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D30UWB004.ant.amazon.com (10.43.161.51) To
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
index 6deccab354e9..699b035eb9cc 100644
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

