Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4FCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1E42087C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tyceaYhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHMVEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHMVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B783C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l67so8180298ybb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bmdBV6Jzh5nQA31+72j4WQc5pXDxDNDeGqIRwkeUxIY=;
        b=tyceaYhNCjgbkosiDxBZ6sGDTUHGTqefBoF+et5erMgTWEAaxYa+fbIdHRd081nOz0
         mKU+QAr7KuRnnOOu4v0h7c+43Wa1k2FvfG/NYx3tQdLUTx5sU5DK5Rk7+Mfrh1q0emqt
         GChZ9VnOrGxfjYtxPI6NcLrQ70YMwBYlO36zkXgd6bXWsnrL2/6njk3Zo7kaBxw1XcYx
         t/WT2DZ+jEupxYy/i28rdZlv9AhmSrNzjYW1W0USCM4POxSYcom4dsPKQLSV7aGKaE2g
         7VE8ejveOtcMlmvbEyGQw9EZhvBBUxfhaYmc4EtDfdSYGUvyS63eppYfnZ0EfVOlEMfJ
         cOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bmdBV6Jzh5nQA31+72j4WQc5pXDxDNDeGqIRwkeUxIY=;
        b=Z4NyJUs3eE7quIev2Wwzl6As/9CqemwFw2yTEZY28357rTGk+ORCdV01EpSYEFK9bS
         y0lAQx4D5LTvRR36a0ZCbj4uXDKc4OUmKFJpchUHD1vXvzkE8l79k3BhL6c1XHsnDotM
         3yiEq5Mz6PZTbmqVorJFy92CPaZDXx8jqAn8x6jAfv3bKAy1l/diRUvHh6ArSrqtSLfE
         zEn/bFW6mnKB7DVgzpcURPCiR32qW9PJOOvHYBIHh2csTLtqwRwVnR13iuHBLw3Fjjce
         heemHIjImwlwLOnci8KqzUxdD/CWLmDAi0MXlw1Sj4P47zPQ1j78NXLXh/EcVRe8V2xS
         bYaA==
X-Gm-Message-State: AOAM533Xebsj8RifjmWImZR47EkdAei/0KIYHChVHA5M25Gd4hfKWFYo
        b1yNSA03Zh9Ugz7NOBjRD1QHujY=
X-Google-Smtp-Source: ABdhPJzxd6MpB54ckn/22cqb7G3gVna+QODcXO+KQ/4L9yqXhcT2jsCn2hH3+FR/L9Lhyrxdi/GyKxg=
X-Received: by 2002:a5b:308:: with SMTP id j8mr9142230ybp.185.1597352677521;
 Thu, 13 Aug 2020 14:04:37 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:03:57 -0700
Message-Id: <20200813210357.146936-1-lpy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] Add power/gpu_frequency tracepoint.
From:   Peiyong Lin <lpy@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Peiyong Lin <lpy@google.com>
Cc:     prahladk@google.com, android-kernel@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically there is no common trace event for GPU frequency, in
downstream Android each different hardware vendor implements their own
way to expose GPU frequency, for example as a debugfs node.  This patch
standardize it as a common trace event in upstream linux kernel to help
the ecosystem have a common implementation across hardware vendors.
Toolings in the Linux ecosystem will benefit from this especially in the
downstream Android, where this information is critical to graphics
developers.

Signed-off-by: Peiyong Lin <lpy@google.com>
---
 drivers/gpu/Makefile                    |  1 +
 drivers/gpu/trace/Kconfig               |  3 +++
 drivers/gpu/trace/Makefile              |  1 +
 drivers/gpu/trace/trace_gpu_frequency.c | 13 +++++++++++++
 include/trace/events/power.h            | 26 +++++++++++++++++++++++++
 5 files changed, 44 insertions(+)
 create mode 100644 drivers/gpu/trace/trace_gpu_frequency.c

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..f289a47eb031 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
 obj-y			+= drm/ vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
+obj-$(CONFIG_TRACE_GPU_FREQUENCY)		+= trace/
diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
index c24e9edd022e..ac4aec8d5845 100644
--- a/drivers/gpu/trace/Kconfig
+++ b/drivers/gpu/trace/Kconfig
@@ -2,3 +2,6 @@
 
 config TRACE_GPU_MEM
 	bool
+
+config TRACE_GPU_FREQUENCY
+	bool
diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
index b70fbdc5847f..2b7ae69327d6 100644
--- a/drivers/gpu/trace/Makefile
+++ b/drivers/gpu/trace/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
+obj-$(CONFIG_TRACE_GPU_FREQUENCY) += trace_gpu_frequency.o
diff --git a/drivers/gpu/trace/trace_gpu_frequency.c b/drivers/gpu/trace/trace_gpu_frequency.c
new file mode 100644
index 000000000000..f5af5800b52d
--- /dev/null
+++ b/drivers/gpu/trace/trace_gpu_frequency.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPU frequency trace points
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/power.h>
+
+EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index af5018aa9517..befc0157131e 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -500,6 +500,32 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+/**
+ * gpu_frequency - Reports frequency changes in GPU clock domains
+ * @state:  New frequency (in KHz)
+ * @gpu_id: GPU clock domain
+ */
+TRACE_EVENT(gpu_frequency,
+
+	TP_PROTO(unsigned int state, unsigned int gpu_id),
+
+	TP_ARGS(state, gpu_id),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, state)
+		__field(unsigned int, gpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->gpu_id = gpu_id;
+	),
+
+	TP_printk("state=%lu gpu_id=%lu",
+		(unsigned long)__entry->state,
+		(unsigned long)__entry->gpu_id)
+);
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.28.0.220.ged08abb693-goog

