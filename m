Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D883C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63029206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8jjNev0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgBMCUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:20:31 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33105 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgBMCUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:20:31 -0500
Received: by mail-pg1-f202.google.com with SMTP id 37so2733318pgq.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 18:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y/l4QcnQmnFHC9Qtzrj2Afn8rUnVhJiL0LNmFafuuSU=;
        b=a8jjNev0cAtvQsy9HtqJhXpl1rPdDdRKzdg63Z6Ih8/uNmbF5RSJ7rDsk3KUAvOQlC
         fJqFnm3SaqrIJsjxDVfrg9GMeWZqbi/FkiNM9hjArWEUeSTfRLN8kj8hbqKI/gr9348h
         Us3FDID9709cl7/RANdrRYjBIMqkLrwghRefi+Bxdxp+tUvEXw/YmToUG0Bqwt0beKue
         B9eiA1RHej9eEZW9T6Yp0TgYR4lzGJSbM/jnco5kEHKbstVfF2Vkay/1+W9MGQaO4H9A
         QsP7ZbspSoN/wzL6G0QRI5IwRpXPYo4ufJEjYfIUJoEAqRRux7cpocP40uBdgZWGr2mv
         mPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y/l4QcnQmnFHC9Qtzrj2Afn8rUnVhJiL0LNmFafuuSU=;
        b=fWVnWp455q1pN+9431mxuwKvdYxLyxLp1/Mai0Z5/lwZCjfThZJ31R49h+PLTa4yHs
         PPpsKxcYtUdwsmRGWR9huvHgwtKFtvF8UfEDr9TjOVUJCprjWpEc6dnKbO4Bro69A7W4
         yvj5LqI9eyLbdRs/JyC3vzpdT3PkcZrMlPs8RZUhoJDtioh4Yam1Gce0v4fykfqQ46PG
         vWGu2rhSi5G3/fAGV8+3qSj7VAf4YpTOY1kRPbbq/pE4ccNu/UII0vql8OCVc/Q/99Ti
         zM6qF+rbg7lmLbg1qLAXYNdFE6vMXxrPIaCYuep+n8AyvyiFPbj0Uwjgqod9/rOwQrNE
         OXUQ==
X-Gm-Message-State: APjAAAVf1DGCWV7ro1sPN8zhoCZqrPTHTek2YZN1GWIwJC0J0Vhfft5F
        rm6Jv54/YzGQeAg1WmZlcJWyxb1Ws80=
X-Google-Smtp-Source: APXvYqy7IIMh3YvNpp0r4l4skYTozPgWlM9g9VgGkBFwpDHB1YhNpFX/7jwu5L5f+QRy4ufkyQCwv0jjmWuD
X-Received: by 2002:a63:5f4e:: with SMTP id t75mr11596388pgb.7.1581560429408;
 Wed, 12 Feb 2020 18:20:29 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:20:20 -0800
In-Reply-To: <20200213003259.128938-1-zzyiwei@google.com>
Message-Id: <20200213022020.142379-1-zzyiwei@google.com>
Mime-Version: 1.0
References: <20200213003259.128938-1-zzyiwei@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2] Add gpu memory tracepoints
From:   zzyiwei@google.com
To:     rostedt@goodmis.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        elder@kernel.org, federico.vaga@cern.ch, tony.luck@intel.com,
        vilhelm.gray@gmail.com, linus.walleij@linaro.org,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org
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

