Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1DFC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940B0207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u2yq+hny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgA1JCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:02:31 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:27096 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgA1JCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580202149; x=1611738149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=z7C/S/RWP33ETPldsEhKusX9dKMog8aafhVgJAy6/Ys=;
  b=u2yq+hnya3DSJwCG7i3LvlDDVWBquV2bByxAlVPx/pRvtes2QG+artkw
   VMqtwgAd8BVKV+8LH4Z7Cc7xNy1UTVjpakp81Wp7Tfhde7gCgGFh2ixGw
   rCZJDAT/4+3+OaBe3YBgQJHW+ciFyb4f0iA6qTa8HXZiGkjuviXlXzCWF
   g=;
IronPort-SDR: 9IbQglGsP8lDNbxz6GabTwkO4rdA6M8SDdDzkkxvVIj2lx/AWmx60p/x4EjVlahdZHT8dh+tVt
 MRzMvC14RREw==
X-IronPort-AV: E=Sophos;i="5.70,373,1574121600"; 
   d="scan'208";a="21494898"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 28 Jan 2020 09:02:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id E650AA17DE;
        Tue, 28 Jan 2020 09:02:22 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 28 Jan 2020 09:02:22 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.176) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 09:02:14 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <sj38.park@gmail.com>,
        <acme@kernel.org>, <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <corbet@lwn.net>, <dwmw@amazon.com>, <mgorman@suse.de>,
        <rostedt@goodmis.org>, <kirill@shutemov.name>,
        <brendanhiggins@google.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 9/9] mm/damon: Add a tracepoint for result buffer writing
Date:   Tue, 28 Jan 2020 10:01:58 +0100
Message-ID: <20200128090158.16234-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128085742.14566-1-sjpark@amazon.com>
References: <20200128085742.14566-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13d09UWA004.ant.amazon.com (10.43.160.158) To
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
 MAINTAINERS                  |  1 +
 include/trace/events/damon.h | 32 ++++++++++++++++++++++++++++++++
 mm/damon.c                   |  4 ++++
 3 files changed, 37 insertions(+)
 create mode 100644 include/trace/events/damon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cb091bee16c7..b912c659833d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4619,6 +4619,7 @@ F:	mm/damon.c
 F:	mm/damon-test.h
 F:	tools/damon/*
 F:	Documentation/admin-guide/mm/data_access_monitor.rst
+F:	include/trace/events/damon.h
 
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
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
index f21968f079f0..6a0d560d38e7 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -9,6 +9,8 @@
 
 #define pr_fmt(fmt) "damon: " fmt
 
+#define CREATE_TRACE_POINTS
+
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
@@ -19,6 +21,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/slab.h>
+#include <trace/events/damon.h>
 
 #define damon_get_task_struct(t) \
 	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
@@ -587,6 +590,7 @@ static void damon_write_rbuf(void *data, ssize_t size)
 		damon_flush_rbuffer();
 
 	memcpy(&damon_rbuf[damon_rbuf_offset], data, size);
+	trace_damon_write_rbuf(data, size);
 	damon_rbuf_offset += size;
 }
 
-- 
2.17.1

