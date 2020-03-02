Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E04AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA26F2465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTlTzZOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCBXtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:49:15 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56670 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:49:15 -0500
Received: by mail-pl1-f202.google.com with SMTP id m1so727538pll.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 15:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=up9k0ELoc2nbld5DDuzluLMDE9ZGs9dXZH/M3N/0vIs=;
        b=cTlTzZOuRu8qbRKnk7EkJoSpCEQiXPyJqY1PCJN3iYerTkuC/m980uP+HeafGTunBe
         brZZYltraD/sehOJTbzll6BEkrr5ekwV/SGQPZBD47llMrt0XZNIx1x+Ai5b+tyno03a
         Fggrk+FQGIpHckSbyrHy+FlGpZl0JttKJDM7UE/ZJugSI8ZlAiyVhSGhmIVUfKxEjzeL
         aWyNdo/xT/8s/BWziCcLrhgOqK9HZaXBIdse+fCEmkCdex1xZtQ88JU+5LV73TnoRMOg
         q2Ie09SX28A9z4/e+RAWd5INR2ROyPwXDX+0coSORyh6Nuvv8nfacgsqGO1jMNgzNj1U
         RP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=up9k0ELoc2nbld5DDuzluLMDE9ZGs9dXZH/M3N/0vIs=;
        b=dJp+qWFOlW7iji9NwhkLsJlUtMS39kQhbwlr+GqBjJgR5X/IBaUQSykjEJUyHsOoN/
         utVgTENXxJDHV3+Lq3zH2hQHMV9oEsomWGk7KasjY7Z6DBrCn1QpATrMAhKt6FlYVwyg
         MzlSmCd4c25FUdoGD4JLxWuo27NrBMvy0i/oc91QEnNCq458FfGCf6HP/Wnj8EY/vmnQ
         d4k6usbYvupPpqmY2Vchg0A549I+7+EHMauU2xSaXkeMpaZrrxiRHexwNH5KPyo6lHeD
         k/vKNKg0JJ93o7lCq3NLytFDvS50Pj+gV+ChoDhyEQyioumzpqG001YCp/lgOgCp2RBV
         aFEA==
X-Gm-Message-State: ANhLgQ1XFrwWzg9PwFQUimwjfbV6rrkCi2Kn1v9l1L2ElSU1SV9HMF9W
        uROJc49oEyDOgHg2zLC6hhPJcjXrpGg=
X-Google-Smtp-Source: ADFU+vtnRMLqd8jVblj7Leu8qW+vfxlfA1sEO5Hkada1cnzy5s6z9T7p5/fPw0cTeHoJjFdxLuHyGTmjaUP/
X-Received: by 2002:a63:6dc5:: with SMTP id i188mr1293362pgc.82.1583192952483;
 Mon, 02 Mar 2020 15:49:12 -0800 (PST)
Date:   Mon,  2 Mar 2020 15:48:40 -0800
In-Reply-To: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
Message-Id: <20200302234840.57188-1-zzyiwei@google.com>
Mime-Version: 1.0
References: <CAKT=dDnFpj2hJd5z73pfcrhXXacDpPVyKzC7+K94tsX=+e_BHg@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] [PATCH v4] gpu/trace: add a gpu total memory usage tracepoint
From:   zzyiwei@google.com
To:     rostedt@goodmis.org, mingo@redhat.com, gregkh@linuxfoundation.org,
        elder@kernel.org, federico.vaga@cern.ch, tony.luck@intel.com,
        vilhelm.gray@gmail.com, linus.walleij@linaro.org,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        paul.walmsley@sifive.com, bhelgaas@google.com, darekm@google.com,
        ndesaulniers@google.com, joelaf@google.com,
        linux-kernel@vger.kernel.org
Cc:     prahladk@google.com, android-kernel@google.com,
        Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiwei Zhang <zzyiwei@google.com>

This change adds the below gpu memory tracepoint:
gpu_mem/gpu_mem_total: track global or proc gpu memory total usages

Per process tracking of total gpu memory usage in the gem layer is not
appropriate and hard to implement with trivial overhead. So for the gfx
device driver layer to track total gpu memory usage both globally and
per process in an easy and uniform way is to integrate the tracepoint in
this patch to the underlying varied implementations of gpu memory
tracking system from vendors.

Putting this tracepoint in the common trace events can not only help
wean the gfx drivers off of debugfs but also greatly help the downstream
Android gpu vendors because debugfs is to be deprecated in the upcoming
Android release. Then the gpu memory tracking of both Android kernel and
the upstream linux kernel can stay closely, which can benefit the whole
kernel eco-system in the long term.

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
2.25.0.265.gbab2e86ba0-goog

