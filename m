Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB9AC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93AA2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erOgFemT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBKBQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:16:39 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53699 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBKBQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:16:38 -0500
Received: by mail-pl1-f202.google.com with SMTP id 2so3851511plb.20
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 17:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0vQIviaVyQGTxEoHjDe+4QBGkh+tsuhUUhnSBjm5sYY=;
        b=erOgFemT8fsx8nk4+vFHvnE8sJJcjaGKlLp0GM3B5eARKjIEprS2uDyZuBXjwbAv14
         X7TA8zww4S3YC24W4Oau+rHeDgvx88+sSBB9qZ2bnN4AHT70f1g2bDMosIrw5XWPK810
         EIXCdQzbiIIvSHvtiZuG1guIx8Acq8JjT4kxEWaWaoxIx9Tvm5drx35G9yzxhaFny9/n
         Ec2q0WEPnPfoG+vGyvmr+aOCLkop1/4wnpwrXaNcO6KpP8NCF60f5NvVOPzihMRFtzmw
         PJm7RHfRUdXHz5btPaQavb8oGtbs7U5s4GrLTvHidP07oRVkHrv13GoryV4/eBlyvhFy
         I3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0vQIviaVyQGTxEoHjDe+4QBGkh+tsuhUUhnSBjm5sYY=;
        b=M0SZ6glqYlfMBL/yzCjt708fZcZFf2z6fO9gAq45i6b+SZHdJpcbZ9fzXRb6+rnBLM
         0dF8zSYip/IpAJtlzBd/LpZqp1s4E//qnXWP9voaDGyE8YyoMoXOtrPqtjkL6072OhNJ
         JuCBSOu+Wl4jhto9Z7s1ItGLd+1zuiy1s7yaQSMxstSjT2pJYdKrR9LZfWWvzqBbUWwQ
         wCx55LtO5/Vfw2FSw1uPJPENo7U7fr4Mesl+A8RA4kvhHVx9A1XD3w3XTqUMBvEh4guL
         d4CmM/lFj2f/Q4tD6jvd3yAtGVBgcoTw5hDhn98sOvG6QJlWeMchHUNl1hzILwkq18ZJ
         Lung==
X-Gm-Message-State: APjAAAXbl278eIa3f0pxPgGBWmBJPWSOGrukk12lwcC+nTRakLrQtQHg
        FNw36npajNFFPjmPce6wt4FqFq3IJ+w=
X-Google-Smtp-Source: APXvYqxddiCGQC5df7gmnBU1zGqYYXATmYqCt6KPj1uqqZEwW21RNNnRYIibEqSvMTsx+Sn/0z94hDZPJe4O
X-Received: by 2002:a63:f648:: with SMTP id u8mr4435924pgj.148.1581383797601;
 Mon, 10 Feb 2020 17:16:37 -0800 (PST)
Date:   Mon, 10 Feb 2020 17:16:31 -0800
Message-Id: <20200211011631.7619-1-zzyiwei@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] Add gpu memory tracepoints
From:   zzyiwei@google.com
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiwei Zhang <zzyiwei@google.com>

This change adds the below gpu memory tracepoint:
gpu_mem/gpu_mem_total: track global or process gpu memory total counters

Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
---
 include/trace/events/gpu_mem.h | 64 ++++++++++++++++++++++++++++++++++
 kernel/trace/Kconfig           |  3 ++
 kernel/trace/Makefile          |  1 +
 kernel/trace/trace_gpu_mem.c   | 13 +++++++
 4 files changed, 81 insertions(+)
 create mode 100644 include/trace/events/gpu_mem.h
 create mode 100644 kernel/trace/trace_gpu_mem.c

diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
new file mode 100644
index 000000000000..3b632a2b5100
--- /dev/null
+++ b/include/trace/events/gpu_mem.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GPU memory trace points
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM gpu_mem
+
+#if !defined(_TRACE_GPU_MEM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_GPU_MEM_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * The gpu_memory_total event indicates that there's an update to either the
+ * global or process total gpu memory counters.
+ *
+ * This event should be emitted whenever the kernel device driver allocates,
+ * frees, imports, unimports memory in the GPU addressable space.
+ *
+ * @gpu_id: This is the gpu id.
+ *
+ * @pid: Put 0 for global total, while positive pid for process total.
+ *
+ * @size: Virtual size of the allocation in bytes.
+ *
+ */
+TRACE_EVENT(gpu_mem_total,
+	TP_PROTO(
+		uint32_t gpu_id,
+		uint32_t pid,
+		uint64_t size
+	),
+	TP_ARGS(
+		gpu_id,
+		pid,
+		size
+	),
+	TP_STRUCT__entry(
+		__field(uint32_t, gpu_id)
+		__field(uint32_t, pid)
+		__field(uint64_t, size)
+	),
+	TP_fast_assign(
+		__entry->gpu_id = gpu_id;
+		__entry->pid = pid;
+		__entry->size = size;
+	),
+	TP_printk(
+		"gpu_id=%u "
+		"pid=%u "
+		"size=%llu",
+		__entry->gpu_id,
+		__entry->pid,
+		__entry->size
+	)
+);
+
+#endif /* _TRACE_GPU_MEM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 91e885194dbc..cb404755b0a6 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -85,6 +85,9 @@ config EVENT_TRACING
 config CONTEXT_SWITCH_TRACER
 	bool
 
+config TRACE_GPU_MEM
+	bool
+
 config RING_BUFFER_ALLOW_SWAP
 	bool
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f9dcd19165fa..267985313dca 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
 obj-$(CONFIG_KPROBE_EVENT_GEN_TEST) += kprobe_event_gen_test.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
+obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
 obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
 obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
diff --git a/kernel/trace/trace_gpu_mem.c b/kernel/trace/trace_gpu_mem.c
new file mode 100644
index 000000000000..01e855897b6d
--- /dev/null
+++ b/kernel/trace/trace_gpu_mem.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPU memory trace points
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/gpu_mem.h>
+
+EXPORT_TRACEPOINT_SYMBOL(gpu_mem_total);
-- 
2.25.0.341.g760bfbb309-goog

