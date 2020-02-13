Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A76C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCA1206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8031fcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgBMEXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:23:36 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41685 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMEXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:23:35 -0500
Received: by mail-pg1-f202.google.com with SMTP id z10so2908430pgz.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 20:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y/l4QcnQmnFHC9Qtzrj2Afn8rUnVhJiL0LNmFafuuSU=;
        b=f8031fcjT53HNVYPQmy3REJdJzaNg4KA0YlKgivEBB0IgusTy6l5NrDsjO+74g/3MO
         T/Vb0EDI1sxEx42SrmfdfLfjh4mPNxTPUp9WnQzU+a0BZrhqgSJ7dUnq3Ga2sVBjqkR6
         ssvzfFcNDEFLMRh4SQTE/ENZvF0Wg+BU4k20OnlQm8dUK2v9i5Wz6RtRNWtijgecAIW6
         jH+wI1UpJ0Jl4ul+BW1fYGBopP5gSWOTUelkXxn/EvSAO/JJ6DvL/LZiQSROH43LMsBh
         7XnNuXGRZxeyZ5UhalN78/amh/N3NAhsSV+v21huqPf3Q7xd1RW0ZU3FDjLvYiP/KaiA
         gfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y/l4QcnQmnFHC9Qtzrj2Afn8rUnVhJiL0LNmFafuuSU=;
        b=cJcn19PBS8vVQP+tHAnNAd/zMNl7cpAVaEGptadY9lMzTEdVfYj1/jlVYA6z8j2dAM
         2SSU/7XY0rWGjezJToxbn+rqLpXqIiAJazEB7HDyl9IcJcZg1bV2Fy2VDhdwr6XlWWha
         tRE8vK5e8h+fCYxbqAWtGIA3eRJfMGfIceMdO1/iuiVvk7Bx99wISww+wiHzm+n8K6vB
         xsz4iN8e1r3Iyr7svO5UhHXqoyBkMElEPMNGS8dkSif/omIVWgSQRF+8uUwfpx3URrip
         HufSoO/PBaDn2dh+wYTJ2UCRyFwW59gLIn+19vSh9jJGl8BxRxJtUJBTGFzsJBQ2NlOH
         qasw==
X-Gm-Message-State: APjAAAV1uNvRYbSlvDImVZBHWni4xw4olJ2Fht8mG7inIHLQd70A9AWd
        uBh31nNAqZwRYBkJpeGtkqrZ9AedFfY=
X-Google-Smtp-Source: APXvYqyr6m8cQz82vDkf58+STTVBDflPhp/EHbKYlIUwxat+GQenNnCGOf7c6sVmCb2xlV0X7sa3JOMNRTF1
X-Received: by 2002:a65:5a48:: with SMTP id z8mr15465779pgs.157.1581567815093;
 Wed, 12 Feb 2020 20:23:35 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:23:31 -0800
In-Reply-To: <20200212222922.5dfa9f36@oasis.local.home>
Message-Id: <20200213042331.157606-1-zzyiwei@google.com>
Mime-Version: 1.0
References: <20200212222922.5dfa9f36@oasis.local.home>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v3] gpu/trace: add gpu memory tracepoints
From:   zzyiwei@google.com
To:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc:     prahladk@google.com, joelaf@google.com, android-kernel@google.com,
        Yiwei Zhang <zzyiwei@google.com>
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
 drivers/Kconfig                   |  2 ++
 drivers/gpu/Makefile              |  1 +
 drivers/gpu/trace/Kconfig         |  4 +++
 drivers/gpu/trace/Makefile        |  3 ++
 drivers/gpu/trace/trace_gpu_mem.c | 13 +++++++
 include/trace/events/gpu_mem.h    | 57 +++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
 create mode 100644 drivers/gpu/trace/Kconfig
 create mode 100644 drivers/gpu/trace/Makefile
 create mode 100644 drivers/gpu/trace/trace_gpu_mem.c
 create mode 100644 include/trace/events/gpu_mem.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 8befa53f43be..e0eda1a5c3f9 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -200,6 +200,8 @@ source "drivers/thunderbolt/Kconfig"
 
 source "drivers/android/Kconfig"
 
+source "drivers/gpu/trace/Kconfig"
+
 source "drivers/nvdimm/Kconfig"
 
 source "drivers/dax/Kconfig"
diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index f17d01f076c7..835c88318cec 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
 obj-y			+= drm/ vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
+obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
new file mode 100644
index 000000000000..c24e9edd022e
--- /dev/null
+++ b/drivers/gpu/trace/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config TRACE_GPU_MEM
+	bool
diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
new file mode 100644
index 000000000000..b70fbdc5847f
--- /dev/null
+++ b/drivers/gpu/trace/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
diff --git a/drivers/gpu/trace/trace_gpu_mem.c b/drivers/gpu/trace/trace_gpu_mem.c
new file mode 100644
index 000000000000..01e855897b6d
--- /dev/null
+++ b/drivers/gpu/trace/trace_gpu_mem.c
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
diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
new file mode 100644
index 000000000000..1897822a9150
--- /dev/null
+++ b/include/trace/events/gpu_mem.h
@@ -0,0 +1,57 @@
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
+
+	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
+
+	TP_ARGS(gpu_id, pid, size),
+
+	TP_STRUCT__entry(
+		__field(uint32_t, gpu_id)
+		__field(uint32_t, pid)
+		__field(uint64_t, size)
+	),
+
+	TP_fast_assign(
+		__entry->gpu_id = gpu_id;
+		__entry->pid = pid;
+		__entry->size = size;
+	),
+
+	TP_printk("gpu_id=%u pid=%u size=%llu",
+		__entry->gpu_id,
+		__entry->pid,
+		__entry->size)
+);
+
+#endif /* _TRACE_GPU_MEM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.25.0.225.g125e21ebc7-goog

